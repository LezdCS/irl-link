import 'package:flutter/cupertino.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../emote.dart';
import '../settings.dart';
import '../twitch_badge.dart';

class AnnouncementEvent extends TwitchChatMessage {
  final String announcementColor;

  AnnouncementEvent({
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
    required this.announcementColor,
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

  factory AnnouncementEvent.fromString({
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

    String color =
        TwitchChatMessage.randomUsernameColor(messageMapped['display-name']!);

    Map<String, List<List<String>>> emotesIdsPositions =
        TwitchChatMessage.parseEmotes(messageMapped);

    List messageList = messageSplited.last.split(':').sublist(2);
    String messageString = messageList.join(':');

    List<Widget> messageInWidgets = TwitchChatMessage.messageToWidgets(
      messageString: messageString,
      emotesIdsPositions: emotesIdsPositions,
      thirdPartEmotes: thirdPartEmotes,
      settings: settings,
      highlightType: HighlightType.announcement,
      cheerEmotes: cheerEmotes,
      isAction: false,
      color: color,
    );

    return AnnouncementEvent(
      messageId: messageMapped['id'] as String,
      badges: TwitchChatMessage.getBadges(
          messageMapped['badges'].toString(), twitchBadges),
      color: color,
      authorName: messageMapped['display-name'] as String,
      authorId: messageMapped['user-id'] as String,
      emotes: emotesIdsPositions,
      message: messageString,
      messageWidgetsBuild: messageInWidgets,
      timestamp: int.parse(messageMapped['tmi-sent-ts'] as String),
      highlightType: HighlightType.announcement,
      bitAmount: 0,
      isAction: false,
      isDeleted: false,
      announcementColor: messageMapped["msg-param-color"] as String,
    );
  }

  factory AnnouncementEvent.randomGeneration() {
    String message = "This is an important announcement!";
    List<Widget> messageInWidgets = TwitchChatMessage.messageToWidgets(
      messageString: message,
      emotesIdsPositions: <String, List<List<String>>>{},
      thirdPartEmotes: <Emote>[],
      settings: Settings.defaultSettings(),
      highlightType: HighlightType.announcement,
      cheerEmotes: <Emote>[],
      isAction: false,
      color: '#000000',
    );
    List badges = <TwitchBadge>[
      TwitchBadge(
        setId: 'sub-gifter',
        versionId: '1',
        imageUrl1x: 'https://static-cdn.jtvnw.net/badges/v1/a5ef6c17-2e5b-4d8f-9b80-2779fd722414/1',
        imageUrl2x: 'https://static-cdn.jtvnw.net/badges/v1/a5ef6c17-2e5b-4d8f-9b80-2779fd722414/2',
        imageUrl4x: 'https://static-cdn.jtvnw.net/badges/v1/a5ef6c17-2e5b-4d8f-9b80-2779fd722414/3',
      ),
    ];
    return AnnouncementEvent(
      messageId: '123456789',
      badges: badges,
      color: TwitchChatMessage.randomUsernameColor('Lezd'),
      authorName: 'Lezd',
      authorId: '123456789',
      emotes: <String, List<dynamic>>{},
      message: message,
      messageWidgetsBuild: messageInWidgets,
      timestamp: 123456789,
      highlightType: HighlightType.announcement,
      bitAmount: 0,
      isAction: false,
      isDeleted: false,
      announcementColor: '#000000',
    );
  }
}
