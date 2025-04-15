import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class LoginKickUseCase
    implements UseCase<Either<Failure, KickCredentials>, KickAuthParams> {
  final KickRepository kickRepository;

  LoginKickUseCase(this.kickRepository);

  @override
  Future<Either<Failure, KickCredentials>> call({
    required KickAuthParams params,
  }) {
    return kickRepository.getKickOauth(params);
  }
}
