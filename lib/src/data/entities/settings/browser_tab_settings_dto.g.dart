// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserTabSettingsDTOImpl _$$BrowserTabSettingsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$BrowserTabSettingsDTOImpl(
      tabs: (json['tabs'] as List<dynamic>?)
              ?.map((e) => BrowserTabDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BrowserTabSettingsDTOImplToJson(
        _$BrowserTabSettingsDTOImpl instance) =>
    <String, dynamic>{
      'tabs': instance.tabs,
    };

_$BrowserTabDTOImpl _$$BrowserTabDTOImplFromJson(Map<String, dynamic> json) =>
    _$BrowserTabDTOImpl(
      id: _idFromJson(json['id']),
      title: json['title'] as String,
      url: json['url'] as String,
      toggled: json['toggled'] as bool,
      iOSAudioSource: json['iOSAudioSource'] as bool,
    );

Map<String, dynamic> _$$BrowserTabDTOImplToJson(_$BrowserTabDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'toggled': instance.toggled,
      'iOSAudioSource': instance.iOSAudioSource,
    };
