import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:twitch_chat/twitch_chat.dart';

class BanUserUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final ChatMessage message;
  final int? duration;

  BanUserUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.message,
    required this.duration,
  });
}

class BanUserUseCase implements UseCase<void, BanUserUseCaseParams> {
  final TwitchRepository twitchRepository;

  BanUserUseCase(this.twitchRepository);

  @override
  Future<void> call({
    required BanUserUseCaseParams params,
  }) {
    return twitchRepository.banUser(
      params.accessToken,
      params.broadcasterId,
      params.message,
      params.duration,
    );
  }
}
