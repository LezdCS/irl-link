// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsDTO _$SettingsDTOFromJson(Map<String, dynamic> json) => _SettingsDTO(
      isEmotes: json['isEmotes'] as bool? ?? true,
      textSize: (json['textSize'] as num?)?.toDouble() ?? 19,
      displayTimestamp: json['displayTimestamp'] as bool? ?? false,
      chatEventsSettings: ChatEventsSettingsDTO.fromJson(
          json['chatEventsSettings'] as Map<String, dynamic>),
      chatSettings: ChatSettingsDTO.fromJson(
          json['chatSettings'] as Map<String, dynamic>),
      generalSettings: GeneralSettingsDTO.fromJson(
          json['generalSettings'] as Map<String, dynamic>),
      dashboardSettings: DashboardSettingsDTO.fromJson(
          json['dashboardSettings'] as Map<String, dynamic>),
      rtIrlPushKey: json['rtIrlPushKey'] as String? ?? "",
    );

Map<String, dynamic> _$SettingsDTOToJson(_SettingsDTO instance) =>
    <String, dynamic>{
      'isEmotes': instance.isEmotes,
      'textSize': instance.textSize,
      'displayTimestamp': instance.displayTimestamp,
      'chatEventsSettings': instance.chatEventsSettings,
      'chatSettings': instance.chatSettings,
      'generalSettings': instance.generalSettings,
      'dashboardSettings': instance.dashboardSettings,
      'rtIrlPushKey': instance.rtIrlPushKey,
    };
