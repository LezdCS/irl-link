import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';

class LoginEvents {
  final TwitchUseCase twitchUseCase;
  LoginEvents({required this.twitchUseCase});

  Future<DataState<TwitchCredentials>> getTwitchFromLocal() {
    return twitchUseCase.getTwitchFromLocal();
  }

  Future<DataState<TwitchCredentials>> refreshAccessToken(TwitchCredentials twitchCredentials) {
    return twitchUseCase.refreshAccessToken(twitchData: twitchCredentials);
  }

  Future<DataState<TwitchCredentials>> getTwitchOauth(
      {TwitchAuthParams? params}) {
    return twitchUseCase.getTwitchOauth(params: params!);
  }
}
