import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_badge.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/kick/kick_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/badges.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/third_part_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/word.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/cheer_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/twitch_emote.dart';
import 'package:twitch_chat/twitch_chat.dart';

class MessageRow extends StatelessWidget {
  final entity.ChatMessage message;
  final bool displayTimestamp;
  final double textSize;
  final bool hideDeletedMessages;
  final List<ChatEmote> cheerEmotes;
  final List<ChatEmote> thirdPartEmotes;
  final bool showPlatformBadge;

  const MessageRow({
    super.key,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
    required this.hideDeletedMessages,
    required this.cheerEmotes,
    required this.thirdPartEmotes,
    required this.showPlatformBadge,
  });

  @override
  Widget build(BuildContext context) {
    List<ChatBadge> badges = [];
    badges.addAll(message.badgesList);
    if (showPlatformBadge) {
      String badge = '';
      switch (message.platform) {
        case Platform.twitch:
          badge = "lib/assets/twitch/twitch_logo.png";
          break;
        case Platform.kick:
          badge = "lib/assets/kick/kickLogo.png";
          break;
        case Platform.youtube:
          badge = "lib/assets/youtube/youtubeLogo.png";
          break;
      }
      ChatBadge platformBadge = ChatBadge(
        imageUrl1x: badge,
        imageUrl2x: badge,
        imageUrl4x: badge,
        id: '',
      );
      badges.insert(0, platformBadge);
    }

    return Opacity(
      opacity: message.isDeleted && !hideDeletedMessages ? 0.5 : 1,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Visibility(
            visible: displayTimestamp,
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              child: Timestamp(
                timestamp: message.timestamp,
              ),
            ),
          ),
          Badges(
            badges: message.badgesList,
            textSize: textSize,
          ),
          AuthorName(
            isAction: message.isAction,
            username: message.username,
            displayName: message.displayName,
            color: message.color,
            textSize: textSize,
            platform: message.platform,
          ),
          if (message.isDeleted && hideDeletedMessages)
            Text(
              "message_deleted".tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: textSize,
              ),
            )
          else
            for (Widget i in messageContent(
              message,
              null,
              textSize,
              cheerEmotes,
              thirdPartEmotes,
            ))
              i,
        ],
      ),
    );
  }

  List<Widget> messageContent(
    final entity.ChatMessage message,
    final TwitchChatParameters? params,
    final double textSize,
    final List<ChatEmote> cheerEmotes,
    final List<ChatEmote> thirdPartEmotes,
  ) {
    List<Widget> messageWidgetsBuild = [];

    for (int i = 0; i < message.message.trim().split(' ').length; i++) {
      String word = message.message.trim().split(' ')[i];

      MapEntry? emote = message.emotes.entries.firstWhereOrNull((element) =>
          element
              .value
              .where((position) =>
                  message.message.substring(
                      int.parse(position[0]), int.parse(position[1]) + 1) ==
                  word)
              .isNotEmpty);

      // [emote:37227:LULW]
      List<String> kickEmotesIds = [];
      if (word.startsWith('[') &&
          word.endsWith(']') &&
          message.platform == Platform.kick) {
        if ('['.allMatches(word).length > 1) {
          int numberOfLeft = '['.allMatches(word).length;
          int numberOfRight = ']'.allMatches(word).length;
          if (numberOfLeft == numberOfRight) {
            // it might means we are in a scenario where there is no spacing between the emotes
            // [emote:37227:LULW][emote:37227:LULW][emote:37227:LULW]
            List<String> emotesSplit = word.split(']');
            kickEmotesIds = [];
            for (String e in emotesSplit) {
              if (':'.allMatches(e).length == 2) {
                kickEmotesIds.add(word.split(':')[1]);
              }
            }
          }
        } else {
          if (':'.allMatches(word).length == 2) {
            kickEmotesIds.add(word.split(':')[1]);
          }
        }
      }

      ChatEmote? thirdPartyEmote =
          thirdPartEmotes.firstWhereOrNull((element) => element.name == word);

      if (emote != null) {
        messageWidgetsBuild.add(
          Wrap(
            children: [
              TwitchEmote(
                height: textSize,
                emote: emote,
              ),
              const Text(' '),
            ],
          ),
        );
      } else if (thirdPartyEmote != null) {
        messageWidgetsBuild.add(
          Wrap(
            children: [
              ThirdPartEmote(
                emote: thirdPartyEmote,
                height: textSize,
              ),
              const Text(' '),
            ],
          ),
        );
      } else if (kickEmotesIds.isNotEmpty) {
        messageWidgetsBuild.add(
          Wrap(
            children: List.generate(
              kickEmotesIds.length,
              (index) => KickEmote(
                emoteId: kickEmotesIds[index],
                height: textSize,
              ),
            ),
          ),
        );
      } else if (message.eventType == EventType.bitDonation &&
          cheerEmotes.firstWhereOrNull((emote) => emote.name == word) != null) {
        messageWidgetsBuild.add(
          CheerEmote(
            cheerEmote:
                cheerEmotes.firstWhereOrNull((emote) => emote.name == word)!,
            textSize: textSize,
          ),
        );
      } else {
        messageWidgetsBuild.add(
          Word(
            word: word,
            isAction: message.isAction,
            color: message.color,
            textSize: textSize,
          ),
        );
      }
    }

    return messageWidgetsBuild;
  }
}
