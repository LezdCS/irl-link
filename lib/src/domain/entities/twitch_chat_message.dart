import 'package:equatable/equatable.dart';

class TwitchChatMessage extends Equatable {
  final String messageId;
  final String badges;
  final String color;
  final String authorName;
  final String authorId;
  final String emotes;
  final String thirdPartiesEmotes;
  final String message;
  final int timestamp;
  final bool deleted;

  const TwitchChatMessage({
    required this.messageId,
    required this.badges,
    required this.color,
    required this.authorName,
    required this.authorId,
    required this.emotes,
    required this.thirdPartiesEmotes,
    required this.message,
    required this.timestamp,
    required this.deleted,
  });

  @override
  List<Object?> get props {
    return [
      messageId,
      badges,
      color,
      authorName,
      authorId,
      emotes,
      thirdPartiesEmotes,
      message,
      timestamp,
      deleted,
    ];
  }

  @override
  bool get stringify => true;
}
