import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import 'message_row.dart';

class MessageContainer extends StatelessWidget {
  final TwitchChatMessage? selectedMessage;
  final TwitchChatMessage message;
  final bool displayTimestamp;
  final double textSize;

  const MessageContainer({
    required this.selectedMessage,
    required this.message,
    required this.displayTimestamp,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
        decoration: BoxDecoration(
          color: selectedMessage != null && selectedMessage == message
              ? Theme.of(Get.context!).colorScheme.secondary
              : Theme.of(Get.context!).colorScheme.background,
        ),
        child: MessageRow(
          message: message,
          displayTimestamp: displayTimestamp,
          textSize: textSize,
        ),
    );
  }
}
