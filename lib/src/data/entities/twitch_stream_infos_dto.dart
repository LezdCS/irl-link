import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';

class TwitchStreamInfosDto extends TwitchStreamInfos {
  const TwitchStreamInfosDto({
    required String title,
    required int viewerCount,
    required bool isOnline,
    required bool isEmoteMode,
    required bool isFollowerMode,
    required bool isSlowMode,
    required bool isSubscriberMode,
  }) : super(
          title: title,
          viewerCount: viewerCount,
          isOnline: isOnline,
          isEmoteMode: isEmoteMode,
          isFollowerMode: isFollowerMode,
          isSlowMode: isSlowMode,
          isSubscriberMode: isSubscriberMode,
        );

  Map toJson() => {
        'viewerCount': viewerCount,
        'title': title,
        'isOnline': isOnline,
        'isEmoteMode': isEmoteMode,
        'isFollowerMode': isFollowerMode,
        'isSlowMode': isSlowMode,
        'isSubscriberMode': isSubscriberMode,
      };

  factory TwitchStreamInfosDto.fromJson(Map<String, dynamic> map1,
      Map<String, dynamic> map2, Map<String, dynamic> map3) {
    return TwitchStreamInfosDto(
      viewerCount:
          map2['data'].length > 0 && map2['data'][0]['viewer_count'] != null
              ? map2['data'][0]['viewer_count']
              : 0,
      title: map1['title'] != null ? map1['title'] as String : '',
      isOnline: map2['data'].length > 0 ? true : false,
      isEmoteMode: map3['emote_mode'],
      isFollowerMode: map3['follower_mode'],
      isSlowMode: map3['slow_mode'],
      isSubscriberMode: map3['subscriber_mode'],
    );
  }
}
