import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_stream_infos_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_decoded_idtoken.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quiver/iterables.dart';
import 'package:twitch_chat/twitch_chat.dart';

class TwitchRepositoryImpl implements TwitchRepository {
  final Mappr _mappr;
  final Dio dioClient;
  TwitchRepositoryImpl({required this.dioClient}) : _mappr = Mappr();

  @override
  Future<DataState<TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  ) async {
    try {
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

      TwitchDecodedIdToken decodedIdToken = TwitchDecodedIdToken(
        preferredUsername: decodedToken['preferred_username'],
        profilePicture: decodedToken['picture'] ?? "",
      );

      TwitchUser twitchUser = const TwitchUser(
        profileImageUrl: '',
        id: '',
        broadcasterType: '',
        login: '',
        description: '',
        viewCount: 0,
        displayName: '',
      );

      await getTwitchUser(null, accessToken)
          .then((value) => twitchUser = value.data!);

      TwitchCredentials twitchData = TwitchCredentials(
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

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      String apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_token_url');
      if (kDebugMode) {
        apiRefreshTokenUrl =
            remoteConfig.getString('irllink_refresh_token_url_dev');
      }

      response = await dioClient.get(
        apiRefreshTokenUrl,
        queryParameters: {
          'refresh_token': twitchData.refreshToken,
          'app_version': Get.find<AppInfoService>().version,
          'platform': Platform.isAndroid ? 'android' : 'ios',
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

      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      response = await dioClient.get('https://id.twitch.tv/oauth2/validate');
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

    try {
      response = await dioClient.post(
        'https://id.twitch.tv/oauth2/revoke',
        queryParameters: {
          'client_id': kTwitchAuthClientId,
          'token': accessToken,
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

      TwitchCredentialsDTO twitchDataDTO =
          TwitchCredentialsDTO.fromJson(twitchDataJson);

      TwitchAuthParams params = const TwitchAuthParams();

      List paramsScopesList = params.scopes.split(' ');
      paramsScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String paramsScopesOrdered = paramsScopesList.join(' ');

      List savedScopesList = twitchDataDTO.scopes.split(' ');
      savedScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String savedScopesOrdered = savedScopesList.join(' ');

      if (savedScopesOrdered != paramsScopesOrdered) {
        return DataFailed("Scopes have been updated, please login again.");
      }

      TwitchCredentials twitchData = _mappr
          .convert<TwitchCredentialsDTO, TwitchCredentials>(twitchDataDTO);

      return DataSuccess(twitchData);
    } else {
      return DataFailed("No Twitch Data in local storage");
    }
  }

  Future<void> setTwitchOnLocal(TwitchCredentials twitchData) async {
    final box = GetStorage();
    TwitchCredentialsDTO twitchDataDTO =
        _mappr.convert<TwitchCredentials, TwitchCredentialsDTO>(twitchData);
    String jsonTwitchData = jsonEncode(twitchDataDTO);
    box.write('twitchData', jsonTwitchData);
  }

  @override
  Future<DataState<TwitchUser>> getTwitchUser(
    String? username,
    String accessToken,
  ) async {
    Response response;

    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";

      if (username != null) {
        response = await dioClient.get(
          '/helix/users',
          queryParameters: {'login': username},
        );
      } else {
        //if no username then it get the user linked to the accessToken
        response = await dioClient.get(
          '/helix/users',
        );
      }

      TwitchUserDTO twitchUserDTO =
          TwitchUserDTO.fromJson(response.data['data'][0]);

      TwitchUser twitchUser =
          _mappr.convert<TwitchUserDTO, TwitchUser>(twitchUserDTO);

      return DataSuccess(twitchUser);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<TwitchUser>>> getTwitchUsers(
    List ids,
    String accessToken,
  ) async {
    Response response;

    List<TwitchUser> twitchUsers = <TwitchUser>[];
    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";

      var chunks = partition(ids, 100);

      for (var chunk in chunks) {
        await Future.delayed(const Duration(seconds: 5), () async {
          response = await dioClient.get(
            '/helix/users',
            queryParameters: {'id': chunk},
          );

          response.data['data'].forEach(
            (user) => {
              twitchUsers.add(
                _mappr.convert<TwitchUserDTO, TwitchUser>(
                  TwitchUserDTO.fromJson(user),
                ),
              ),
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
    String accessToken,
    String broadcasterId,
  ) async {
    Response response;
    Response response2;

    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      response = await dioClient.get(
        '/helix/channels',
        queryParameters: {'broadcaster_id': broadcasterId},
      );

      response2 = await dioClient.get(
        '/helix/streams',
        queryParameters: {'user_id': broadcasterId},
      );

      dynamic reponse3;
      await setChatSettings(accessToken, broadcasterId, null)
          .then((value) => reponse3 = value.data!.data);

      TwitchStreamInfosDto twitchStreamInfosDto = TwitchStreamInfosDto.fromJson(
        response.data['data'][0],
        response2.data,
        reponse3['data'][0],
      );

      TwitchStreamInfos twitchStreamInfos =
          _mappr.convert<TwitchStreamInfosDto, TwitchStreamInfos>(
        twitchStreamInfosDto,
      );

      return DataSuccess(twitchStreamInfos);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Response<dynamic>>> setChatSettings(
    String accessToken,
    String broadcasterId,
    TwitchStreamInfos? twitchStreamInfos,
  ) async {
    Response response;
    Map<String, dynamic> settings = {};

    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";

      if (twitchStreamInfos != null) {
        settings = {
          'emote_mode': twitchStreamInfos.isEmoteMode,
          'follower_mode': twitchStreamInfos.isFollowerMode,
          'slow_mode': twitchStreamInfos.isSlowMode,
          'subscriber_mode': twitchStreamInfos.isSubscriberMode,
        };

        if (twitchStreamInfos.isSlowMode!) {
          // minimum 3, maximum 120
          settings['slow_mode_wait_time'] =
              twitchStreamInfos.slowModeWaitTime ?? 30;
        }
      }

      response = await dioClient.patch(
        '/helix/chat/settings',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId,
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
    String accessToken,
    String broadcasterId,
    String title,
  ) async {
    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      Map titleMap = {"title": title};
      await dioClient.patch(
        '/helix/channels',
        queryParameters: {
          'broadcaster_id': broadcasterId,
          'moderator_id': broadcasterId,
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
    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";

      Map body = {
        "broadcaster_id": broadcasterId,
        "id": predictionId,
        "status": status,
        "winning_outcome_id": winningOutcomeId ?? '',
      };

      await dioClient.patch(
        '/helix/predictions',
        data: jsonEncode(body),
      );

      return DataSuccess("");
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchPoll>> endPoll(
    String accessToken,
    String broadcasterId,
    String pollId,
    String status,
  ) async {
    Response response;

    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";

      Map body = {
        "broadcaster_id": broadcasterId,
        "id": pollId,
        "status": status,
      };

      response = await dioClient.patch(
        '/helix/polls',
        data: jsonEncode(body),
      );

      TwitchPollDTO pollDTO = TwitchPollDTO.fromJson(response.data['data'][0]);
      TwitchPoll poll = _mappr.convert<TwitchPollDTO, TwitchPoll>(pollDTO);

      return DataSuccess(poll);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<TwitchPoll>> createPoll(
    String accessToken,
    String broadcasterId,
    TwitchPoll newPoll,
  ) async {
    // Response response;

    // TwitchPrediction? prediction;
    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      // response = await dioClient.post(
      //     '/helix/predictions?broadcaster_id=$broadcasterId');

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
    try {
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
    try {
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
    } on DioException catch (e) {
      debugPrint(e.response.toString());
    }
  }
}
