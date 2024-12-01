import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsGetSongQueueParams {
  final String token;
  final String channel;

  StreamElementsGetSongQueueParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsGetSongQueueUseCase
    implements
        UseCase<Either<Failure, List<SeSong>>,
            StreamElementsGetSongQueueParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsGetSongQueueUseCase({required this.streamelementsRepository});

  @override
  Future<Either<Failure, List<SeSong>>> call({
    required StreamElementsGetSongQueueParams params,
  }) {
    return streamelementsRepository.getSongQueue(params.token, params.channel);
  }
}
