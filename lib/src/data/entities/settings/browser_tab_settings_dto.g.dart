// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserTabDTO _$BrowserTabDTOFromJson(Map<String, dynamic> json) =>
    _BrowserTabDTO(
      id: _idFromJson(json['id']),
      title: json['title'] as String,
      url: json['url'] as String,
      toggled: json['toggled'] as bool,
      iOSAudioSource: json['iOSAudioSource'] as bool,
    );

Map<String, dynamic> _$BrowserTabDTOToJson(_BrowserTabDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'toggled': instance.toggled,
      'iOSAudioSource': instance.iOSAudioSource,
    };
