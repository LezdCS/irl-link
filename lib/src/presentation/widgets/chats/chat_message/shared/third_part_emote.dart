import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';

class ThirdPartEmote extends StatelessWidget {
  final ChatEmote emote;

  const ThirdPartEmote({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(emote.url1x),
    );
  }
}
