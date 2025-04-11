import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
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
import 'package:quiver/iterables.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:twitch_chat/twitch_chat.dart';

class TwitchRepositoryImpl implements TwitchRepository {
  final Mappr _mappr;
  final TwitchRemoteDataSource _remoteDataSource;
  final TwitchLocalDataSource _localDataSource;
  final Talker talker;

  TwitchRepositoryImpl({
    required TwitchRemoteDataSource remoteDataSource,
    required TwitchLocalDataSource localDataSource,
    required this.talker,
  })  : _mappr = Mappr(),
        _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  ) async {
    try {
      final oauthData = await _remoteDataSource.getTwitchOauth(params);

      TwitchDecodedIdToken decodedIdToken = TwitchDecodedIdToken(
        preferredUsername: oauthData['decoded_token']['preferred_username'],
        profilePicture: oauthData['decoded_token']['picture'] ?? "",
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

      final twitchUserResult =
          await getTwitchUser(null, oauthData['access_token']);

      return twitchUserResult.fold(
        (l) {
          return Left(Failure("Error getting the Twitch user."));
        },
        (r) async {
          twitchUser = r;

          TwitchCredentials twitchData = TwitchCredentials(
            accessToken: oauthData['access_token'],
            idToken: oauthData['id_token'],
            refreshToken: oauthData['refresh_token'],
            expiresIn: oauthData['expires_in'],
            decodedIdToken: decodedIdToken,
            twitchUser: twitchUser,
            scopes: oauthData['scopes'],
          );

          TwitchCredentialsDTO twitchDataDTO = _mappr
              .convert<TwitchCredentials, TwitchCredentialsDTO>(twitchData);
          await _localDataSource.storeCredentials(twitchDataDTO);

          return Right(twitchData);
        },
      );
    } catch (e) {
      return Left(Failure("Unable to retrieve Twitch Data from Auth: $e"));
    }
  }

  @override
  Future<Either<Failure, TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  ) async {
    try {
      final response =
          await _remoteDataSource.refreshAccessToken(twitchData.refreshToken);

      TwitchCredentials newTwitchData = TwitchCredentials(
        accessToken: response['access_token'],
        refreshToken: response['refresh_token'],
        idToken: twitchData.idToken,
        decodedIdToken: twitchData.decodedIdToken,
        expiresIn: twitchData.expiresIn,
        twitchUser: twitchData.twitchUser,
        scopes: twitchData.scopes,
      );

      TwitchCredentialsDTO twitchDataDTO = _mappr
          .convert<TwitchCredentials, TwitchCredentialsDTO>(newTwitchData);
      await _localDataSource.storeCredentials(twitchDataDTO);

      await _remoteDataSource.validateToken(newTwitchData.accessToken);

      return Right(newTwitchData);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String accessToken) async {
    try {
      await _remoteDataSource.logout(accessToken);
      await _localDataSource.removeCredentials();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TwitchCredentials>> getTwitchFromLocal() async {
    final twitchDataDTO = await _localDataSource.getCredentials();

    if (twitchDataDTO != null) {
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
        return Left(Failure("Scopes have been updated, please login again."));
      }

      TwitchCredentials twitchData = _mappr
          .convert<TwitchCredentialsDTO, TwitchCredentials>(twitchDataDTO);

      return Right(twitchData);
    } else {
      return Left(Failure("No Twitch Data in local storage"));
    }
  }

  @override
  Future<Either<Failure, TwitchUser>> getTwitchUser(
    String? username,
    String accessToken,
  ) async {
    try {
      final twitchUserDTO =
          await _remoteDataSource.getTwitchUser(username, accessToken);
      TwitchUser twitchUser =
          _mappr.convert<TwitchUserDTO, TwitchUser>(twitchUserDTO);
      return Right(twitchUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TwitchUser>>> getTwitchUsers(
    List ids,
    String accessToken,
  ) async {
    try {
      var chunks = partition(ids, 100);
      List<TwitchUser> twitchUsers = <TwitchUser>[];

      for (var chunk in chunks) {
        await Future.delayed(const Duration(seconds: 5), () async {
          final usersDTO =
              await _remoteDataSource.getTwitchUsers(chunk, accessToken);
          twitchUsers.addAll(
            usersDTO
                .map((user) => _mappr.convert<TwitchUserDTO, TwitchUser>(user)),
          );
        });
      }

      return Right(twitchUsers);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TwitchStreamInfos>> getStreamInfo(
    String accessToken,
    String broadcasterId,
  ) async {
    try {
      final streamInfosDto =
          await _remoteDataSource.getStreamInfo(accessToken, broadcasterId);
      TwitchStreamInfos streamInfos = _mappr
          .convert<TwitchStreamInfosDto, TwitchStreamInfos>(streamInfosDto);
      return Right(streamInfos);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setChatSettings(
    String accessToken,
    String broadcasterId,
    TwitchStreamInfos? twitchStreamInfos,
  ) async {
    try {
      await _remoteDataSource.setChatSettings(
        accessToken,
        broadcasterId,
        twitchStreamInfos,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setStreamTitle(
    String accessToken,
    String broadcasterId,
    String title,
  ) async {
    try {
      await _remoteDataSource.setStreamTitle(accessToken, broadcasterId, title);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  ) async {
    try {
      await _remoteDataSource.endPrediction(
        accessToken,
        broadcasterId,
        predictionId,
        status,
        winningOutcomeId,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TwitchPoll>> endPoll(
    String accessToken,
    String broadcasterId,
    String pollId,
    String status,
  ) async {
    try {
      final pollDTO = await _remoteDataSource.endPoll(
        accessToken,
        broadcasterId,
        pollId,
        status,
      );
      TwitchPoll poll = _mappr.convert<TwitchPollDTO, TwitchPoll>(pollDTO);
      return Right(poll);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TwitchPoll>> createPoll(
    String accessToken,
    String broadcasterId,
    TwitchPoll newPoll,
  ) async {
    try {
      final poll = await _remoteDataSource.createPoll(
        accessToken,
        broadcasterId,
        newPoll,
      );
      return Right(poll);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  ) async {
    try {
      await _remoteDataSource.banUser(
        accessToken,
        broadcasterId,
        message,
        duration,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  ) async {
    try {
      await _remoteDataSource.deleteMessage(
        accessToken,
        broadcasterId,
        message,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
