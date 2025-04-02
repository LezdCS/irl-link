// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsDTO _$SettingsDTOFromJson(Map<String, dynamic> json) => _SettingsDTO(
      isEmotes: json['isEmotes'] as bool? ?? true,
      textSize: (json['textSize'] as num?)?.toDouble() ?? 19,
      displayTimestamp: json['displayTimestamp'] as bool? ?? false,
      hiddenUsersIds: json['hiddenUsersIds'] as List<dynamic>? ?? const [],
      chatEventsSettings: ChatEventsSettingsDTO.fromJson(
          json['chatEventsSettings'] as Map<String, dynamic>),
      chatSettings: ChatSettingsDTO.fromJson(
          json['chatSettings'] as Map<String, dynamic>),
      generalSettings: GeneralSettingsDTO.fromJson(
          json['generalSettings'] as Map<String, dynamic>),
      dashboardSettings: DashboardSettingsDTO.fromJson(
          json['dashboardSettings'] as Map<String, dynamic>),
      isObsConnected: json['isObsConnected'] as bool? ?? false,
      obsWebsocketUrl: json['obsWebsocketUrl'] as String? ?? "",
      obsWebsocketPassword: json['obsWebsocketPassword'] as String? ?? "",
      browserTabs: BrowserTabSettingsDTO.fromJson(
          json['browserTabs'] as Map<String, dynamic>),
      obsConnectionsHistory:
          json['obsConnectionsHistory'] as List<dynamic>? ?? const [],
      streamElementsSettings: StreamElementsSettingsDTO.fromJson(
          json['streamElementsSettings'] as Map<String, dynamic>),
      rtIrlPushKey: json['rtIrlPushKey'] as String? ?? "",
      ttsSettings:
          TtsSettingsDTO.fromJson(json['ttsSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsDTOToJson(_SettingsDTO instance) =>
    <String, dynamic>{
      'isEmotes': instance.isEmotes,
      'textSize': instance.textSize,
      'displayTimestamp': instance.displayTimestamp,
      'hiddenUsersIds': instance.hiddenUsersIds,
      'chatEventsSettings': instance.chatEventsSettings,
      'chatSettings': instance.chatSettings,
      'generalSettings': instance.generalSettings,
      'dashboardSettings': instance.dashboardSettings,
      'isObsConnected': instance.isObsConnected,
      'obsWebsocketUrl': instance.obsWebsocketUrl,
      'obsWebsocketPassword': instance.obsWebsocketPassword,
      'browserTabs': instance.browserTabs,
      'obsConnectionsHistory': instance.obsConnectionsHistory,
      'streamElementsSettings': instance.streamElementsSettings,
      'rtIrlPushKey': instance.rtIrlPushKey,
      'ttsSettings': instance.ttsSettings,
    };
