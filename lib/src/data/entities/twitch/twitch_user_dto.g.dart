// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TwitchUserDTOImpl _$$TwitchUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$TwitchUserDTOImpl(
      id: json['id'] as String,
      login: json['login'] as String,
      displayName: json['display_name'] as String,
      broadcasterType: json['broadcaster_type'] as String,
      description: json['description'] as String,
      profileImageUrl: json['profile_image_url'] as String,
      viewCount: (json['view_count'] as num).toInt(),
    );

Map<String, dynamic> _$$TwitchUserDTOImplToJson(_$TwitchUserDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_name': instance.displayName,
      'broadcaster_type': instance.broadcasterType,
      'description': instance.description,
      'profile_image_url': instance.profileImageUrl,
      'view_count': instance.viewCount,
    };
