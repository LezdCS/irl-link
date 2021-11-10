import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';

class LoginEvents {
  final TwitchUseCase twitchUseCase;
  LoginEvents({required this.twitchUseCase});

  Future<DataState<Twitch>> getTwitchFromLocal() {
    return twitchUseCase.getTwitchFromLocal();
  }

  Future<DataState<Twitch>> getTwitchOauth({TwitchRequestParams? params}) {
    return twitchUseCase.getTwitchOauth(params: params!);
  }
}
