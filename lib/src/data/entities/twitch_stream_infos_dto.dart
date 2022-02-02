import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';

class TwitchStreamInfosDto extends TwitchStreamInfos {
  const TwitchStreamInfosDto({
    required String title,
    required int viewerCount,
    required bool isOnline,
  }) : super(
          title: title,
          viewerCount: viewerCount,
          isOnline: isOnline,
        );

  Map toJson() => {
        'viewerCount': viewerCount,
        'title': title,
        'isOnline': isOnline,
      };

  factory TwitchStreamInfosDto.fromJson(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    return TwitchStreamInfosDto(
      viewerCount:
          map2['data'].length > 0 && map2['data'][0]['viewer_count'] != null
              ? map2['data'][0]['viewer_count']
              : 0,
      title: map1['title'] != null ? map1['title'] as String : '',
      isOnline: map2['data'].length > 0 ? true : false,
    );
  }
}
