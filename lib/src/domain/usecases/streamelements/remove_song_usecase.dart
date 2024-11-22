import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsRemoveSongParams {
  final String token;
  final String channel;
  final String songId;

  StreamElementsRemoveSongParams({
    required this.token,
    required this.channel,
    required this.songId,
  });
}

class StreamElementsRemoveSongUseCase
    implements UseCase<void, StreamElementsRemoveSongParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsRemoveSongUseCase({required this.streamelementsRepository});

  @override
  Future<void> call({required StreamElementsRemoveSongParams params}) {
    return streamelementsRepository.removeSong(
      params.token,
      params.channel,
      params.songId,
    );
  }
}
