import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';

import '../../controllers/chat_view_controller.dart';

class MessageContainer extends StatelessWidget {
  final ChatViewController controller;
  final TwitchChatMessage message;
  final Widget child;

  const MessageContainer({
    required this.controller,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
        decoration: BoxDecoration(
          color: controller.selectedMessage.value == message
              ? Theme.of(Get.context!).colorScheme.secondary
              : Theme.of(Get.context!).colorScheme.background,
        ),
        child: child,
      ),
    );
  }
}
