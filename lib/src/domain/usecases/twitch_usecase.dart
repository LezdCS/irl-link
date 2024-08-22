import 'package:dio/dio.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:twitch_chat/twitch_chat.dart';

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

  Future<DataState<TwitchPoll>> createPoll(
      String accessToken, String broadcasterId, TwitchPoll newPoll) {
    return twitchRepository.createPoll(accessToken, broadcasterId, newPoll);
  }

  Future<DataState<TwitchPoll>> endPoll(
      String accessToken, String broadcasterId, String pollId, String status) {
    return twitchRepository.endPoll(accessToken, broadcasterId, pollId, status);
  }

  Future endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  ) {
    return twitchRepository.endPrediction(
        accessToken, broadcasterId, predictionId, status, winningOutcomeId);
  }

  Future<void> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  ) {
    return twitchRepository.banUser(
        accessToken, broadcasterId, message, duration);
  }

  Future<void> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  ) {
    return twitchRepository.deleteMessage(accessToken, broadcasterId, message);
  }
}
