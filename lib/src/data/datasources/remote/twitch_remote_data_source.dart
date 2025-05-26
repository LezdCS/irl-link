import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_stream_infos_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:twitch_chat/twitch_chat.dart';

abstract class TwitchRemoteDataSource {
  Future<Map<String, dynamic>> getTwitchOauth(TwitchAuthParams params);
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken);
  Future<Map<String, dynamic>> validateToken(String accessToken);
  Future<void> logout(String accessToken);
  Future<TwitchUserDTO> getTwitchUser(String? username, String accessToken);
  Future<List<TwitchUserDTO>> getTwitchUsers(List ids, String accessToken);
  Future<TwitchStreamInfosDto> getStreamInfo(
    String accessToken,
    String broadcasterId,
  );
  Future<void> setChatSettings(
    String accessToken,
    String broadcasterId,
    TwitchStreamInfos? twitchStreamInfos,
  );
  Future<void> setStreamTitle(
    String accessToken,
    String broadcasterId,
    String title,
  );
  Future<void> endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  );
  Future<TwitchPollDTO> endPoll(
    String accessToken,
    String broadcasterId,
    String pollId,
    String status,
  );
  Future<TwitchPoll> createPoll(
    String accessToken,
    String broadcasterId,
    TwitchPoll newPoll,
  );
  Future<void> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  );
  Future<void> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  );
  Future<List<String>> getRecentMessages(
    String channelName,
    int limit,
  );
}

class TwitchRemoteDataSourceImpl implements TwitchRemoteDataSource {
  final Dio dioClient;
  final Talker talker;

  TwitchRemoteDataSourceImpl({
    required this.dioClient,
    required this.talker,
  });

  @override
  Future<Map<String, dynamic>> getTwitchOauth(TwitchAuthParams params) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String redirectUri = remoteConfig.getString('irllink_auth_url');
    if (kDebugMode) {
      redirectUri = remoteConfig.getString('irllink_auth_url_dev');
    }

    final url = Uri.https(kTwitchAuthUrlBase, kTwitchAuthUrlPath, {
      'client_id': params.clientId,
      'redirect_uri': redirectUri,
      'response_type': params.responseType,
      'scope': params.scopes,
      'force_verify': params.forceVerify,
      'claims': params.claims,
    });

