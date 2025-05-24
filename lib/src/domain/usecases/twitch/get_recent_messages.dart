import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetRecentMessagesUseCaseParams {
  final String channelName;
  final int limit;

  GetRecentMessagesUseCaseParams({
    required this.channelName,
    required this.limit,
  });
}

class GetRecentMessagesUseCase
    implements UseCase<Either<Failure, void>, GetRecentMessagesUseCaseParams> {
  final TwitchRepository twitchRepository;

  GetRecentMessagesUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, List<String>>> call({
    required GetRecentMessagesUseCaseParams params,
  }) {
    return twitchRepository.getRecentMessages(
      params.channelName,
      params.limit,
    );
  }
}
