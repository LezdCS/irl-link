import 'package:dio/dio.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:twitch_chat/twitch_chat.dart';

class HomeEvents {
  final TwitchUseCase twitchUseCase;
  final SettingsUseCase settingsUseCase;
  final StreamelementsUseCase streamelementsUseCase;

  HomeEvents({required this.twitchUseCase, required this.settingsUseCase, required this.streamelementsUseCase});

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

  Future<DataState<SeCredentials>> getSeCredentialsFromLocal() {
    return streamelementsUseCase.getSeCredentialsFromLocal();
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

  Future<void>? createPoll(
      String accessToken, String broadcasterId, TwitchPoll newPoll) {
    return twitchUseCase.createPoll(accessToken, broadcasterId, newPoll);
  }

  Future<DataState<TwitchPoll>> endPoll(
      String accessToken, String broadcasterId, String pollId, String status) {
    return twitchUseCase.endPoll(accessToken, broadcasterId, pollId, status);
  }

  Future endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  ) {
    return twitchUseCase.endPrediction(
        accessToken, broadcasterId, predictionId, status, winningOutcomeId);
  }

  Future<void> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  ) {
    return twitchUseCase.banUser(accessToken, broadcasterId, message, duration);
  }

  Future<void> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  ) {
    return twitchUseCase.deleteMessage(accessToken, broadcasterId, message);
  }
}
