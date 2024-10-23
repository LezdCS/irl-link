
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
}