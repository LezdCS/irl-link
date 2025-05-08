import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/kick/kick_category_dto.dart';

part 'kick_channel_dto.freezed.dart';
part 'kick_channel_dto.g.dart';

@freezed
abstract class KickChannelDto with _$KickChannelDto {
  const factory KickChannelDto({
    @JsonKey(name: 'banner_picture') required String bannerPicture,
    @JsonKey(name: 'broadcaster_user_id') required int broadcasterUserId,
    required KickCategoryDTO category,
    @JsonKey(name: 'channel_description') required String channelDescription,
    required String slug,
    required KickChannelStreamDto stream,
    @JsonKey(name: 'stream_title') required String streamTitle,
  }) = _KickChannelDto;

  factory KickChannelDto.fromJson(Map<String, dynamic> json) =>
      _$KickChannelDtoFromJson(json);
}

@freezed
abstract class KickChannelStreamDto with _$KickChannelStreamDto {
  const factory KickChannelStreamDto({
    @JsonKey(name: 'is_live') required bool isLive,
    @JsonKey(name: 'is_mature') required bool isMature,
    required String key,
    required String language,
    @JsonKey(name: 'start_time') required String startTime,
    required String thumbnail,
    required String url,
    @JsonKey(name: 'viewer_count') required int viewerCount,
  }) = _KickChannelStreamDto;

  factory KickChannelStreamDto.fromJson(Map<String, dynamic> json) =>
      _$KickChannelStreamDtoFromJson(json);
}
