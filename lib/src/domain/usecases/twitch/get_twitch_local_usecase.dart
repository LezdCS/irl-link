import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetTwitchLocalUseCase
    implements UseCase<Either<Failure, TwitchCredentials>, void> {
  final TwitchRepository twitchRepository;

  GetTwitchLocalUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, TwitchCredentials>> call({void params}) {
    return twitchRepository.getTwitchFromLocal();
  }
}
