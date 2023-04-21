import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../emote.dart';
import '../settings.dart';
import '../twitch_badge.dart';

class Sub extends TwitchChatMessage {
  final String months;
  final String tier;
  final bool isGift;

  Sub({
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
    required bitAmount,
    required isAction,
    required isDeleted,
    required this.tier,
    required this.months,
    required this.isGift,
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
          bitAmount: bitAmount,
          isAction: isAction,
          isDeleted: isDeleted,
        );

  factory Sub.fromString({
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

    String color = messageMapped['color']!;
    if (color == "") {
      color = TwitchChatMessage.randomUsernameColor(messageMapped['display-name']!);
    }

    Map<String, List<List<String>>> emotesIdsPositions =
    TwitchChatMessage.parseEmotes(messageMapped);

    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    List<Widget> messageInWidgets = TwitchChatMessage.messageToWidgets(
      messageString: messageString,
      emotesIdsPositions: emotesIdsPositions,
      thirdPartEmotes: thirdPartEmotes,
      settings: settings,
      highlightType: HighlightType.subscription,
      cheerEmotes: cheerEmotes,
      isAction: false,
      color: color,
    );

    return Sub(
      messageId: messageMapped['id'] as String,
      badges: TwitchChatMessage.getBadges(messageMapped['badges'].toString(), twitchBadges),
      color: color,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      messageWidgetsBuild: messageInWidgets,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      highlightType: HighlightType.subscription,
      bitAmount: 0,
      isAction: false,
      isDeleted: false,
      tier: messageMapped["msg-param-sub-plan"] as String,
      months: messageMapped["msg-param-cumulative-months"] as String,
      isGift: messageMapped["msg-param-was-gifted"] == "true",
    );
  }
}
