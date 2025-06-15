import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/datasources/local/streamelements_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/streamelements_remote_data_source.dart';
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
  final StreamelementsLocalDataSource _localDataSource;
  final StreamelementsRemoteDataSource _remoteDataSource;

  StreamelementsRepositoryImpl({
    required this.talker,
    required StreamelementsLocalDataSource localDataSource,
    required StreamelementsRemoteDataSource remoteDataSource,
  })  : _mappr = Mappr(),
        _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SeCredentials>> login(
    StreamelementsAuthParams params,
  ) async {
    try {
      Uri url = Uri.https('api.streamelements.com', '/oauth2/authorize', {
        'client_id': params.clientId,
        'redirect_uri': params.redirectUri,
        'response_type': params.responseType,
        'scope': params.scopes,
      });

      String result = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: kRedirectScheme,
        options: const FlutterWebAuth2Options(
          preferEphemeral: true,
          useWebview: true,
        ),
      );

      String accessToken = Uri.parse(result).queryParameters['access_token']!;
      String refreshToken = Uri.parse(result).queryParameters['refresh_token']!;
      int expiresIn =
          int.parse(Uri.parse(result).queryParameters['expires_in']!);
      talker.logCustom(
        StreamElementsLog('StreamElements login successful.'),
      );

      final validateTokenResult =
          await _remoteDataSource.validateToken(accessToken);
      String scopes = validateTokenResult['scopes'].join(' ');

      SeCredentialsDTO seCredentialDTO = SeCredentialsDTO(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
        scopes: scopes,
      );

      await _localDataSource.storeCredentials(seCredentialDTO);
      SeCredentials seCredentials =
          _mappr.convert<SeCredentialsDTO, SeCredentials>(seCredentialDTO);
      return Right(seCredentials);
    } catch (e) {
      return Left(Failure("Unable to retrieve StreamElements token: $e"));
    }
  }

  @override
  Future<Either<Failure, SeCredentials>> refreshAccessToken(
    SeCredentials seCredentials,
  ) async {
    try {
      final newSeCredentialDTO = await _remoteDataSource.refreshToken(
        seCredentials.refreshToken,
        seCredentials.scopes,
      );
      await _localDataSource.storeCredentials(newSeCredentialDTO);

      await _remoteDataSource.validateToken(newSeCredentialDTO.accessToken);

      SeCredentials newSeCredentials =
          _mappr.convert<SeCredentialsDTO, SeCredentials>(newSeCredentialDTO);

      return Right(newSeCredentials);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect(String accessToken) async {
    try {
      await _remoteDataSource.revokeToken(accessToken);
      await _localDataSource.removeCredentials();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> replayActivity(
    String token,
    SeActivity activity,
  ) async {
    try {
      await _remoteDataSource.replayActivity(
        token,
        activity.channel,
        activity.id,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeActivity>>> getLastActivities(
    String token,
    String channel,
  ) async {
    try {
      final activitiesDTO =
          await _remoteDataSource.getLastActivities(token, channel);
      final activities = activitiesDTO
          .map(
            (activity) => _mappr.convert<SeActivityDTO, SeActivity>(activity),
          )
          .toList();
      return Right(activities);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeOverlay>>> getOverlays(
    String token,
    String channel,
  ) async {
    try {
      final overlaysDTO = await _remoteDataSource.getOverlays(token, channel);
      final overlays = overlaysDTO
          .map((overlay) => _mappr.convert<SeOverlayDTO, SeOverlay>(overlay))
          .toList();
      return Right(overlays);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeMe>> getMe(String token) async {
    try {
      final meDTO = await _remoteDataSource.getMe(token);
      final me = _mappr.convert<SeMeDTO, SeMe>(meDTO);
      return Right(me);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> nextSong(String token, String userId) async {
    try {
      await _remoteDataSource.nextSong(token, userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeSong(
    String token,
    String userId,
    String songId,
  ) async {
    try {
      await _remoteDataSource.removeSong(token, userId, songId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetQueue(String token, String userId) async {
    try {
      await _remoteDataSource.resetQueue(token, userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeSong>>> getSongQueue(
    String token,
    String userId,
  ) async {
    try {
      final songs = await _remoteDataSource.getSongQueue(token, userId);
      return Right(songs);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeSong>> getSongPlaying(
    String token,
    String userId,
  ) async {
    try {
      final song = await _remoteDataSource.getSongPlaying(token, userId);
      if (song != null) {
        return Right(song);
      }
      return Left(Failure('There is no playing song for this user.'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePlayerState(
    String token,
    String userId,
    String state,
  ) async {
    try {
      await _remoteDataSource.updatePlayerState(token, userId, state);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeCredentials>> getSeCredentialsFromLocal() async {
    final seCredentialsDTO = await _localDataSource.getCredentials();
    debugPrint('seCredentialsDTO: $seCredentialsDTO');

    if (seCredentialsDTO != null) {
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
        talker.logCustom(
          StreamElementsLog(
            'StreamElements scopes changed, user need to relogin.',
          ),
        );
        disconnect(seCredentialsDTO.accessToken);
        return Left(Failure("Scopes have been updated, please login again."));
      }

      SeCredentials seCredentials =
          _mappr.convert<SeCredentialsDTO, SeCredentials>(seCredentialsDTO);

      //refresh the access token to be sure the token is going to be valid after starting the app
      final refreshResult = await refreshAccessToken(seCredentials);
      return refreshResult.fold(
        (l) => Left(Failure("Error refreshing SE Token")),
        (r) => Right(r),
      );
    } else {
      return Left(Failure("No SE Data in local storage"));
    }
  }
}
