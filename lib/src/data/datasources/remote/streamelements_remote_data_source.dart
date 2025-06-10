import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/stream_elements/se_activity_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_me_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_overlay_dto.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class StreamelementsRemoteDataSource {
  Future<Map<String, dynamic>> validateToken(String accessToken);
  Future<SeCredentialsDTO> refreshToken(
    String refreshToken,
    String previousScopes,
  );
  Future<void> revokeToken(String accessToken);
  Future<void> replayActivity(String token, String channel, String activityId);
  Future<List<SeActivityDTO>> getLastActivities(String token, String channel);
  Future<List<SeOverlayDTO>> getOverlays(String token, String channel);
  Future<SeMeDTO> getMe(String token);
  Future<void> nextSong(String token, String userId);
  Future<void> removeSong(String token, String userId, String songId);
  Future<void> resetQueue(String token, String userId);
  Future<List<SeSong>> getSongQueue(String token, String userId);
  Future<SeSong?> getSongPlaying(String token, String userId);
  Future<void> updatePlayerState(String token, String userId, String state);
}

class StreamelementsRemoteDataSourceImpl
    implements StreamelementsRemoteDataSource {
  final Dio dioClient;
  final Talker talker;

  StreamelementsRemoteDataSourceImpl({
    required this.dioClient,
    required this.talker,
  });

  @override
  Future<Map<String, dynamic>> validateToken(String accessToken) async {
    try {
      dioClient.options.headers["authorization"] = "OAuth $accessToken";
      final response = await dioClient.get('/oauth2/validate');
      talker.logCustom(StreamElementsLog('StreamElements token validated.'));
      return response.data;
    } on DioException catch (e) {
      talker.error(e.message);
      throw Exception("Unable to validate StreamElements token: ${e.message}");
    }
  }

  @override
  Future<SeCredentialsDTO> refreshToken(
    String refreshToken,
    String previousScopes,
  ) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String apiRefreshTokenUrl =
        remoteConfig.getString('irllink_refresh_se_token_url');
    if (kDebugMode) {
      apiRefreshTokenUrl =
          remoteConfig.getString('irllink_refresh_se_token_url_dev');
    }

    try {
      final response = await dioClient.get(
        apiRefreshTokenUrl,
        queryParameters: {'refresh_token': refreshToken},
      );

      talker.logCustom(StreamElementsLog('StreamElements token refreshed.'));

      return SeCredentialsDTO(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        expiresIn: response.data['expires_in'],
        scopes: previousScopes,
      );
    } on DioException catch (e) {
      throw Exception("Refresh SE token failed: ${e.message}");
    }
  }

  @override
  Future<void> revokeToken(String accessToken) async {
    try {
      await dioClient.post(
        '/oauth2/revoke',
        queryParameters: {
          'client_id': 'irllink',
          'token': accessToken,
        },
      );
    } on DioException catch (e) {
      throw Exception("Unable to revoke StreamElements token: ${e.message}");
    }
  }

  @override
  Future<void> replayActivity(
    String token,
    String channel,
    String activityId,
  ) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      await dioClient.post(
        '/kappa/v2/activities/$channel/$activityId/replay',
      );
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SeActivityDTO>> getLastActivities(
    String token,
    String channel,
  ) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      final response = await dioClient.get(
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

      return (response.data as List)
          .map((activity) => SeActivityDTO.fromJson(activity))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SeOverlayDTO>> getOverlays(String token, String channel) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      final response = await dioClient.get(
        '/kappa/v2/overlays/$channel',
        queryParameters: {'search': ' ', 'type': 'regular'},
      );

      return (response.data['docs'] as List)
          .map((overlay) => SeOverlayDTO.fromJson(overlay))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SeMeDTO> getMe(String token) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      final response = await dioClient.get('/kappa/v2/channels/me');
      return SeMeDTO.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> nextSong(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.post('/kappa/v2/songrequest/$userId/skip');
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeSong(String token, String userId, String songId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.delete('/kappa/v2/songrequest/$userId/queue/$songId');
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> resetQueue(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      await dioClient.delete('/kappa/v2/songrequest/$userId/queue/');
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SeSong>> getSongQueue(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "Bearer $token";
      final response =
          await dioClient.get('/kappa/v2/songrequest/$userId/queue');

      return (response.data as List)
          .map(
            (song) => SeSong(
              channel: song['channel'],
              duration: song['duration'],
              id: song['_id'],
              title: song['title'],
              videoId: song['videoId'],
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SeSong?> getSongPlaying(String token, String userId) async {
    try {
      dioClient.options.headers["Authorization"] = "oAuth $token";
      final response =
          await dioClient.get('/kappa/v2/songrequest/$userId/playing');

      if (response.data != null) {
        return SeSong(
          channel: response.data['channel'],
          duration: response.data['duration'],
          id: response.data['_id'],
          title: response.data['title'],
          videoId: response.data['videoId'],
        );
      }
      return null;
    } on DioException catch (e) {
      throw Exception(e.toString());
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
      await dioClient.post('/kappa/v2/songrequest/$userId/player/$state');
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
