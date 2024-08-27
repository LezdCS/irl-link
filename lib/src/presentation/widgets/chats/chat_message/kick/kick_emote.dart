import 'package:flutter/material.dart';

class KickEmote extends StatelessWidget {
  final String emoteId;
  final double height;

  const KickEmote({
    super.key,
    required this.emoteId,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: height,
      image: NetworkImage("https://files.kick.com/emotes/$emoteId/fullsize"),
    );
  }
}
