import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class LogoutUseCase implements UseCase<Either<Failure, void>, String> {
  final TwitchRepository twitchRepository;

  LogoutUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, void>> call({
    required String params,
  }) {
    return twitchRepository.logout(params);
  }
}
