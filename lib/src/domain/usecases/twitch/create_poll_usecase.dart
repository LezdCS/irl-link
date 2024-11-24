import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class CreatePollUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final TwitchPoll newPoll;

  CreatePollUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.newPoll,
  });
}

class CreatePollUseCase
    implements UseCase<Either<Failure, TwitchPoll>, CreatePollUseCaseParams> {
  final TwitchRepository twitchRepository;

  CreatePollUseCase({required this.twitchRepository});

  @override
  Future<Either<Failure, TwitchPoll>> call({
    required CreatePollUseCaseParams params,
  }) {
    return twitchRepository.createPoll(
      params.accessToken,
      params.broadcasterId,
      params.newPoll,
    );
  }
}
