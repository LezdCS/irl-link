import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
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

class StreamelementsRepositoryImpl extends StreamelementsRepository {
  @override
  Future<DataState<SeCredentials>> login(
      StreamelementsAuthParams params) async {
    try {
      Uri url = Uri.https(kStreamelementsUrlBase, kStreamelementsAuthPath, {
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

      String? accessToken = Uri.parse(result).queryParameters['access_token'];
      String? refreshToken = Uri.parse(result).queryParameters['refresh_token'];
      String? expiresIn = Uri.parse(result).queryParameters['expires_in'];

      dynamic tokenInfos = await validateToken(accessToken!);
      final String scopes = tokenInfos['scopes'].join(' ');

      SeCredentials seCredentials = SeCredentialsDTO(
        accessToken: accessToken,
        refreshToken: refreshToken!,
        expiresIn: int.parse(expiresIn ?? '0'),
        scopes: scopes,
      );

      storeCredentials(seCredentials);

      return DataSuccess(seCredentials);
    } catch (e) {
      return const DataFailed("Unable to retrieve StreamElements token");
    }
  }

  @override
  Future<DataState<SeCredentials>> refreshAccessToken(
    SeCredentials seCredentials,
  ) async {
    Response response;
    Dio dio = Dio();
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      String apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_se_token_url');

      response = await dio.get(
        apiRefreshTokenUrl,
        queryParameters: {'refresh_token': seCredentials.refreshToken},
      );

      SeCredentials newSeCredentials = SeCredentials(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        expiresIn: response.data['expires_in'],
        scopes: seCredentials.scopes,
      );
      storeCredentials(newSeCredentials);

      await validateToken(newSeCredentials.accessToken);

      return DataSuccess(newSeCredentials);
    } on DioException catch (e) {
      debugPrint(e.toString());
      return const DataFailed("Refresh encountered issues");
    }
  }

  void storeCredentials(SeCredentials seCredentials) {
    GetStorage box = GetStorage();
    String jsonTwitchData = jsonEncode(seCredentials);
    box.write('seCredentials', jsonTwitchData);
  }

  Future<DataState<dynamic>> validateToken(String accessToken) async {
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers["authorization"] = "OAuth $accessToken";
      response =
          await dio.get('https://api.streamelements.com/oauth2/validate');
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(
          "Unable to validate StreamElements token: ${e.message}");
    }
  }

  @override
  Future<DataState<void>> disconnect(String accessToken) async {
    GetStorage box = GetStorage();
    box.remove('seCredentials');
    Dio dio = Dio();
    try {
      await dio.post(
        'https://api.streamelements.com/oauth2/revoke',
        queryParameters: {
          'client_id': kStreamelementsAuthClientId,
          'token': accessToken,
        },
      );

      return const DataSuccess(null);
    } on DioException catch (e) {
      return DataFailed("Unable to revoke StreamElements token: ${e.message}");
    }
  }

  @override
  Future<void> replayActivity(String token, SeActivity activity) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.post(
        'https://api.streamelements.com/kappa/v2/activities/${activity.channel}/${activity.id}/replay',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<DataState<SeCredentials>> getSeCredentialsFromLocal() async {
    final box = GetStorage();
    var seCredentialsString = box.read('seCredentials');
    if (seCredentialsString != null) {
      Map<String, dynamic> seCredentialsJson = jsonDecode(seCredentialsString);

      SeCredentials seCredentials = SeCredentialsDTO.fromJson(seCredentialsJson);

      StreamelementsAuthParams params = const StreamelementsAuthParams();

      List paramsScopesList = params.scopes.split(' ');
      paramsScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String paramsScopesOrdered = paramsScopesList.join(' ');

      List savedScopesList = seCredentials.scopes.split(' ');
      savedScopesList.sort((a, b) {
        return a.compareTo(b);
      });
      String savedScopesOrdered = savedScopesList.join(' ');

      if (savedScopesOrdered != paramsScopesOrdered) {
        disconnect(seCredentials.accessToken);
        return const DataFailed("Scopes have been updated, please login again");
      }

      //refresh the access token to be sure the token is going to be valid after starting the app
      await refreshAccessToken(seCredentials)
          .then((value) => seCredentials = value.data!);

      return DataSuccess(seCredentials);
    } else {
      return const DataFailed("No Twitch Data in local storage");
    }
  }

  @override
  Future<DataState<List<SeActivity>>> getLastActivities(
      String token, String channel) async {
    var dio = initDio();
    Response response;
    List<SeActivity> activities = [];
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      response = await dio.get(
        'https://api.streamelements.com/kappa/v2/activities/$channel',
        queryParameters: {
          'after': DateTime.now().subtract(const Duration(days: 365)),
          'before': DateTime.now(),
          'limit': 50,
          'mincheer': 0,
          'minhost': 0,
          'minsub': 0,
          'mintip': 0,
          'origin': 'twitch',
          'types': ['follow', 'tip', 'host', 'raid', 'subscriber', 'cheer']
        },
      );
      response.data.reversed.forEach(
        (activity) => {
          activities.add(SeActivityDTO.fromJson(activity)),
        },
      );
      return DataSuccess(activities);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<SeOverlay>>> getOverlays(
      String token, String channel) async {
    var dio = initDio();
    List<SeOverlay> overlays = [];
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(
        'https://api.streamelements.com/kappa/v2/overlays/$channel',
        queryParameters: {'search': ' ', 'type': 'regular'},
      );
      response.data['docs'].forEach(
        (overlay) => {
          overlays.add(SeOverlayDTO.fromJson(overlay)),
        },
      );
      return DataSuccess(overlays);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<SeMe>> getMe(String token) async {
    var dio = initDio();
    late SeMe me;
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(
        'https://api.streamelements.com/kappa/v2/channels/me',
      );

      me = SeMeDTO.fromJson(response.data);

      return DataSuccess(me);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> nextSong(String token, String userId) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.post(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/skip',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> removeSong(String token, String userId, String songId) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.delete(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/queue/$songId',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> resetQueue(String token, String userId) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.delete(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/queue/',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<DataState<List<SeSong>>> getSongQueue(
      String token, String userId) async {
    List<SeSong> songs = [];
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/queue',
      );

      response.data.forEach(
        (song) => {
          songs.add(SeSong(
            channel: song['channel'],
            duration: song['duration'],
            id: song['_id'],
            title: song['title'],
            videoId: song['videoId'],
          )),
        },
      );

      return DataSuccess(songs);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<SeSong>> getSongPlaying(String token, String userId) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/playing',
      );

      SeSong song = SeSong(
        channel: response.data['channel'],
        duration: response.data['duration'],
        id: response.data['_id'],
        title: response.data['title'],
        videoId: response.data['videoId'],
      );

      return DataSuccess(song);
    } on DioException catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> updatePlayerState(String token, String userId, String state) async {
    var dio = initDio();
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.post(
        'https://api.streamelements.com/kappa/v2/songrequest/$userId/player/$state',
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }
}
