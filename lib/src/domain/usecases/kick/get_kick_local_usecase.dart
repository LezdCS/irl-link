import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class GetKickLocalUseCase
    implements UseCase<Either<Failure, KickCredentials>, void> {
  final KickRepository kickRepository;

  GetKickLocalUseCase(this.kickRepository);

  @override
  Future<Either<Failure, KickCredentials>> call({void params}) {
    return kickRepository.getKickFromLocal();
  }
}
