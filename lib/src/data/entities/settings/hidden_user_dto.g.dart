// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hidden_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HiddenUserDTO _$HiddenUserDTOFromJson(Map<String, dynamic> json) =>
    _HiddenUserDTO(
      id: json['id'] as String,
      username: json['username'] as String,
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
    );

Map<String, dynamic> _$HiddenUserDTOToJson(_HiddenUserDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'platform': _$PlatformEnumMap[instance.platform]!,
    };

const _$PlatformEnumMap = {
  Platform.twitch: 'twitch',
  Platform.kick: 'kick',
  Platform.youtube: 'youtube',
};
