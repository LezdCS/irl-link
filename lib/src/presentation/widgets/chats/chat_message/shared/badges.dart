import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irllink/src/domain/entities/chat/chat_badge.dart';

class Badges extends StatelessWidget {
  final List<ChatBadge> badges;
  final double textSize;

  const Badges({
    super.key,
    required this.badges,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (ChatBadge badge in badges)
          Container(
            padding: const EdgeInsets.only(right: 4),
            child: Uri.parse(badge.imageUrl1x).isAbsolute
                ? CachedNetworkImage(
                    imageUrl: badge.imageUrl1x,
                    width: textSize,
                    height: textSize,
                    placeholder: (BuildContext context, String url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (BuildContext context, String url, error) =>
                        const Icon(Icons.error),
                  )
                : badge.imageUrl1x.endsWith('.svg')
                    ? SvgPicture.asset(
                        badge.imageUrl1x,
                        width: textSize,
                        height: textSize,
                      )
                    : Image(
                        width: textSize,
                        height: textSize,
                        image: AssetImage(
                          badge.imageUrl1x,
                        ),
                        filterQuality: FilterQuality.high,
                      ),
          ),
      ],
    );
  }
}
