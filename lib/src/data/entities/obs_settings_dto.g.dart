// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obs_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ObsSettingsDTO _$ObsSettingsDTOFromJson(Map<String, dynamic> json) =>
    _ObsSettingsDTO(
      url: json['url'] as String,
      password: json['password'] as String,
      isConnected: json['is_connected'] as bool,
    );

Map<String, dynamic> _$ObsSettingsDTOToJson(_ObsSettingsDTO instance) =>
    <String, dynamic>{
      'url': instance.url,
      'password': instance.password,
      'is_connected': instance.isConnected,
    };
