// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneralSettingsDTO _$GeneralSettingsDTOFromJson(Map<String, dynamic> json) =>
    _GeneralSettingsDTO(
      isDarkMode: json['isDarkMode'] as bool? ?? true,
      keepSpeakerOn: json['keepSpeakerOn'] as bool? ?? true,
      displayViewerCount: json['displayViewerCount'] as bool? ?? true,
      appLanguage: json['appLanguage'] as Map<String, dynamic>? ??
          const {"languageCode": "en", "countryCode": "US"},
      splitViewWeights: (json['splitViewWeights'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [0.5, 0.5],
    );

Map<String, dynamic> _$GeneralSettingsDTOToJson(_GeneralSettingsDTO instance) =>
    <String, dynamic>{
      'isDarkMode': instance.isDarkMode,
      'keepSpeakerOn': instance.keepSpeakerOn,
      'displayViewerCount': instance.displayViewerCount,
      'appLanguage': instance.appLanguage,
      'splitViewWeights': instance.splitViewWeights,
    };
