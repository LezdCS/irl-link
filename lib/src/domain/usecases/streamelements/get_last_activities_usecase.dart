import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetLastActivitiesParams {
  final String token;
  final String channel;

  StreamElementsGetLastActivitiesParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsGetLastActivitiesUseCase
    implements
        UseCase<Either<Failure, List<SeActivity>>,
            StreamElementsGetLastActivitiesParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetLastActivitiesUseCase({
    required this.streamelementsRepository,
  });

  @override
  Future<Either<Failure, List<SeActivity>>> call({
    required StreamElementsGetLastActivitiesParams params,
  }) {
    return streamelementsRepository.getLastActivities(
      params.token,
      params.channel,
    );
  }
}
