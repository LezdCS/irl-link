import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class RefreshTwitchTokenUseCase
    implements UseCase<DataState<TwitchCredentials>, TwitchCredentials> {
  final TwitchRepository twitchRepository;

  RefreshTwitchTokenUseCase(this.twitchRepository);

  @override
  Future<DataState<TwitchCredentials>> call({
    required TwitchCredentials params,
  }) {
    return twitchRepository.refreshAccessToken(params);
  }
}
