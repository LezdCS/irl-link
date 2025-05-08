import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class LogoutKickUseCase implements UseCase<Either<Failure, void>, String> {
  final KickRepository kickRepository;

  LogoutKickUseCase(this.kickRepository);

  @override
  Future<Either<Failure, void>> call({
    required String params,
  }) {
    return kickRepository.logout(params);
  }
}
