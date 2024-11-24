import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class EndPredictionUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final String predictionId;
  final String status;
  final String? winningOutcomeId;

  EndPredictionUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.predictionId,
    required this.status,
    this.winningOutcomeId,
  });
}

class EndPredictionUseCase
    implements UseCase<Either<Failure, void>, EndPredictionUseCaseParams> {
  final TwitchRepository twitchRepository;

  EndPredictionUseCase({required this.twitchRepository});

  @override
  Future<Either<Failure, void>> call({
    required EndPredictionUseCaseParams params,
  }) {
    return twitchRepository.endPrediction(
      params.accessToken,
      params.broadcasterId,
      params.predictionId,
      params.status,
      params.winningOutcomeId,
    );
  }
}
