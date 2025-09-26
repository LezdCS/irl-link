// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserTabDTO _$BrowserTabDTOFromJson(Map<String, dynamic> json) =>
    _BrowserTabDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      toggled: const BoolToIntConverter().fromJson(json['toggled'] as Object),
      iOSAudioSource: const BoolToIntConverter()
          .fromJson(json['is_ios_audio_source'] as Object),
    );

Map<String, dynamic> _$BrowserTabDTOToJson(_BrowserTabDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'toggled': const BoolToIntConverter().toJson(instance.toggled),
      'is_ios_audio_source':
          const BoolToIntConverter().toJson(instance.iOSAudioSource),
    };
