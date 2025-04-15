import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class KickRemoteDataSource {
  Future<Map<String, dynamic>> getKickOauth(KickAuthParams params);
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken);
  Future<void> logout(String accessToken);
  Future<KickUserDTO> getKickUser(String accessToken);
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
    if (kDebugMode) {
      redirectUri = remoteConfig.getString('irllink_kick_auth_url_dev');
    }

    debugPrint(redirectUri);

    final url = Uri.https(kKickAuthUrlBase, kKickAuthUrlPath, {
      'client_id': params.clientId,
      'redirect_uri': redirectUri,
      'response_type': params.responseType,
      'scope': params.scopes,
      'state': params.state,
      'code_challenge': params.codeChallenge,
      'code_challenge_method': params.codeChallengeMethod,
    });

    debugPrint(url.toString());

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
      'https://dev.irllink.com/api/kick/token',
      queryParameters: {
        'code': code,
        'code_verifier': params.codeVerifier,
      },
    );

    final data = response.data;

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
    talker.logCustom(KickLog(response.data.toString()));
    return KickUserDTO.fromJson(response.data['data'][0]);
  }
}
