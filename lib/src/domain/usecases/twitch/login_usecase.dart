import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class LoginUseCase
    implements UseCase<DataState<TwitchCredentials>, TwitchAuthParams> {
  final TwitchRepository twitchRepository;

  LoginUseCase(this.twitchRepository);

  @override
  Future<DataState<TwitchCredentials>> call({
    required TwitchAuthParams params,
  }) {
    return twitchRepository.getTwitchOauth(params);
  }
}
