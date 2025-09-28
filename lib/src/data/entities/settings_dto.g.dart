// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsDTO _$SettingsDTOFromJson(Map<String, dynamic> json) => _SettingsDTO(
      chatEventsSettings: ChatEventsSettingsDTO.fromJson(
          json['chatEventsSettings'] as Map<String, dynamic>),
      chatSettings: ChatSettingsDTO.fromJson(
          json['chatSettings'] as Map<String, dynamic>),
      generalSettings: GeneralSettingsDTO.fromJson(
          json['generalSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsDTOToJson(_SettingsDTO instance) =>
    <String, dynamic>{
      'chatEventsSettings': instance.chatEventsSettings,
      'chatSettings': instance.chatSettings,
      'generalSettings': instance.generalSettings,
    };
