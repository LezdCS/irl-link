import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';

abstract class TwitchRepository {
  Future<DataState<TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  );

  Future<DataState<TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  );

  Future<DataState<TwitchCredentials>> getTwitchFromLocal();

  Future<void> setTwitchOnLocal(
    TwitchCredentials twitchData,
  );

  Future<DataState<String>> logout();

  Future<DataState<TwitchUser>> getTwitchUser(
    String? username,
    String accessToken,
  );

  Future<DataState<List<TwitchBadge>>> getTwitchGlobalBadges(
    String accessToken,
  );

  Future<DataState<List<TwitchBadge>>> getTwitchChannelBadges(
    String accessToken,
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> getTwitchEmotes(String accessToken);

  Future<DataState<List<Emote>>> getTwitchChannelEmotes(
    String accessToken,
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> getTwitchSetsEmotes(
    String accessToken,
    List<String> setId,
  );

  Future<DataState<List<Emote>>> getTwitchCheerEmotes(
    String accessToken,
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> getFrankerfacezEmotes(
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> getBttvChannelEmotes(
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> getBttvGlobalEmotes();
}
