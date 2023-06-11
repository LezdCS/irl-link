import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_chat/twitch_chat.dart';

import 'message_row.dart';

class MessageContainer extends StatelessWidget {
  final ChatMessage? selectedMessage;
  final ChatMessage message;
  final bool displayTimestamp;
  final double textSize;
  final TwitchChat twitchChat;

  const MessageContainer({
    super.key,
    required this.selectedMessage,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
    required this.twitchChat,
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
        twitchChat: twitchChat,
      ),
    );
  }
}
