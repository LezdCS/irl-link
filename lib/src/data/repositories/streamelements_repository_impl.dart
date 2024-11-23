import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';

import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/stream_elements/se_activity_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_me_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_overlay_dto.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class StreamelementsRepositoryImpl implements StreamelementsRepository {
  final Mappr _mappr;
  final Talker talker;
  final Dio dioClient;
  StreamelementsRepositoryImpl({required this.talker, required this.dioClient})
      : _mappr = Mappr();

  @override
  Future<DataState<SeCredentials>> login(
    StreamelementsAuthParams params,
  ) async {
    try {
      Uri url = Uri.https('api.streamelements.com', '/oauth2/authorize', {
        'client_id': params.clientId,
        'redirect_uri': params.redirectUri,
        'response_type': params.responseType,
        'scope': params.scopes,
      });

      String result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: kRedirectScheme,
        preferEphemeral: true,
      );

      String accessToken = Uri.parse(result).queryParameters['access_token']!;
      String refreshToken = Uri.parse(result).queryParameters['refresh_token']!;
      int expiresIn =
          int.parse(Uri.parse(result).queryParameters['expires_in']!);
      talker.logTyped(
        StreamElementsLog('StreamElements login successful.'),
      );

      DataState tokenInfos = await validateToken(accessToken);
      final String scopes = tokenInfos.data['scopes'].join(' ');

      SeCredentials seCredentials = SeCredentials(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
        scopes: scopes,
      );

      await storeCredentials(seCredentials);

      return DataSuccess(seCredentials);
    } catch (e) {
      return DataFailed("Unable to retrieve StreamElements token: $e");
    }
  }

  @override
  Future<DataState<SeCredentials>> refreshAccessToken(
    SeCredentials seCredentials,
  ) async {
    Response response;
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      String apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_se_token_url');
      if (kDebugMode) {
        apiRefreshTokenUrl =
            remoteConfig.getString('irllink_refresh_se_token_url_dev');
      }

      response = await dioClient.get(
        apiRefreshTokenUrl,
        queryParameters: {'refresh_token': seCredentials.refreshToken},
      );

      talker.logTyped(StreamElementsLog('StreamElements token refreshed.'));

      SeCredentials newSeCredentials = SeCredentials(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        expiresIn: response.data['expires_in'],
        scopes: seCredentials.scopes,
      );
      await storeCredentials(newSeCredentials);

      await validateToken(newSeCredentials.accessToken);

      return DataSuccess(newSeCredentials);
    } on DioException catch (e) {
      return DataFailed("Refresh SE token failed: ${e.message}");
    }
  }

  Future<void> storeCredentials(SeCredentials seCredentials) async {
    GetStorage box = GetStorage();
    String jsonData = jsonEncode(seCredentials);
    await box.write('seCredentials', jsonData);
    talker.logTyped(
      StreamElementsLog('StreamElements credentials saved in local.'),
    );
  }

  Future<DataState<dynamic>> validateToken(String accessToken) async {
    try {
      Response response;
      dioClient.options.headers["authorization"] = "OAuth $accessToken";
      response = await dioClient.get('/oauth2/validate');
      talker.logTyped(StreamElementsLog('StreamElements token validated.'));

      return DataSuccess(response.data);
    } on DioException catch (e) {
      talker.error(e.message);
      return DataFailed(
        "Unable to validate StreamElements token: ${e.message}",
      );
    }
  }

  @override
  Future<DataState<void>> disconnect(String accessToken) async {
    dioClient.options.headers["authorization"] = "OAuth $accessToken";
    try {
      await dioClient.post(
        '/oauth2/revoke',
        queryParameters: {
          'client_id': kStreamelementsAuthClientId,
          'token': accessToken,
        },
      );
      GetStorage box = GetStorage();
      box.remove('seCredentials');
      talker.logTyped(
        StreamElementsLog('StreamElements credentials removed from local.'),
      );
      return DataSuccess(null);
    } on DioException catch (e) {
      return DataFailed("Unable to revoke StreamElements token: ${e.message}");
    }
  }

  @override
  Future<void> replayActivity(String token, SeActivity activity) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      await dioClient.post(
        '/kappa/v2/activities/${activity.channel}/${activity.id}/replay',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<DataState<SeCredentials>> getSeCredentialsFromLocal() async {
    final box = GetStorage();
    talker.logTyped(
      StreamElementsLog(
        'Getting StreamElements credentials from local storage.',
      ),
    );
    var seCredentialsString = box.read('seCredentials');

    if (seCredentialsString != null) {
      Map<String, dynamic> seCredentialsJson = jsonDecode(seCredentialsString);

      SeCredentialsDTO seCredentialsDTO =
          SeCredentialsDTO.fromJson(seCredentialsJson);

      StreamelementsAuthParams params = const StreamelementsAuthParams();
      List paramsScopesList = params.scopes.split(' ');
      paramsScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String paramsScopesOrdered = paramsScopesList.join(' ');
      List savedScopesList = seCredentialsDTO.scopes.split(' ');
      savedScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String savedScopesOrdered = savedScopesList.join(' ');
      if (savedScopesOrdered != paramsScopesOrdered) {
        talker.logTyped(
          StreamElementsLog(
            'StreamElements scopes changed, user need to relogin.',
          ),
        );
        disconnect(seCredentialsDTO.accessToken);
        return DataFailed("Scopes have been updated, please login again.");
      }

      SeCredentials seCredentials =
          _mappr.convert<SeCredentialsDTO, SeCredentials>(seCredentialsDTO);

      //refresh the access token to be sure the token is going to be valid after starting the app
      DataState<SeCredentials> creds = await refreshAccessToken(seCredentials);
      if (creds is DataSuccess) {
        seCredentials = creds.data!;
      } else {
        return DataFailed("Error refreshing SE Token");
      }

      return DataSuccess(seCredentials);
    } else {
      return DataFailed("No SE Data in local storage");
    }
  }

  @override
  Future<DataState<List<SeActivity>>> getLastActivities(
    String token,
    String channel,
  ) async {
    Response response;
    List<SeActivity> activities = [];
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      response = await dioClient.get(
        '/kappa/v2/activities/$channel',
        queryParameters: {
          'after': DateTime.now().subtract(const Duration(days: 365)),
          'before': DateTime.now(),
          'limit': 50,
          'mincheer': 0,
          'minhost': 0,
          'minsub': 0,
          'mintip': 0,
          'origin': 'twitch',
          'types': ['follow', 'tip', 'host', 'raid', 'subscriber', 'cheer'],
        },
      );
      response.data.reversed.forEach(
        (activity) {
          SeActivityDTO activityDTO = SeActivityDTO.fromJson(activity);
          activities
              .add(_mappr.convert<SeActivityDTO, SeActivity>(activityDTO));
        },
      );
      return DataSuccess(activities);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<SeOverlay>>> getOverlays(
    String token,
    String channel,
  ) async {
    List<SeOverlay> overlays = [];
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      Response response = await dioClient.get(
        '/kappa/v2/overlays/$channel',
        queryParameters: {'search': ' ', 'type': 'regular'},
      );
      response.data['docs'].forEach(
        (overlay) {
          SeOverlayDTO overlayDTO = SeOverlayDTO.fromJson(overlay);
          overlays.add(_mappr.convert<SeOverlayDTO, SeOverlay>(overlayDTO));
        },
      );
      return DataSuccess(overlays);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<SeMe>> getMe(String token) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      Response response = await dioClient.get(
        '/kappa/v2/channels/me',
      );

      SeMeDTO meDto = SeMeDTO.fromJson(response.data);
      SeMe me = _mappr.convert<SeMeDTO, SeMe>(meDto);

      return DataSuccess(me);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> nextSong(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.post(
        '/kappa/v2/songrequest/$userId/skip',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> removeSong(String token, String userId, String songId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.delete(
        '/kappa/v2/songrequest/$userId/queue/$songId',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> resetQueue(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.delete(
        '/kappa/v2/songrequest/$userId/queue/',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<DataState<List<SeSong>>> getSongQueue(
    String token,
    String userId,
  ) async {
    List<SeSong> songs = [];

    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      Response response = await dioClient.get(
        '/kappa/v2/songrequest/$userId/queue',
      );

      response.data.forEach(
        (song) => {
          songs.add(
            SeSong(
              channel: song['channel'],
              duration: song['duration'],
              id: song['_id'],
              title: song['title'],
              videoId: song['videoId'],
            ),
          ),
        },
      );

      return DataSuccess(songs);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<SeSong>> getSongPlaying(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      Response response = await dioClient.get(
        '/kappa/v2/songrequest/$userId/playing',
      );

      if (response.data != null) {
        SeSong song = SeSong(
          channel: response.data['channel'],
          duration: response.data['duration'],
          id: response.data['_id'],
          title: response.data['title'],
          videoId: response.data['videoId'],
        );
        return DataSuccess(song);
      } else {
        return DataFailed('There is no playing song for this user.');
      }
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> updatePlayerState(
    String token,
    String userId,
    String state,
  ) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.post(
        '/kappa/v2/songrequest/$userId/player/$state',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }
}
