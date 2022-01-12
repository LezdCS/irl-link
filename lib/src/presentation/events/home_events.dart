import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
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

  Future<DataState<TwitchUser>> getTwitchUser({
    String? username,
    required String accessToken,
  }) {
    return twitchUseCase.getTwitchUser(
      username: username,
      accessToken: accessToken,
    );
  }

  Future<DataState<List<TwitchBadge>>> getTwitchGlobalBadges(
      {required String accessToken}) {
    return twitchUseCase.getTwitchGlobalBadges(accessToken: accessToken);
  }

  Future<DataState<List<TwitchBadge>>> getTwitchChannelBadges(
      {required String accessToken, required String broadcasterId}) {
    return twitchUseCase.getTwitchChannelBadges(
      accessToken: accessToken,
      broadcasterId: broadcasterId,
    );
  }

  Future<DataState<List<Emote>>> getTwitchEmotes(String accessToken) {
    return twitchUseCase.getTwitchEmotes(accessToken: accessToken);
  }

  Future<DataState<List<Emote>>> getTwitchChannelEmotes(
      String accessToken, String broadcasterId) {
    return twitchUseCase.getTwitchChannelEmotes(
      accessToken: accessToken,
      broadcasterId: broadcasterId,
    );
  }

  Future<DataState<List<Emote>>> getTwitchSetsEmotes(
      String accessToken, List<String> setId) {
    return twitchUseCase.getTwitchSetsEmotes(
      accessToken: accessToken,
      setId: setId,
    );
  }

  Future<DataState<List<Emote>>> getTwitchCheerEmotes(
      String accessToken, String broadcasterId) {
    return twitchUseCase.getTwitchCheerEmotes(
      accessToken: accessToken,
      broadcasterId: broadcasterId,
    );
  }

  Future<DataState<List<Emote>>> getFrankerfacezEmotes({
    required String broadcasterId,
  }) {
    return twitchUseCase.getFrankerfacezEmotes(broadcasterId: broadcasterId);
  }

  Future<DataState<List<Emote>>> getBttvChannelEmotes({
    required String broadcasterId,
  }) {
    return twitchUseCase.getBttvChannelEmotes(broadcasterId: broadcasterId);
  }

  Future<DataState<List<Emote>>> getBttvGlobalEmotes() {
    return twitchUseCase.getBttvGlobalEmotes();
  }
}
