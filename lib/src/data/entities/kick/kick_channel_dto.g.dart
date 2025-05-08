// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_channel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KickChannelDto _$KickChannelDtoFromJson(Map<String, dynamic> json) =>
    _KickChannelDto(
      bannerPicture: json['banner_picture'] as String,
      broadcasterUserId: (json['broadcaster_user_id'] as num).toInt(),
      category:
          KickCategoryDTO.fromJson(json['category'] as Map<String, dynamic>),
      channelDescription: json['channel_description'] as String,
      slug: json['slug'] as String,
      stream:
          KickChannelStreamDto.fromJson(json['stream'] as Map<String, dynamic>),
      streamTitle: json['stream_title'] as String,
    );

Map<String, dynamic> _$KickChannelDtoToJson(_KickChannelDto instance) =>
    <String, dynamic>{
      'banner_picture': instance.bannerPicture,
      'broadcaster_user_id': instance.broadcasterUserId,
      'category': instance.category,
      'channel_description': instance.channelDescription,
      'slug': instance.slug,
      'stream': instance.stream,
      'stream_title': instance.streamTitle,
    };

_KickChannelStreamDto _$KickChannelStreamDtoFromJson(
        Map<String, dynamic> json) =>
    _KickChannelStreamDto(
      isLive: json['is_live'] as bool,
      isMature: json['is_mature'] as bool,
      key: json['key'] as String,
      language: json['language'] as String,
      startTime: json['start_time'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      viewerCount: (json['viewer_count'] as num).toInt(),
    );

Map<String, dynamic> _$KickChannelStreamDtoToJson(
        _KickChannelStreamDto instance) =>
    <String, dynamic>{
      'is_live': instance.isLive,
      'is_mature': instance.isMature,
      'key': instance.key,
      'language': instance.language,
      'start_time': instance.startTime,
      'thumbnail': instance.thumbnail,
      'url': instance.url,
      'viewer_count': instance.viewerCount,
    };
