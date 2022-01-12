import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class TwitchUseCase {
  final TwitchRepository twitchRepository;
  TwitchUseCase({required this.twitchRepository});

  Future<DataState<TwitchCredentials>> getTwitchFromLocal() {
    return twitchRepository.getTwitchFromLocal();
  }

  Future<DataState<TwitchCredentials>> getTwitchOauth(
      {required TwitchAuthParams params}) {
    return twitchRepository.getTwitchOauth(params);
  }

  Future<DataState<TwitchUser>> getTwitchUser({
    String? username,
    required String accessToken,
  }) {
    return twitchRepository.getTwitchUser(username, accessToken);
  }

  Future<DataState<String>> logout() {
    return twitchRepository.logout();
  }

  Future<DataState<List<TwitchBadge>>> getTwitchGlobalBadges(
      {required String accessToken}) {
    return twitchRepository.getTwitchGlobalBadges(accessToken);
  }

  Future<DataState<List<TwitchBadge>>> getTwitchChannelBadges(
      {required String accessToken, required String broadcasterId}) {
    return twitchRepository.getTwitchChannelBadges(accessToken, broadcasterId);
  }

  Future<DataState<List<Emote>>> getTwitchEmotes(
      {required String accessToken}) {
    return twitchRepository.getTwitchEmotes(accessToken);
  }

  Future<DataState<List<Emote>>> getTwitchChannelEmotes(
      {required String accessToken, required String broadcasterId}) {
    return twitchRepository.getTwitchChannelEmotes(accessToken, broadcasterId);
  }

  Future<DataState<List<Emote>>> getTwitchSetsEmotes({
    required String accessToken,
    required List<String> setId,
  }) {
    return twitchRepository.getTwitchSetsEmotes(accessToken, setId);
  }

  Future<DataState<List<Emote>>> getTwitchCheerEmotes({
    required String accessToken,
    required String broadcasterId,
  }) {
    return twitchRepository.getTwitchCheerEmotes(accessToken, broadcasterId);
  }
}
