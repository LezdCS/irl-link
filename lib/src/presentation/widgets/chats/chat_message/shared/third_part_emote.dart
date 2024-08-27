import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';

class ThirdPartEmote extends StatelessWidget {
  final ChatEmote emote;
  final double height;

  const ThirdPartEmote({
    super.key,
    required this.emote,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      image: NetworkImage(emote.url1x),
    );
  }
}
