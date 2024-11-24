import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
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
    implements UseCase<Either<Failure, void>, SetChatSettingsUseCaseParams> {
  final TwitchRepository twitchRepository;

  SetChatSettingsUseCase(this.twitchRepository);

  @override
  Future<Either<Failure, void>> call({
    required SetChatSettingsUseCaseParams params,
  }) {
    return twitchRepository.setChatSettings(
      params.accessToken,
      params.broadcasterId,
      params.twitchStreamInfos,
    );
  }
}
