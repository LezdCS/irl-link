import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';

part 'se_activity_dto.freezed.dart';

@freezed
abstract class SeActivityDTO with _$SeActivityDTO {
  const factory SeActivityDTO({
    required String id,
    required String channel,
    required String username,
    required ActivityType activityType,
    required StreamProvider provider,
    String? message,
    String? amount,
    String? tier,
    bool? gifted,
    String? sender,
    String? currency,
    bool? isTest,
  }) = _SeActivityDTO;

  factory SeActivityDTO.fromJson(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'follow':
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          activityType: ActivityType.follow,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      case "subscriber":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          message: map["data"]["message"],
          amount: map["data"]["amount"].toString(),
          tier: map["data"]["tier"],
          gifted: map["data"]["gifted"],
          sender: map["data"]["sender"],
          activityType: ActivityType.subscription,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      case "tip":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          currency: map["data"]["currency"],
          activityType: ActivityType.tip,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      case "cheer":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          message: map["data"]["message"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.cheer,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      case "host":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.host,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      case "raid":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.raid,
          provider: SeActivity.providerFromString(map["provider"]),
        );
      default:
        return const SeActivityDTO(
          id: "-1",
          channel: "",
          username: '',
          activityType: ActivityType.unsupported,
          isTest: true,
          provider: StreamProvider.twitch,
        );
    }
  }
}
