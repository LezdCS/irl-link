import 'package:dio/dio.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
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

  Future<DataState<TwitchCredentials>> refreshAccessToken({
    required TwitchCredentials twitchData,
  }) {
    return twitchRepository.refreshAccessToken(twitchData);
  }

  Future<DataState<List<TwitchUser>>> getTwitchUsers({
    required List ids,
    required String accessToken,
  }) {
    return twitchRepository.getTwitchUsers(ids, accessToken);
  }

  Future<DataState<String>> logout({required String accessToken}) {
    return twitchRepository.logout(accessToken);
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

  Future<DataState<List<Emote>>> getFrankerfacezEmotes({
    required String broadcasterId,
  }) {
    return twitchRepository.getFrankerfacezEmotes(broadcasterId);
  }

  Future<DataState<List<Emote>>> getBttvChannelEmotes({
    required String broadcasterId,
  }) {
    return twitchRepository.getBttvChannelEmotes(broadcasterId);
  }

  Future<DataState<List<Emote>>> get7TvChannelEmotes({
    required String broadcasterId,
  }) {
    return twitchRepository.get7TvChannelEmotes(broadcasterId);
  }

  Future<DataState<List<Emote>>> get7TvGlobalEmotes() {
    return twitchRepository.get7TvGlobalEmotes();
  }

  Future<DataState<List<Emote>>> getBttvGlobalEmotes() {
    return twitchRepository.getBttvGlobalEmotes();
  }

  Future<DataState<TwitchStreamInfos>> getStreamInfo(
      String accessToken, String broadcasterId) {
    return twitchRepository.getStreamInfo(accessToken, broadcasterId);
  }

  Future<DataState<Response<dynamic>>> setChatSettings(String accessToken,
      String broadcasterId, TwitchStreamInfos? twitchStreamInfos) {
    return twitchRepository.setChatSettings(
        accessToken, broadcasterId, twitchStreamInfos);
  }

  Future<DataState<void>> setStreamTitle(
      String accessToken, String broadcasterId, String title) {
    return twitchRepository.setStreamTitle(accessToken, broadcasterId, title);
  }
}
