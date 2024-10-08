import 'package:cached_network_image/cached_network_image.dart';
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
    return CachedNetworkImage(
      imageUrl: "https://files.kick.com/emotes/$emoteId/fullsize",
      width: height,
      height: height,
      placeholder: (BuildContext context, String url) =>
          const CircularProgressIndicator(),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
    );
  }
}
