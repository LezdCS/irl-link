import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsReplayActivityParams {
  final String token;
  final SeActivity activity;

  StreamElementsReplayActivityParams({
    required this.token,
    required this.activity,
  });
}

class StreamElementsReplayActivityUseCase
    implements
        UseCase<Either<Failure, void>, StreamElementsReplayActivityParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsReplayActivityUseCase({required this.streamelementsRepository});

  @override
  Future<Either<Failure, void>> call({
    required StreamElementsReplayActivityParams params,
  }) {
    return streamelementsRepository.replayActivity(
      params.token,
      params.activity,
    );
  }
}
