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
      height: 100,
      child: ListView.separated(
        itemCount: twitchChats.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) {
          TwitchChat chat = twitchChats[i];
          return Material(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => {
                controller.sendChatMessage(message, chat.channel),
                controller.chatInputController.text = '',
                FocusScope.of(context).unfocus(),
                Get.back(),
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(chat.channel),
              ),
            ),
          );
        },
      ),
    );
  }
}
