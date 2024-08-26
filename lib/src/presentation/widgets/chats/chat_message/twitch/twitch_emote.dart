import 'package:flutter/material.dart';

class TwitchEmote extends StatelessWidget {
  final MapEntry emote;
  final double height;

  const TwitchEmote({
    super.key,
    required this.emote,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      image: NetworkImage(
          "https://static-cdn.jtvnw.net/emoticons/v2/${emote.key}/default/dark/1.0"),
    );
  }
}
