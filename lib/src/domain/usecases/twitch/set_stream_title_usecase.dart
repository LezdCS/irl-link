import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class SetStreamTitleUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final String title;

  SetStreamTitleUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.title,
  });
}

class SetStreamTitleUseCase
    implements UseCase<DataState<void>, SetStreamTitleUseCaseParams> {
  final TwitchRepository twitchRepository;

  SetStreamTitleUseCase(this.twitchRepository);

  @override
  Future<DataState<void>> call({
    required SetStreamTitleUseCaseParams params,
  }) {
    return twitchRepository.setStreamTitle(
      params.accessToken,
      params.broadcasterId,
      params.title,
    );
  }
}
