import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;

import 'message_row.dart';

class MessageContainer extends StatelessWidget {
  final entity.ChatMessage? selectedMessage;
  final entity.ChatMessage message;
  final bool displayTimestamp;
  final double textSize;
  final TwitchChat twitchChat;
  final bool hideDeletedMessages;
  final List<ChatEmote> cheerEmotes;
  final List<ChatEmote> thirdPartEmotes;
  final bool showPlatformBadge;

  const MessageContainer({
    super.key,
    required this.selectedMessage,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
    required this.twitchChat,
    required this.hideDeletedMessages,
    required this.cheerEmotes,
    required this.thirdPartEmotes,
    required this.showPlatformBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5),
      decoration: BoxDecoration(
        color: selectedMessage != null && selectedMessage == message
            ? Theme.of(Get.context!).colorScheme.secondary
            : Theme.of(Get.context!).colorScheme.background,
      ),
      child: MessageRow(
        message: message,
        displayTimestamp: displayTimestamp,
        textSize: textSize,
        hideDeletedMessages: hideDeletedMessages,
        cheerEmotes: cheerEmotes,
        thirdPartEmotes: thirdPartEmotes,
        showPlatformBadge: showPlatformBadge,
      ),
    );
  }
}
