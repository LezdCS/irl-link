import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/kick/kick_category.dart';

@immutable
class KickChannel {
  final String bannerPicture;
  final int broadcasterUserId;
  final KickCategory category;
  final String channelDescription;
  final String slug;
  final KickChannelStream stream;
  final String streamTitle;

  const KickChannel({
    required this.bannerPicture,
    required this.broadcasterUserId,
    required this.category,
    required this.channelDescription,
    required this.slug,
    required this.stream,
    required this.streamTitle,
  });
}

@immutable
class KickChannelStream {
  final bool isLive;
  final bool isMature;
  final String key;
  final String language;
  final String startTime;
  final String thumbnail;
  final String url;
  final int viewerCount;

  const KickChannelStream({
    required this.isLive,
    required this.isMature,
    required this.key,
    required this.language,
    required this.startTime,
    required this.thumbnail,
    required this.url,
    required this.viewerCount,
  });
}
