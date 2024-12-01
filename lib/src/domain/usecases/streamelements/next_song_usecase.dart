import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsNextSongParams {
  final String token;
  final String channel;

  StreamElementsNextSongParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsNextSongUseCase
    implements UseCase<Either<Failure, void>, StreamElementsNextSongParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsNextSongUseCase({required this.streamelementsRepository});

  @override
  Future<Either<Failure, void>> call({
    required StreamElementsNextSongParams params,
  }) {
    return streamelementsRepository.nextSong(params.token, params.channel);
  }
}
