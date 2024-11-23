import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetStreamInfoUseCaseParams {
  final String accessToken;
  final String broadcasterId;

  GetStreamInfoUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
  });
}

class GetStreamInfoUseCase
    implements
        UseCase<DataState<TwitchStreamInfos>, GetStreamInfoUseCaseParams> {
  final TwitchRepository twitchRepository;

  GetStreamInfoUseCase(this.twitchRepository);

  @override
  Future<DataState<TwitchStreamInfos>> call({
    required GetStreamInfoUseCaseParams params,
  }) {
    return twitchRepository.getStreamInfo(
      params.accessToken,
      params.broadcasterId,
    );
  }
}
