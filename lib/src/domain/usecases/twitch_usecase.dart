import 'package:irllink/src/core/params/twitch_request_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class TwitchUseCase {
  final TwitchRepository twitchRepository;
  TwitchUseCase({required this.twitchRepository});

  Future<DataState<Twitch>> getTwitchFromLocal() {
    return twitchRepository.getTwitchFromLocal();
  }

  Future<DataState<Twitch>> getTwitchOauth({TwitchRequestParams? params}) {
    return twitchRepository.getTwitchOauth(params!);
  }

  Future<DataState<String>> logout() {
    return twitchRepository.logout();
  }
}
