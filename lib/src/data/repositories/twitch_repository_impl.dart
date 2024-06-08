import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_stream_infos_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quiver/iterables.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

import '../entities/twitch/twitch_poll_dto.dart';

class TwitchRepositoryImpl extends TwitchRepository {
  @override
  Future<DataState<TwitchCredentials>> getTwitchOauth(
      TwitchAuthParams params) async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      String redirectUri = remoteConfig.getString('irllink_auth_url');

      final url = Uri.https(kTwitchAuthUrlBase, kTwitchAuthUrlPath, {
        'client_id': params.clientId,
        'redirect_uri': redirectUri,
        'response_type': params.responseType,
        'scope': params.scopes,
        'force_verify': params.forceVerify,
        'claims': params.claims
      });

      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: kRedirectScheme,
        preferEphemeral: false,
      );

      final accessToken = Uri.parse(result).queryParameters['access_token'];
      final idToken = Uri.parse(result).queryParameters['id_token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh_token'];
      final expiresIn = Uri.parse(result).queryParameters['expires_in'];

      dynamic tokenInfos = await validateToken(accessToken!);
      final String scopes = tokenInfos['scopes'].join(' ');

      Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);

      TwitchDecodedIdTokenDTO decodedIdToken = TwitchDecodedIdTokenDTO(
        preferredUsername: decodedToken['preferred_username'],
        profilePicture: decodedToken['picture'] ?? "",
      );

      TwitchUserDTO twitchUser = const TwitchUserDTO(
        profileImageUrl: '',
        id: '',
        broadcasterType: '',
        login: '',
        description: '',
        viewCount: '',
        displayName: '',
      );

      await getTwitchUser(null, accessToken)
          .then((value) => twitchUser = value.data!);

      TwitchCredentials twitchData = TwitchCredentialsDTO(
        accessToken: accessToken,
        idToken: idToken,
        refreshToken: refreshToken!,
        expiresIn: expiresIn!,
        decodedIdToken: decodedIdToken,
        twitchUser: twitchUser,
        scopes: scopes,
      );

      setTwitchOnLocal(twitchData);

      return DataSuccess(twitchData);
    } catch (e) {
      return DataFailed("Unable to retrieve Twitch Data from Auth: $e");
    }
  }

  @override
  Future<DataState<TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  ) async {
    Response response;
    var dio = initDio();
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      String apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_token_url');

      response = await dio.get(
        apiRefreshTokenUrl,
        queryParameters: {
          'refresh_token': twitchData.refreshToken,
          'app_version': globals.version,
          'platform': Platform.isAndroid ? 'android' : 'ios'
        },
      );

      TwitchCredentials newTwitchData = TwitchCredentials(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        idToken: twitchData.idToken,
        decodedIdToken: twitchData.decodedIdToken,
        expiresIn: twitchData.expiresIn,
        twitchUser: twitchData.twitchUser,
        scopes: twitchData.scopes,
      );
      setTwitchOnLocal(newTwitchData);

      await validateToken(newTwitchData.accessToken);

      return DataSuccess(newTwitchData);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<dynamic> validateToken(String accessToken) async {
    try {
      Response response;
      var dio = initDio();
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get('https://id.twitch.tv/oauth2/validate');
      return response.data;
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> logout(String accessToken) async {
    final box = GetStorage();
    box.remove('twitchData');
    Response response;
    var dio = initDio();
    try {
      response = await dio.post(
        'https://id.twitch.tv/oauth2/revoke',
        queryParameters: {
          'client_id': kTwitchAuthClientId,
          'token': accessToken
        },
      );
      return DataSuccess(response.toString());
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchCredentials>> getTwitchFromLocal() async {
    final box = GetStorage();
    var twitchDataString = box.read('twitchData');
    if (twitchDataString != null) {
      Map<String, dynamic> twitchDataJson = jsonDecode(twitchDataString);

      TwitchCredentials twitchData =
          TwitchCredentialsDTO.fromJson(twitchDataJson);

      TwitchAuthParams params = const TwitchAuthParams();

      List paramsScopesList = params.scopes.split(' ');
      paramsScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String paramsScopesOrdered = paramsScopesList.join(' ');

      List savedScopesList = twitchData.scopes.split(' ');
      savedScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String savedScopesOrdered = savedScopesList.join(' ');

      if (savedScopesOrdered != paramsScopesOrdered) {
        return DataFailed("Scopes have been updated, please login again.");
      }

      //refresh the access token to be sure the token is going to be valid after starting the app
      DataState<TwitchCredentials> refreshTokenResult =
          await refreshAccessToken(twitchData);
      if (refreshTokenResult is DataFailed) {
        return refreshTokenResult;
      } else {
        twitchData = refreshTokenResult.data!;
      }

      return DataSuccess(twitchData);
    } else {
      return DataFailed("No Twitch Data in local storage");
    }
  }

  Future<void> setTwitchOnLocal(TwitchCredentials twitchData) async {
    final box = GetStorage();
    String jsonTwitchData = jsonEncode(twitchData);
    box.write('twitchData', jsonTwitchData);
  }

  @override
  Future<DataState<TwitchUserDTO>> getTwitchUser(
      String? username, String accessToken) async {
    Response response;
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      if (username != null) {
        response = await dio.get(
          'https://api.twitch.tv/helix/users',
          queryParameters: {'login': username},
        );
      } else {
        //if no username then it get the user linked to the accessToken
        response = await dio.get(
          'https://api.twitch.tv/helix/users',
        );
      }

      TwitchUserDTO twitchUser =
          TwitchUserDTO.fromJson(response.data['data'][0]);

      return DataSuccess(twitchUser);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<TwitchUserDTO>>> getTwitchUsers(
      List ids, String accessToken) async {
    Response response;
    var dio = initDio();
    List<TwitchUserDTO> twitchUsers = <TwitchUserDTO>[];
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      var chunks = partition(ids, 100);

      for (var chunk in chunks) {
        await Future.delayed(const Duration(seconds: 5), () async {
          response = await dio.get(
            'https://api.twitch.tv/helix/users',
            queryParameters: {'id': chunk},
          );

          response.data['data'].forEach(
            (user) => {
              twitchUsers.add(TwitchUserDTO.fromJson(user)),
            },
          );
        });
      }

      return DataSuccess(twitchUsers);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchStreamInfos>> getStreamInfo(
      String accessToken, String broadcasterId) async {
    Response response;
    Response response2;
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      response = await dio.get(
        'https://api.twitch.tv/helix/channels',
        queryParameters: {'broadcaster_id': broadcasterId},
      );

      response2 = await dio.get(
        'https://api.twitch.tv/helix/streams',
        queryParameters: {'user_id': broadcasterId},
      );

      dynamic reponse3;
      await setChatSettings(accessToken, broadcasterId, null)
          .then((value) => reponse3 = value.data!.data);

      TwitchStreamInfosDto twitchStreamInfosDto = TwitchStreamInfosDto.fromJson(
          response.data['data'][0], response2.data, reponse3['data'][0]);

      return DataSuccess(twitchStreamInfosDto);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Response<dynamic>>> setChatSettings(String accessToken,
      String broadcasterId, TwitchStreamInfos? twitchStreamInfos) async {
    Response response;
    Map<String, dynamic> settings = {};
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      if (twitchStreamInfos != null) {
        settings = {
          'emote_mode': twitchStreamInfos.isEmoteMode!,
          'follower_mode': twitchStreamInfos.isFollowerMode!,
          'slow_mode': twitchStreamInfos.isSlowMode!,
          'subscriber_mode': twitchStreamInfos.isSubscriberMode!,
        };

        if (twitchStreamInfos.isSlowMode!) {
          // minimum 3, maximum 120
          settings['slow_mode_wait_time'] =
              twitchStreamInfos.slowModeWaitTime ?? 30;
        }
      }

      response = await dio.patch(
        'https://api.twitch.tv/helix/chat/settings',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId
        },
        data: jsonEncode(settings),
      );

      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> setStreamTitle(
      String accessToken, String broadcasterId, String title) async {
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      Map titleMap = {"title": title};
      await dio.patch(
        'https://api.twitch.tv/helix/channels',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId
        },
        data: jsonEncode(titleMap),
      );
      return DataSuccess(null);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  ) async {
    var dio = initDio();

    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      Map body = {
        "broadcaster_id": broadcasterId,
        "id": predictionId,
        "status": status,
        "winning_outcome_id": winningOutcomeId ?? ''
      };

      await dio.patch(
        'https://api.twitch.tv/helix/predictions',
        data: jsonEncode(body),
      );

      return DataSuccess("");
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchPoll>> endPoll(String accessToken,
      String broadcasterId, String pollId, String status) async {
    var dio = initDio();
    Response response;
    TwitchPoll? poll;

    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";

      Map body = {
        "broadcaster_id": broadcasterId,
        "id": pollId,
        "status": status
      };

      response = await dio.patch(
        'https://api.twitch.tv/helix/polls',
        data: jsonEncode(body),
      );

      poll = TwitchPollDTO.fromJson(response.data['data'][0]);

      return DataSuccess(poll);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchPoll>> createPoll(
      String accessToken, String broadcasterId, TwitchPoll newPoll) async {
    // Response response;
    var dio = initDio();
    // TwitchPrediction? prediction;
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      // response = await dio.post(
      //     'https://api.twitch.tv/helix/predictions?broadcaster_id=$broadcasterId');

      return DataSuccess(newPoll);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  ) async {
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      Map body = {
        "data": {
          "user_id": message.authorId,
        },
      };
      if (duration != null) {
        body['data']['duration'] = duration.toString();
      }

      await dio.post(
        'https://api.twitch.tv/helix/moderation/bans',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId,
        },
        data: jsonEncode(body),
      );
    } on DioException catch (e) {
      debugPrint(e.response.toString());
    }
  }

  @override
  Future<void> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  ) async {
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      await dio.delete(
        'https://api.twitch.tv/helix/moderation/chat',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId,
          'message_id': message.id,
        },
      );
    } on DioException catch (e) {
      debugPrint(e.response.toString());
    }
  }
}
