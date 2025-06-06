import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/kick/kick_category_dto.dart';
import 'package:irllink/src/data/entities/kick/kick_channel_dto.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';
import 'package:irllink/src/domain/usecases/kick/ban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_categories_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/post_kick_chat_nessage_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/unban_kick_user_usecase.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class KickRemoteDataSource {
  Future<Map<String, dynamic>> getKickOauth(KickAuthParams params);
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken);
  Future<void> logout(String accessToken);
  Future<KickUserDTO> getKickUser(String accessToken);
  Future<Either<Failure, List<KickCategoryDTO>>> getCategories({
    required KickCategoriesParams params,
  });
  Future<Either<Failure, List<KickChannelDto>>> getChannels({
    required String accessToken,
  });
  Future<Either<Failure, KickChannelDto>> patchChannel(
    String accessToken,
    String streamTitle,
    String categoryId,
  );
  Future<Either<Failure, void>> sendChatMessage(
    PostKickChatMessageParams params,
  );
  Future<Either<Failure, void>> banUser(
    BanKickUserParams params,
  );
  Future<Either<Failure, void>> unbanUser(
    UnbanKickUserParams params,
  );
}

class KickRemoteDataSourceImpl implements KickRemoteDataSource {
  final Dio dioClient;
  final Talker talker;

  KickRemoteDataSourceImpl({
    required this.dioClient,
    required this.talker,
  });

  @override
  Future<Map<String, dynamic>> getKickOauth(KickAuthParams params) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );
    await remoteConfig.fetchAndActivate();
    String redirectUri = remoteConfig.getString('irllink_kick_auth_url');
    String tokenUrl = remoteConfig.getString('irllink_kick_token_url');
    if (kDebugMode) {
      redirectUri = remoteConfig.getString('irllink_kick_auth_url_dev');
      tokenUrl = remoteConfig.getString('irllink_kick_token_url_dev');
    }

    final url = Uri.https(kKickAuthUrlBase, kKickAuthUrlPath, {
      'client_id': params.clientId,
      'redirect_uri': redirectUri,
      'response_type': params.responseType,
      'scope': params.scopes,
      'state': params.state,
      'code_challenge': params.codeChallenge,
      'code_challenge_method': params.codeChallengeMethod,
    });

    final result = await FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: kRedirectScheme,
      options: const FlutterWebAuth2Options(
        preferEphemeral: true,
        useWebview: true,
      ),
    );

    final code = Uri.parse(result).queryParameters['code'];
    final response = await dioClient.get(
      tokenUrl,
      queryParameters: {
        'code': code,
        'code_verifier': params.codeVerifier,
      },
    );

    final data = response.data;

    talker.logCustom(KickLog(data.toString()));

    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expiresIn = data['expires_in'];
    final scopes = data['scope'];

    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'scopes': scopes,
    };
  }

  @override
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );
    await remoteConfig.fetchAndActivate();
    String apiRefreshTokenUrl =
        remoteConfig.getString('irllink_kick_refresh_token_url');
    if (kDebugMode) {
      apiRefreshTokenUrl =
          remoteConfig.getString('irllink_kick_refresh_token_url_dev');
    }

    final response = await dioClient.get(
      apiRefreshTokenUrl,
      queryParameters: {
        'refresh_token': refreshToken,
        'app_version': Get.find<AppInfoService>().version,
        'platform': Platform.isAndroid ? 'android' : 'ios',
      },
    );

    return response.data;
  }

  @override
  Future<void> logout(String accessToken) async {
    await dioClient.post(
      'https://$kKickAuthUrlBase/oauth/revoke',
      queryParameters: {
        'token': accessToken,
      },
    );
  }

  @override
  Future<KickUserDTO> getKickUser(String accessToken) async {
    dioClient.options.headers["authorization"] = "Bearer $accessToken";
    final response = await dioClient.get('$kKickApiUrlBase/public/v1/users');
    return KickUserDTO.fromJson(response.data['data'][0]);
  }

  @override
  Future<Either<Failure, List<KickCategoryDTO>>> getCategories({
    required KickCategoriesParams params,
  }) async {
    try {
      dioClient.options.headers["Authorization"] =
          "Bearer ${params.accessToken}";
      final response = await dioClient.get(
        '$kKickApiUrlBase/public/v1/categories',
        queryParameters: {
          'q': params.searchQuery,
          if (params.page != null) 'page': params.page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final categories =
            data.map((json) => KickCategoryDTO.fromJson(json)).toList();
        return Right(categories);
      } else {
        return Left(Failure('Failed to fetch categories'));
      }
    } catch (e) {
      talker.error('Failed to fetch categories: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KickChannelDto>>> getChannels({
    required String accessToken,
  }) async {
    try {
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      final response = await dioClient.get(
        '$kKickApiUrlBase/public/v1/channels',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final channels =
            data.map((json) => KickChannelDto.fromJson(json)).toList();
        return Right(channels);
      } else {
        return Left(Failure('Failed to fetch channels'));
      }
    } catch (e) {
      talker.error('Failed to fetch channels: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, KickChannelDto>> patchChannel(
    String accessToken,
    String streamTitle,
    String categoryId,
  ) async {
    try {
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      final response = await dioClient.patch(
        '$kKickApiUrlBase/public/v1/channels',
        data: {
          'stream_title': streamTitle,
          'category_id': categoryId,
        },
      );

      if (response.statusCode == 200) {
        return Right(KickChannelDto.fromJson(response.data['data']));
      } else {
        return Left(Failure('Failed to patch channel'));
      }
    } catch (e) {
      talker.error('Failed to patch channel: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendChatMessage(
    PostKickChatMessageParams params,
  ) async {
    try {
      dioClient.options.headers["Authorization"] =
          "Bearer ${params.accessToken}";
      final response = await dioClient.post(
        '$kKickApiUrlBase/public/v1/chat',
        data: {
          "content": params.message,
          "type": "user",
          "broadcaster_user_id": params.broadcasterUserId,
        },
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure('Failed to send chat message'));
      }
    } catch (e) {
      talker.error('Failed to send chat message: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> banUser(BanKickUserParams params) async {
    try {
      dioClient.options.headers["Authorization"] =
          "Bearer ${params.accessToken}";
      final response = await dioClient.post(
        '$kKickApiUrlBase/public/v1/moderation/bans',
        data: {
          "broadcaster_user_id": params.broadcasterUserId,
          "duration": params.duration,
          "reason": params.reason,
          "user_id": params.userToBanId,
        },
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure('Failed to ban user'));
      }
    } catch (e) {
      talker.error('Failed to ban user: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unbanUser(UnbanKickUserParams params) async {
    try {
      dioClient.options.headers["Authorization"] =
          "Bearer ${params.accessToken}";
      final response = await dioClient.delete(
        '$kKickApiUrlBase/public/v1/moderation/bans',
        data: {
          "broadcaster_user_id": params.broadcasterUserId,
          "user_id": params.userToUnbanId,
        },
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure('Failed to unban user'));
      }
    } catch (e) {
      talker.error('Failed to unban user: $e');
      return Left(Failure(e.toString()));
    }
  }
}
