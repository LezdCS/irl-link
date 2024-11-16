import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsUpdatePlayerStateParams {
  final String token;
  final String channel;
  final String state;

  StreamElementsUpdatePlayerStateParams({
    required this.token,
    required this.channel,
    required this.state,
  });
}

class StreamElementsUpdatePlayerStateUseCase
    implements UseCase<void, StreamElementsUpdatePlayerStateParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsUpdatePlayerStateUseCase(
      {required this.streamelementsRepository});

  @override
  Future<void> call({required StreamElementsUpdatePlayerStateParams params}) {
    return streamelementsRepository.updatePlayerState(
        params.token, params.channel, params.state);
  }
}
