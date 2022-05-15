import 'package:dio/dio.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';

class HomeEvents {
  final TwitchUseCase twitchUseCase;
  final SettingsUseCase settingsUseCase;
  HomeEvents({required this.twitchUseCase, required this.settingsUseCase});

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

  Future<DataState<TwitchCredentials>> refreshAccessToken({
  required TwitchCredentials twitchData,
}) {
    return twitchUseCase.refreshAccessToken(twitchData: twitchData);
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

  Future<DataState<List<Emote>>> get7TvChannelEmotes({
    required String broadcasterId,
  }) {
    return twitchUseCase.get7TvChannelEmotes(broadcasterId: broadcasterId);
  }

  Future<DataState<List<Emote>>> get7TvGlobalEmotes() {
    return twitchUseCase.get7TvGlobalEmotes();
  }

  Future<DataState<List<Emote>>> getBttvGlobalEmotes() {
    return twitchUseCase.getBttvGlobalEmotes();
  }

  Future<DataState<TwitchStreamInfos>> getStreamInfo(
      String accessToken, String broadcasterId) {
    return twitchUseCase.getStreamInfo(accessToken, broadcasterId);
  }

  Future<DataState<Response<dynamic>>> setChatSettings(String accessToken,
      String broadcasterId, TwitchStreamInfos? twitchStreamInfos) {
    return twitchUseCase.setChatSettings(
        accessToken, broadcasterId, twitchStreamInfos);
  }

  Future<DataState<void>> setStreamTitle(
      String accessToken, String broadcasterId, String title) {
    return twitchUseCase.setStreamTitle(accessToken, broadcasterId, title);
  }

  Future<DataState<Settings>> getSettings() {
    return settingsUseCase.getSettings();
  }

  Future<void> setSettings({required Settings settings}) {
    return settingsUseCase.setSettings(settings: settings);
  }
}
