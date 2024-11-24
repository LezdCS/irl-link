import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class RefreshTwitchTokenUseCase
    implements UseCase<Either<Failure, TwitchCredentials>, TwitchCredentials> {
  final TwitchRepository twitchRepository;

  RefreshTwitchTokenUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, TwitchCredentials>> call({
    required TwitchCredentials params,
  }) {
    return twitchRepository.refreshAccessToken(params);
  }
}
