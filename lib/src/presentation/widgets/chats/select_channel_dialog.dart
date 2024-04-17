import 'package:flutter/material.dart';
import 'package:twitch_chat/twitch_chat.dart';

class SelectChannelDialog extends StatelessWidget {
  const SelectChannelDialog({
    super.key,
    required this.twitchChats,
  });

  final List<TwitchChat> twitchChats;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: twitchChats.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) {
          TwitchChat chat = twitchChats[i];
          return Text(chat.channel);
        },
      ),
    );
  }
}
