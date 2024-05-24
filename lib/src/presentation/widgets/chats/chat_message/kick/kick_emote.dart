import 'package:flutter/material.dart';

class KickEmote extends StatelessWidget {
  final String emoteId;

  const KickEmote({super.key, required this.emoteId});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: 24,
      width: 24,
      image: NetworkImage("https://files.kick.com/emotes/$emoteId/fullsize"),
    );
  }
}
