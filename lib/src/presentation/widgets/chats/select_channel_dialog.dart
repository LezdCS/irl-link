import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:twitch_chat/twitch_chat.dart';

class SelectChannelDialog extends StatelessWidget {
  const SelectChannelDialog({
    super.key,
    required this.twitchChats,
    required this.kickChats,
    required this.controller,
    required this.message,
  });

  final List<TwitchChat> twitchChats;
  final List<KickChat> kickChats;
  final HomeViewController controller;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: ListView.separated(
        itemCount: twitchChats.length + kickChats.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) {
          if (i < twitchChats.length) {
            // Twitch channel
            TwitchChat chat = twitchChats[i];
            return Material(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.sendTwitchMessageToChat(chat.channel, message);
                  controller.chatInputController.text = '';
                  FocusScope.of(context).unfocus();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(Icons.live_tv, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(chat.channel),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Kick channel
            KickChat chat = kickChats[i - twitchChats.length];
            return Material(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  debugPrint('sendKickMessageToChat');
                  debugPrint(chat.username);
                  debugPrint(message);
                  controller.sendKickMessageToChat(chat.username, message);
                  controller.chatInputController.text = '';
                  FocusScope.of(context).unfocus();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(Icons.sports_esports, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(chat.username),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