    final result = await FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: kRedirectScheme,
      options: const FlutterWebAuth2Options(
        preferEphemeral: true,
        useWebview: true,
      ),
    );

    final accessToken = Uri.parse(result).queryParameters['access_token'];
    final idToken = Uri.parse(result).queryParameters['id_token'];
    final refreshToken = Uri.parse(result).queryParameters['refresh_token'];
    final expiresIn = Uri.parse(result).queryParameters['expires_in'];

    dynamic tokenInfos = await validateToken(accessToken!);
    final String scopes = tokenInfos['scopes'].join(' ');

    Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);

    return {
      'access_token': accessToken,
      'id_token': idToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'scopes': scopes,
      'decoded_token': decodedToken,
    };
  }

  @override
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String apiRefreshTokenUrl =
        remoteConfig.getString('irllink_refresh_token_url');
    if (kDebugMode) {
      apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_token_url_dev');
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
  Future<Map<String, dynamic>> validateToken(String accessToken) async {
    dioClient.options.headers["authorization"] = "Bearer $accessToken";
    final response =
        await dioClient.get('https://id.twitch.tv/oauth2/validate');
    return response.data;
  }

  @override
  Future<void> logout(String accessToken) async {
    await dioClient.post(
      'https://id.twitch.tv/oauth2/revoke',
      queryParameters: {
        'client_id': kTwitchAuthClientId,
        'token': accessToken,
      },
    );
  }

  @override
  Future<TwitchUserDTO> getTwitchUser(
    String? username,
    String accessToken,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    final response = await dioClient.get(
      '/helix/users',
      queryParameters: username != null ? {'login': username} : null,
    );

    return TwitchUserDTO.fromJson(response.data['data'][0]);
  }

  @override
  Future<List<TwitchUserDTO>> getTwitchUsers(
    List ids,
    String accessToken,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    final response = await dioClient.get(
      '/helix/users',
      queryParameters: {'id': ids},
    );

    return (response.data['data'] as List)
        .map((user) => TwitchUserDTO.fromJson(user))
        .toList();
  }

  @override
  Future<TwitchStreamInfosDto> getStreamInfo(
    String accessToken,
    String broadcasterId,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    final channelsResponse = await dioClient.get(
      '/helix/channels',
      queryParameters: {'broadcaster_id': broadcasterId},
    );

    final streamsResponse = await dioClient.get(
      '/helix/streams',
      queryParameters: {'user_id': broadcasterId},
    );

    final chatSettingsResponse = await dioClient.patch(
      '/helix/chat/settings',
      queryParameters: {
        'broadcaster_id': broadcasterId,
        'moderator_id': broadcasterId,
      },
      data: jsonEncode({}),
    );

    return TwitchStreamInfosDto.fromJson(
      channelsResponse.data['data'][0],
      streamsResponse.data,
      chatSettingsResponse.data['data'][0],
    );
  }

  @override
  Future<void> setChatSettings(
    String accessToken,
    String broadcasterId,
    TwitchStreamInfos? twitchStreamInfos,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    Map<String, dynamic> settings = {};

    if (twitchStreamInfos != null) {
      settings = {
        'emote_mode': twitchStreamInfos.isEmoteMode,
        'follower_mode': twitchStreamInfos.isFollowerMode,
        'slow_mode': twitchStreamInfos.isSlowMode,
        'subscriber_mode': twitchStreamInfos.isSubscriberMode,
      };

      if (twitchStreamInfos.isSlowMode!) {
        settings['slow_mode_wait_time'] =
            twitchStreamInfos.slowModeWaitTime ?? 30;
      }
    }

    await dioClient.patch(
      '/helix/chat/settings',
      queryParameters: {
        'broadcaster_id': broadcasterId,
        'moderator_id': broadcasterId,
      },
      data: jsonEncode(settings),
    );
  }

  @override
  Future<void> setStreamTitle(
    String accessToken,
    String broadcasterId,
    String title,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    await dioClient.patch(
      '/helix/channels',
      queryParameters: {
        'broadcaster_id': broadcasterId,
        'moderator_id': broadcasterId,
      },
      data: jsonEncode({"title": title}),
    );
  }

  @override
  Future<void> endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    await dioClient.patch(
      '/helix/predictions',
      data: jsonEncode({
        "broadcaster_id": broadcasterId,
        "id": predictionId,
        "status": status,
        "winning_outcome_id": winningOutcomeId ?? '',
      }),
    );
  }

  @override
  Future<TwitchPollDTO> endPoll(
    String accessToken,
    String broadcasterId,
    String pollId,
    String status,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    final response = await dioClient.patch(
      '/helix/polls',
      data: jsonEncode({
        "broadcaster_id": broadcasterId,
        "id": pollId,
        "status": status,
      }),
    );

    return TwitchPollDTO.fromJson(response.data['data'][0]);
  }

  @override
  Future<TwitchPoll> createPoll(
    String accessToken,
    String broadcasterId,
    TwitchPoll newPoll,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    return newPoll;
  }

  @override
  Future<void> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    Map body = {
      "data": {
        "user_id": message.authorId,
      },
    };
    if (duration != null) {
      body['data']['duration'] = duration.toString();
    }

    await dioClient.post(
      '/helix/moderation/bans',
      queryParameters: {
        'broadcaster_id': broadcasterId,
        'moderator_id': broadcasterId,
      },
      data: jsonEncode(body),
    );
  }

  @override
  Future<void> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  ) async {
    dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
    dioClient.options.headers["authorization"] = "Bearer $accessToken";

    await dioClient.delete(
      '/helix/moderation/chat',
      queryParameters: {
        'broadcaster_id': broadcasterId,
        'moderator_id': broadcasterId,
        'message_id': message.id,
      },
    );
  }

  @override
  Future<List<String>> getRecentMessages(
    String channelName,
    int limit,
  ) async {
    final Dio dio = Dio();
    try {
      dio.options.baseUrl = 'https://recent-messages.robotty.de';
      final response = await dio.get(
        '/api/v2/recent-messages/$channelName',
        queryParameters: {
          'limit': limit,
          'hide_moderation_messages': false,
          'hide_moderated_messages': false,
          'clearchat_to_notice': false,
        },
      );

      if (response.data != null && response.data['messages'] != null) {
        final messages = List<String>.from(response.data['messages']);
        return messages;
      }

      return [];
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace);
      return [];
    }
  }
}
