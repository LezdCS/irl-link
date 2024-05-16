// import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/entities/stream_elements/se_activity_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_me_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_overlay_dto.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
// import 'package:irllink/src/core/utils/constants.dart';

import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamelementsRepositoryImpl extends StreamelementsRepository {
  @override
  Future<DataState<void>> login(StreamelementsAuthParams params) async {
    try {
      // final url = Uri.https(kStreamelementsUrlBase, kStreamelementsAuthPath, {
      //   'client_id': params.clientId,
      //   'redirect_uri': params.redirectUri,
      //   'response_type': params.responseType,
      //   'scope': params.scopes,
      // });

      // final result = await FlutterWebAuth.authenticate(
      //   url: url.toString(),
      //   callbackUrlScheme: kRedirectScheme,
      //   preferEphemeral: true,
      // );

      // final code = Uri.parse(result).queryParameters['access_token'];
      // final refreshToken = Uri.parse(result).queryParameters['refresh_token'];
      // final expiresIn = Uri.parse(result).queryParameters['expires_in'];

      return const DataSuccess(null);
    } catch (e) {
      return const DataFailed("Unable to retrieve StreamElements token");
    }
  }

  @override
  Future<DataState<void>> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
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
