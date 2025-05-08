import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class KickRefreshTokenUseCase
    implements UseCase<Either<Failure, KickCredentials>, KickCredentials> {
  final KickRepository kickRepository;

  KickRefreshTokenUseCase(this.kickRepository);

  @override
  Future<Either<Failure, KickCredentials>> call({
    required KickCredentials params,
  }) {
    return kickRepository.refreshAccessToken(
      params,
    );
  }
}
