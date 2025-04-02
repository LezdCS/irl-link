// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TtsSettingsDTO _$TtsSettingsDTOFromJson(Map<String, dynamic> json) =>
    _TtsSettingsDTO(
      ttsEnabled: json['ttsEnabled'] as bool? ?? false,
      language: json['language'] as String? ?? "en-US",
      prefixsToIgnore: json['prefixsToIgnore'] as List<dynamic>? ?? const [],
      prefixsToUseTtsOnly:
          json['prefixsToUseTtsOnly'] as List<dynamic>? ?? const [],
      volume: (json['volume'] as num?)?.toDouble() ?? 1,
      pitch: (json['pitch'] as num?)?.toDouble() ?? 1,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.5,
      voice: (json['voice'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {"name": "en-us-x-sfg-local", "locale": "en-US"},
      ttsUsersToIgnore: json['ttsUsersToIgnore'] as List<dynamic>? ?? const [],
      ttsMuteViewerName: json['ttsMuteViewerName'] as bool? ?? false,
      ttsOnlyVip: json['ttsOnlyVip'] as bool? ?? false,
      ttsOnlyMod: json['ttsOnlyMod'] as bool? ?? false,
      ttsOnlySubscriber: json['ttsOnlySubscriber'] as bool? ?? false,
    );

Map<String, dynamic> _$TtsSettingsDTOToJson(_TtsSettingsDTO instance) =>
    <String, dynamic>{
      'ttsEnabled': instance.ttsEnabled,
      'language': instance.language,
      'prefixsToIgnore': instance.prefixsToIgnore,
      'prefixsToUseTtsOnly': instance.prefixsToUseTtsOnly,
      'volume': instance.volume,
      'pitch': instance.pitch,
      'rate': instance.rate,
      'voice': instance.voice,
      'ttsUsersToIgnore': instance.ttsUsersToIgnore,
      'ttsMuteViewerName': instance.ttsMuteViewerName,
      'ttsOnlyVip': instance.ttsOnlyVip,
      'ttsOnlyMod': instance.ttsOnlyMod,
      'ttsOnlySubscriber': instance.ttsOnlySubscriber,
    };
