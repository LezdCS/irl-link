import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/dashboard_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/general_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';

class SettingsDTO extends Settings {
  const SettingsDTO({
    //CHAT SETTINGS
    required super.isEmotes,
    required super.textSize,
    required super.displayTimestamp,
    required super.hiddenUsersIds,
    required super.chatEventsSettings,
    required super.chatSettings,
    //GENERAL SETTINGS
    required super.generalSettings,
    required super.dashboardSettings,
    //CONNECTIONS SETTINGS
    required super.isObsConnected,
    required super.obsWebsocketUrl,
    required super.obsWebsocketPassword,
    required super.browserTabs,
    required super.obsConnectionsHistory,
    required super.streamElementsSettings,
    required super.rtIrlPushKey,
    //TTS SETTINGS
    required super.ttsSettings,
  });

  @override
  Map toJson() => {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'displayTimestamp': displayTimestamp,
        'hiddenUsersIds': hiddenUsersIds,
        'chatEventsSettings': chatEventsSettings?.toJson(),
        'chatSettings': chatSettings?.toJson(),
        //GENERAL
        'generalSettings': generalSettings?.toJson(),
        'dashboardSettings': dashboardSettings?.toJson(),
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'browserTabs': browserTabs?.toJson(),
        'obsConnectionsHistory': obsConnectionsHistory,
        'streamElementsSettings': streamElementsSettings?.toJson(),
        'rtIrlPushKey': rtIrlPushKey,
        //TTS
        'ttsSettings': ttsSettings?.toJson(),
      };

  factory SettingsDTO.fromJson(Map<String, dynamic> map) {
    return SettingsDTO(
      //CHAT SETTINGS
      isEmotes: map['isEmotes'] != null
          ? map['isEmotes'] as bool
          : const Settings.defaultSettings().isEmotes!,
      textSize: map['textSize'] != null
          ? map['textSize'] as double
          : const Settings.defaultSettings().textSize!,
      displayTimestamp: map['displayTimestamp'] != null
          ? map['displayTimestamp'] as bool
          : const Settings.defaultSettings().displayTimestamp!,
      hiddenUsersIds: map['hiddenUsersIds'] != null
          ? map['hiddenUsersIds'] as List
          : const Settings.defaultSettings().hiddenUsersIds!,
      chatEventsSettings: map['chatEventsSettings'] != null
          ? ChatEventsSettingsDTO.fromJson(map['chatEventsSettings'])
          : const Settings.defaultSettings().chatEventsSettings!,
      chatSettings: map['chatSettings'] != null
          ? ChatSettingsDTO.fromJson(map['chatSettings'])
          : const Settings.defaultSettings().chatSettings!,
      //GENERAL SETTINGS
      generalSettings: map['generalSettings'] != null
          ? GeneralSettingsDTO.fromJson(map['generalSettings'])
          : const Settings.defaultSettings().generalSettings!,
      dashboardSettings: map['dashboardSettings'] != null
          ? DashboardSettingsDTO.fromJson(map['dashboardSettings'])
          : const Settings.defaultSettings().dashboardSettings!,
      //CONNECTIONS SETTINGS
      isObsConnected: map['isObsConnected'] != null
          ? map['isObsConnected'] as bool
          : const Settings.defaultSettings().isObsConnected!,
      obsWebsocketUrl: map['obsWebsocketUrl'] != null
          ? map['obsWebsocketUrl'] as String
          : const Settings.defaultSettings().obsWebsocketUrl!,
      obsWebsocketPassword: map['obsWebsocketPassword'] != null
          ? map['obsWebsocketPassword'] as String
          : const Settings.defaultSettings().obsWebsocketPassword!,
      browserTabs: map['browserTabs'] != null
          ? map['browserTabs'] is List<dynamic>
              ? BrowserTabSettingsDTO.fromList(map['browserTabs'])
              : BrowserTabSettingsDTO.fromJson(map['browserTabs'])
          : const Settings.defaultSettings().browserTabs!,
      obsConnectionsHistory: map['obsConnectionsHistory'] != null
          ? map['obsConnectionsHistory'] as List
          : const Settings.defaultSettings().obsConnectionsHistory!,
      streamElementsSettings: map['streamElementsSettings'] != null
          ? StreamElementsSettingsDTO.fromJson(map['streamElementsSettings'])
          : const Settings.defaultSettings().streamElementsSettings!,
      rtIrlPushKey: map['rtIrlPushKey'] != null
          ? map['rtIrlPushKey'] as String
          : const Settings.defaultSettings().rtIrlPushKey!,
      //TTS SETTINGS
      ttsSettings: map['ttsSettings'] != null
          ? TtsSettingsDTO.fromJson(map['ttsSettings'])
          : const Settings.defaultSettings().ttsSettings!,
    );
  }
}
