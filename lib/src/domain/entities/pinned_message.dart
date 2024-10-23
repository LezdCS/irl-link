
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:kick_chat/kick_chat.dart';

class PinnedMessage {
  final String id;
  final String messageId;
  final String authorId;
  final String displayName;
  final String color;
  final String message;
  final int timestamp;
  final Platform platform;

  PinnedMessage({
    required this.id,
    required this.message,
    required this.messageId,
    required this.authorId,
    required this.displayName,
    required this.color,
    required this.timestamp,
    required this.platform,
  });

  factory PinnedMessage.fromTwitch(Map<String, dynamic> json) {
    return PinnedMessage(
      id: json['data']['id'],
      messageId: json['data']['message']['id'],
      authorId: json['data']['message']['sender']['id'],
      displayName: json['data']['message']['sender']['display_name'],
      color: json['data']['message']['sender']['chat_color'],
      message: json['data']['message']['content']['text'],
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      platform: Platform.twitch,
    );
  }

  factory PinnedMessage.fromKick(KickPinnedMessageCreated messsage) {
    return PinnedMessage(
      id: messsage.channel,
      messageId: messsage.data.message.id,
      authorId: messsage.data.message.sender.id.toString(),
      displayName: messsage.data.message.sender.username,
      color: messsage.data.message.sender.identity.color,
      message: messsage.data.message.content,
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
      platform: Platform.kick,
    );
  }
}