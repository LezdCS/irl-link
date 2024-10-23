
import 'package:kick_chat/kick_chat.dart';

class PinnedMessage {
  final String id;
  final String messageId;
  final String authorId;
  final String displayName;
  final String color;
  final String message;
  final int timestamp;

  PinnedMessage({
    required this.id,
    required this.message,
    required this.messageId,
    required this.authorId,
    required this.displayName,
    required this.color,
    required this.timestamp,
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
    );
  }

  factory PinnedMessage.fromKick(KickPinnedMessageCreated kickPinnedMessageCreated) {
    return PinnedMessage(
      id: kickPinnedMessageCreated.channel,
      messageId: kickPinnedMessageCreated.data.message.id,
      authorId: kickPinnedMessageCreated.data.message.sender.id.toString(),
      displayName: kickPinnedMessageCreated.data.message.sender.username,
      color: kickPinnedMessageCreated.data.message.sender.identity.color,
      message: kickPinnedMessageCreated.data.message.content,
      timestamp: DateTime.now().toUtc().millisecondsSinceEpoch,
    );
  }
}