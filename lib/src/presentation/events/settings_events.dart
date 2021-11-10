import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';

class SettingsEvents {
  final TwitchUseCase twitchUseCase;
  SettingsEvents({required this.twitchUseCase});

  Future<DataState<String>> logout() {
    return twitchUseCase.logout();
  }
}
