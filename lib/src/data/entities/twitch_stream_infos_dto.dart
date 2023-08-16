import 'package:intl/intl.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';

class TwitchStreamInfosDto extends TwitchStreamInfos {
  const TwitchStreamInfosDto({
    required String title,
    required int viewerCount,
    required bool isOnline,
    required Duration startedAtDuration,
    required bool isEmoteMode,
    required bool isFollowerMode,
    required bool isSlowMode,
    required int slowModeWaitTime,
    required bool isSubscriberMode,
  }) : super(
          title: title,
          viewerCount: viewerCount,
          isOnline: isOnline,
          startedAtDuration: startedAtDuration,
          isEmoteMode: isEmoteMode,
          isFollowerMode: isFollowerMode,
          isSlowMode: isSlowMode,
          slowModeWaitTime: slowModeWaitTime,
          isSubscriberMode: isSubscriberMode,
        );

  @override
  Map toJson() => {
        'viewerCount': viewerCount,
        'title': title,
        'isOnline': isOnline,
        'startedAtDuration': startedAtDuration,
        'isEmoteMode': isEmoteMode,
        'isFollowerMode': isFollowerMode,
        'isSlowMode': isSlowMode,
        'slowModeWaitTime': slowModeWaitTime,
        'isSubscriberMode': isSubscriberMode,
      };

  factory TwitchStreamInfosDto.fromJson(Map<String, dynamic> map1,
      Map<String, dynamic> map2, Map<String, dynamic> map3) {
    DateFormat df = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    String startedAtRaw =
        map2['data'].length > 0 && map2['data'][0]['started_at'] != null
            ? map2['data'][0]['started_at']
            : df.format(DateTime.now().toUtc());

    DateTime startedAt = df.parse(startedAtRaw);
    DateTime now = df.parse(df.format(DateTime.now().toUtc()));
    Duration startedAtDuration = now.difference(startedAt);
    return TwitchStreamInfosDto(
      viewerCount:
          map2['data'].length > 0 && map2['data'][0]['viewer_count'] != null
              ? map2['data'][0]['viewer_count']
              : 0,
      title: map1['title'] != null ? map1['title'] as String : '',
      isOnline: map2['data'].length > 0 ? true : false,
      startedAtDuration: startedAtDuration,
      isEmoteMode: map3['emote_mode'],
      isFollowerMode: map3['follower_mode'],
      isSlowMode: map3['slow_mode'],
      slowModeWaitTime: map3['slow_mode_wait_time'] ?? 30,
      isSubscriberMode: map3['subscriber_mode'],
    );
  }
}
