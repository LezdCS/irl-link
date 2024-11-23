import 'package:dio/dio.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class SetChatSettingsUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final TwitchStreamInfos? twitchStreamInfos;

  SetChatSettingsUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.twitchStreamInfos,
  });
}

class SetChatSettingsUseCase
    implements
        UseCase<DataState<Response<dynamic>>, SetChatSettingsUseCaseParams> {
  final TwitchRepository twitchRepository;

  SetChatSettingsUseCase(this.twitchRepository);

  @override
  Future<DataState<Response<dynamic>>> call({
    required SetChatSettingsUseCaseParams params,
  }) {
    return twitchRepository.setChatSettings(
      params.accessToken,
      params.broadcasterId,
      params.twitchStreamInfos,
    );
  }
}
