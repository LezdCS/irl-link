import 'package:cached_network_image/cached_network_image.dart';
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
    return CachedNetworkImage(
      imageUrl: emote.url1x,
      height: height,
      placeholder: (BuildContext context, String url) =>
          const CircularProgressIndicator(),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
    );
  }
}
