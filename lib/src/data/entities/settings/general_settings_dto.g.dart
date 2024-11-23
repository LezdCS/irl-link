// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneralSettingsDTOImpl _$$GeneralSettingsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$GeneralSettingsDTOImpl(
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

Map<String, dynamic> _$$GeneralSettingsDTOImplToJson(
        _$GeneralSettingsDTOImpl instance) =>
    <String, dynamic>{
      'isDarkMode': instance.isDarkMode,
      'keepSpeakerOn': instance.keepSpeakerOn,
      'displayViewerCount': instance.displayViewerCount,
      'appLanguage': instance.appLanguage,
      'splitViewWeights': instance.splitViewWeights,
    };
