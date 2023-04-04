import 'package:dio/dio.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_prediction.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';

import '../entities/twitch_poll.dart';

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

  Future<DataState<String>> logout(
    String accessToken,
  );

  Future<DataState<List<TwitchUser>>> getTwitchUsers(
    List ids,
    String accessToken,
  );

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

  Future<DataState<List<Emote>>> get7TvChannelEmotes(
    String broadcasterId,
  );

  Future<DataState<List<Emote>>> get7TvGlobalEmotes();

  Future<DataState<List<Emote>>> getBttvGlobalEmotes();

  Future<DataState<TwitchStreamInfos>> getStreamInfo(
      String accessToken, String broadcasterId);

  Future<DataState<Response<dynamic>>> setChatSettings(String accessToken,
      String broadcasterId, TwitchStreamInfos? twitchStreamInfos);

  Future<DataState<void>> setStreamTitle(
      String accessToken, String broadcasterId, String title);

  Future<DataState<TwitchPoll>> getPoll(
      String accessToken, String broadcasterId);

  Future<DataState<TwitchPoll>> createPoll(
      String accessToken, String broadcasterId, TwitchPoll newPoll);

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  Future<DataState<TwitchPoll>> endPoll(
      String accessToken, String broadcasterId, String pollId, String status);

  Future<DataState<TwitchPrediction>> getPrediction(
      String accessToken, String broadcasterId);
}
