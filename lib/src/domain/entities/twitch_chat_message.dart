import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:collection/collection.dart';

class TwitchChatMessage extends Equatable {
  final String messageId;
  final List<TwitchBadge> badges;
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

  factory TwitchChatMessage.fromString(
    List<TwitchBadge> twitchBadges,
    String message,
  ) {
    final Map<String, String> messageMapped = {};

    List messageSplited = message.split(';');
    messageSplited.forEach((element) {
      List elementSplited = element.split('=');
      messageMapped[elementSplited[0]] = elementSplited[1];
    });

    List<TwitchBadge> badges = <TwitchBadge>[];
    List badgesSplited = messageMapped['badges'].toString().split(',');
    if (badgesSplited.isNotEmpty) {
      badgesSplited.forEach((i) {
        TwitchBadge? badgeFound = twitchBadges.firstWhereOrNull((badge) =>
            badge.setId == i.split('/')[0] &&
            badge.versionId == i.split('/')[1]);
        if (badgeFound != null) {
          badges.add(badgeFound);
        }
      });
    }

    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    return TwitchChatMessage(
      messageId: messageMapped['id'] as String,
      badges: badges,
      color: messageMapped['color'] as String,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: messageMapped['emotes'] as String,
      thirdPartiesEmotes: '',
      message: messageString,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      deleted: false,
    );
  }
}
