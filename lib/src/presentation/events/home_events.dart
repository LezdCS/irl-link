import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';

class HomeEvents {
  final TwitchUseCase twitchUseCase;
  HomeEvents({required this.twitchUseCase});

  Future<DataState<TwitchCredentials>> getTwitchFromLocal() {
    return twitchUseCase.getTwitchFromLocal();
  }

  Future<DataState<TwitchCredentials>> getTwitchOauth(
      {TwitchAuthParams? params}) {
    return twitchUseCase.getTwitchOauth(params: params!);
  }

  Future<DataState<List<TwitchBadge>>> getTwitchBadges(
      String accessToken, String userId) {
    return twitchUseCase.getTwitchBadges(
        accessToken: accessToken, userId: userId);
  }

  Future<DataState<List<Emote>>> getTwitchEmotes(String accessToken) {
    return twitchUseCase.getTwitchEmotes(accessToken: accessToken);
  }
}
