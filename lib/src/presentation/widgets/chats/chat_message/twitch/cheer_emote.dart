import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';

class CheerEmote extends StatelessWidget {
  final ChatEmote cheerEmote;
  final double textSize;

  const CheerEmote({
    super.key,
    required this.cheerEmote,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CachedNetworkImage(
          imageUrl: cheerEmote.url1x,
          placeholder: (BuildContext context, String url) =>
              const CircularProgressIndicator(),
          errorWidget: (BuildContext context, String url, dynamic error) =>
              const Icon(Icons.error),
        ),
        Text(
          '${cheerEmote.id} ',
          style: TextStyle(
            color: Color(int.parse(cheerEmote.color!.replaceAll('#', '0xff'))),
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
