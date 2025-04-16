import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/datasources/local/kick_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/kick_remote_data_source.dart';
import 'package:irllink/src/data/entities/kick/kick_category_dto.dart';
import 'package:irllink/src/data/entities/kick/kick_credentials_dto.dart';
import 'package:irllink/src/data/entities/kick/kick_user_dto.dart';
import 'package:irllink/src/domain/entities/kick/category.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/kick/kick_user.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class KickRepositoryImpl implements KickRepository {
  final Mappr _mappr;
  final KickRemoteDataSource _remoteDataSource;
  final KickLocalDataSource _localDataSource;
  final Talker talker;

  KickRepositoryImpl({
    required KickRemoteDataSource remoteDataSource,
    required KickLocalDataSource localDataSource,
    required this.talker,
  })  : _mappr = Mappr(),
        _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, KickCredentials>> getKickOauth(
    KickAuthParams params,
  ) async {
    try {
      final oauthData = await _remoteDataSource.getKickOauth(params);

      final kickUserResult = await getKickUser(oauthData['access_token']);
      talker.logCustom(KickLog(kickUserResult.toString()));

      return kickUserResult.fold(
        (l) {
          return Left(Failure("Error getting the Kick user."));
        },
        (r) async {
          KickCredentials kickData = KickCredentials(
            accessToken: oauthData['access_token'],
            refreshToken: oauthData['refresh_token'],
            expiresIn: oauthData['expires_in'],
            kickUser: r,
            scopes: oauthData['scopes'],
          );

          KickCredentialsDTO kickDataDTO =
              _mappr.convert<KickCredentials, KickCredentialsDTO>(kickData);
          await _localDataSource.storeCredentials(kickDataDTO);

          return Right(kickData);
        },
      );
    } catch (e) {
      return Left(Failure("Unable to retrieve Kick Data from Auth: $e"));
    }
  }

  @override
  Future<Either<Failure, KickCredentials>> refreshAccessToken(
    KickCredentials kickData,
  ) async {
    try {
      final response =
          await _remoteDataSource.refreshAccessToken(kickData.refreshToken);

      KickCredentials newKickData = KickCredentials(
        accessToken: response['access_token'],
        refreshToken: response['refresh_token'],
        expiresIn: kickData.expiresIn,
        kickUser: kickData.kickUser,
        scopes: kickData.scopes,
      );

      KickCredentialsDTO kickDataDTO =
          _mappr.convert<KickCredentials, KickCredentialsDTO>(newKickData);
      await _localDataSource.storeCredentials(kickDataDTO);

      return Right(newKickData);
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
  Future<Either<Failure, KickCredentials>> getKickFromLocal() async {
    final kickDataDTO = await _localDataSource.getCredentials();

    if (kickDataDTO != null) {
      KickCredentials kickData =
          _mappr.convert<KickCredentialsDTO, KickCredentials>(kickDataDTO);

      return Right(kickData);
    } else {
      return Left(Failure("No Kick Data in local storage"));
    }
  }

  @override
  Future<Either<Failure, KickUser>> getKickUser(
    String accessToken,
  ) async {
    try {
      final kickUserDTO = await _remoteDataSource.getKickUser(accessToken);
      KickUser kickUser = _mappr.convert<KickUserDTO, KickUser>(kickUserDTO);
      return Right(kickUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KickCategory>>> getCategories({
    String? searchQuery,
    int? page,
  }) async {
    try {
      final result = await _remoteDataSource.getCategories(
        searchQuery: searchQuery,
        page: page,
      );

      return result.fold(
        (failure) => Left(failure),
        (dtos) {
          final categories = dtos
              .map((dto) => _mappr.convert<KickCategoryDTO, KickCategory>(dto))
              .toList();
          return Right(categories);
        },
      );
    } catch (e) {
      talker.error('Failed to fetch categories: $e');
      return Left(Failure(e.toString()));
    }
  }
}
