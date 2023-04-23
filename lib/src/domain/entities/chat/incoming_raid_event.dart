import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../emote.dart';
import '../settings.dart';
import '../twitch_badge.dart';

class IncomingRaidEvent extends TwitchChatMessage {
  final int viewerCount;
  final String raidingChannelName;

  IncomingRaidEvent({
    required messageId,
    required badges,
    required color,
    required authorName,
    required authorId,
    required emotes,
    required message,
    required messageWidgetsBuild,
    required timestamp,
    required highlightType,
    required isAction,
    required isDeleted,
    required this.viewerCount,
    required this.raidingChannelName,
  }) : super(
    messageId: messageId,
    badges: badges,
    color: color,
    authorName: authorName,
    authorId: authorId,
    emotes: emotes,
    message: message,
    messageWidgetsBuild: messageWidgetsBuild,
    timestamp: timestamp,
    highlightType: highlightType,
    isAction: isAction,
    isDeleted: isDeleted,
  );

  factory IncomingRaidEvent.fromString({
    required List<TwitchBadge> twitchBadges,
    required List<Emote> cheerEmotes,
    required List<Emote> thirdPartEmotes,
    required String message,
    required Settings settings,
  }) {
    final Map<String, String> messageMapped = {};

    List messageSplited = message.split(';');
    messageSplited.forEach((element) {
      List elementSplited = element.split('=');
      messageMapped[elementSplited[0]] = elementSplited[1];
    });

    return IncomingRaidEvent(
      messageId: messageMapped['id'] as String,
      badges: <TwitchBadge>[],
      color: "",
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: <String, List<dynamic>>{},
      message: "",
      messageWidgetsBuild: <Widget>[],
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      highlightType: HighlightType.incomingRaid,
      isAction: false,
      isDeleted: false,
      viewerCount: int.parse(messageMapped['msg-param-viewerCount'] as String),
      raidingChannelName: messageMapped['msg-param-displayName'] as String,
    );
  }

  factory IncomingRaidEvent.randomGeneration() {
    return IncomingRaidEvent(
      messageId: '123456789',
      badges: <TwitchBadge>[],
      color: TwitchChatMessage.randomUsernameColor('Lezd'),
      authorName: 'Lezd',
      authorId: '123456789',
      emotes: <String, List<dynamic>>{},
      message: '',
      messageWidgetsBuild: <Widget>[],
      timestamp: 123456789,
      highlightType: HighlightType.incomingRaid,
      isAction: false,
      isDeleted: false,
      viewerCount: 123,
      raidingChannelName: 'Lezd_',
    );
  }
}
