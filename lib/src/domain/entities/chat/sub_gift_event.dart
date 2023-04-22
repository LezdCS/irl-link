import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../emote.dart';
import '../settings.dart';
import '../twitch_badge.dart';

class SubGiftEvent extends TwitchChatMessage {
  final String giftedName;
  final String tier;
  final String systemMessage;

  SubGiftEvent({
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
    required this.giftedName,
    required this.systemMessage,
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

  factory SubGiftEvent.fromString({
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

    String color = TwitchChatMessage.randomUsernameColor(messageMapped['display-name']!);

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

    return SubGiftEvent(
      messageId: messageMapped['id'] as String,
      badges: TwitchChatMessage.getBadges(messageMapped['badges'].toString(), twitchBadges),
      color: color,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      messageWidgetsBuild: messageInWidgets,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      highlightType: HighlightType.subscriptionGifted,
      bitAmount: 0,
      isAction: false,
      isDeleted: false,
      tier: messageMapped["msg-param-sub-plan"] as String,
      giftedName: messageMapped["msg-param-recipient-display-name"] as String,
      systemMessage: messageMapped["system-msg"] as String,
    );
  }
}
