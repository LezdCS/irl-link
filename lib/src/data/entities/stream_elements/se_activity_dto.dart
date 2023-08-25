import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';

class SeActivityDTO extends SeActivity {
  const SeActivityDTO({
    required String id,
    required String channel,
    required String username,
    required ActivityType activityType,
    String? message,
    String? amount,
    String? tier,
    bool? gifted,
    String? sender,
    String? currency,
    bool? isTest,
  }) : super(
          id: id,
          channel: channel,
          username: username,
          activityType: activityType,
          message: message,
          amount: amount,
          tier: tier,
          gifted: gifted,
          sender: sender,
          currency: currency,
          isTest: isTest,
        );

  factory SeActivityDTO.fromJson(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'follow':
        return SeActivityDTO (
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          activityType: ActivityType.follow,
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
        );
      case "tip":
       return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          currency: map["data"]["currency"],
          activityType: ActivityType.tip,
        );
      case "cheer":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          message: map["data"]["message"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.cheer,
        );
      case "host":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.host,
        );
      case "raid":
        return SeActivityDTO(
          id: map["_id"],
          channel: map["channel"],
          username: map["data"]["displayName"],
          amount: map["data"]["amount"].toString(),
          activityType: ActivityType.raid,
        );
      default:
        return const SeActivityDTO(
          id: "-1",
          channel: "",
          username: '',
          activityType: ActivityType.unsupported,
          isTest: true,
        );
    }
  }
}
