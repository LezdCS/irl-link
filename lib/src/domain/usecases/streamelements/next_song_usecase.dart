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
    implements UseCase<void, StreamElementsNextSongParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsNextSongUseCase({required this.streamelementsRepository});

  @override
  Future<void> call({required StreamElementsNextSongParams params}) {
    return streamelementsRepository.nextSong(params.token, params.channel);
  }
}
