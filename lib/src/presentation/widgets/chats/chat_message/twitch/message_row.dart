import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/third_part_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/timestamp.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/author_name.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/twitch_emote.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/word.dart';
import 'package:twitch_chat/twitch_chat.dart';

import 'cheer_emote.dart';

class MessageRow extends StatelessWidget {
  final ChatMessage message;
  final bool displayTimestamp;
  final double textSize;
  final TwitchChat? twitchChat;
  final bool hideDeletedMessages;

  const MessageRow({
    super.key,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
    this.twitchChat,
    required this.hideDeletedMessages,
  });

  @override
  Widget build(BuildContext context) {
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
          for (TwitchBadge badge in message.badges)
            Container(
              padding: const EdgeInsets.only(right: 4, top: 3),
              child: Image(
                image: NetworkImage(badge.imageUrl1x),
                filterQuality: FilterQuality.high,
              ),
            ),
          AuthorName(
            isAction: message.isAction,
            username: message.username,
            displayName: message.displayName,
            color: message.color,
            textSize: textSize,
          ),
          if (message.isDeleted && hideDeletedMessages)
            Text(
              "<message deleted>",
              style: TextStyle(
                color: Colors.grey,
                fontSize: textSize,
              ),
            )
          else
            for (Widget i in messageContent(
              twitchChat?.cheerEmotes ?? List.empty(),
              twitchChat?.thirdPartEmotes ?? List.empty(),
              message,
              null,
              textSize,
            ))
              i,
        ],
      ),
    );
  }

  List<Widget> messageContent(
    final List<Emote> cheerEmotes,
    final List<Emote> thirdPartEmotes,
    final ChatMessage message,
    final TwitchChatParameters? params,
    final double textSize,
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

      Emote? thirdPartyEmote =
          thirdPartEmotes.firstWhereOrNull((element) => element.name == word);

      if (emote != null) {
        messageWidgetsBuild.add(
          Wrap(
            children: [
              TwitchEmote(
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
              ),
              const Text(' '),
            ],
          ),
        );
      } else if (message.highlightType == HighlightType.bitDonation &&
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
