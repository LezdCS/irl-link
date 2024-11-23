import 'package:cached_network_image/cached_network_image.dart';
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
    return CachedNetworkImage(
      imageUrl:
          "https://static-cdn.jtvnw.net/emoticons/v2/${emote.key}/default/dark/1.0",
      height: height,
      placeholder: (BuildContext context, String url) =>
          const CircularProgressIndicator(),
      errorWidget: (BuildContext context, String url, error) =>
          const Icon(Icons.error),
    );
  }
}
