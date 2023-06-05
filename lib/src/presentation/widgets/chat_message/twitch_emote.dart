import 'package:flutter/material.dart';

class TwitchEmote extends StatelessWidget {
  final MapEntry emote;

  const TwitchEmote({required this.emote});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(
          "https://static-cdn.jtvnw.net/emoticons/v2/${emote.key}/default/dark/1.0"),
    );
  }
}
