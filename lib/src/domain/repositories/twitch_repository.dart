import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';
import 'package:twitch_chat/twitch_chat.dart';

abstract class TwitchRepository {
  Future<Either<Failure, TwitchCredentials>> getTwitchOauth(
    TwitchAuthParams params,
  );

  Future<Either<Failure, TwitchCredentials>> refreshAccessToken(
    TwitchCredentials twitchData,
  );

  Future<Either<Failure, TwitchCredentials>> getTwitchFromLocal();

  Future<Either<Failure, void>> logout(
    String accessToken,
  );

  Future<Either<Failure, List<TwitchUser>>> getTwitchUsers(
    List ids,
    String accessToken,
  );

  Future<Either<Failure, TwitchUser>> getTwitchUser(
    String? username,
    String accessToken,
  );

  Future<Either<Failure, TwitchStreamInfos>> getStreamInfo(
    String accessToken,
    String broadcasterId,
  );

  Future<Either<Failure, void>> setChatSettings(
    String accessToken,
    String broadcasterId,
    TwitchStreamInfos? twitchStreamInfos,
  );

  Future<Either<Failure, void>> setStreamTitle(
    String accessToken,
    String broadcasterId,
    String title,
  );

  Future<Either<Failure, TwitchPoll>> createPoll(
    String accessToken,
    String broadcasterId,
    TwitchPoll newPoll,
  );

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  Future<Either<Failure, TwitchPoll>> endPoll(
    String accessToken,
    String broadcasterId,
    String pollId,
    String status,
  );

  Future<Either<Failure, void>> endPrediction(
    String accessToken,
    String broadcasterId,
    String predictionId,
    String status,
    String? winningOutcomeId,
  );

  Future<Either<Failure, void>> banUser(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
    int? duration,
  );

  Future<Either<Failure, void>> deleteMessage(
    String accessToken,
    String broadcasterId,
    ChatMessage message,
  );
}
