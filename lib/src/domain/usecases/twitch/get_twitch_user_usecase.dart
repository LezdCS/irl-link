import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class GetTwitchUserUseCaseParams {
  final String? username;
  final String accessToken;

  GetTwitchUserUseCaseParams({this.username, required this.accessToken});
}

class GetTwitchUserUseCase
    implements UseCase<DataState<TwitchUser>, GetTwitchUserUseCaseParams> {
  final TwitchRepository twitchRepository;

  GetTwitchUserUseCase(this.twitchRepository);

  @override
  Future<DataState<TwitchUser>> call({
    required GetTwitchUserUseCaseParams params,
  }) {
    return twitchRepository.getTwitchUser(params.username, params.accessToken);
  }
}
