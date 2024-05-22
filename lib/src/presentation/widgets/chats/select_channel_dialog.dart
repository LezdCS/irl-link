import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:twitch_chat/twitch_chat.dart';

class SelectChannelDialog extends StatelessWidget {
  const SelectChannelDialog({
    super.key,
    required this.twitchChats,
    required this.controller,
    required this.message,
  });

  final List<TwitchChat> twitchChats;
  final HomeViewController controller;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ListView.separated(
        itemCount: twitchChats.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) {
          TwitchChat chat = twitchChats[i];
          return InkWell(
            onTap: () => {
              controller.sendChatMessage(message, chat.channel),
              controller.chatInputController.text = '',
              FocusScope.of(context).unfocus(),
              Get.back(),
            },
            child: Text(chat.channel),
          );
        },
      ),
    );
  }
}
