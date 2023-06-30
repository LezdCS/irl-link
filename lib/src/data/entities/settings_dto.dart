import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/floating_dashboard_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/general_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';

import '../../domain/entities/settings/chat_events_settings.dart';
import '../../domain/entities/settings/floating_dashboard_settings.dart';
import '../../domain/entities/settings/stream_elements_settings.dart';

class SettingsDTO extends Settings {
  const SettingsDTO({
    //CHAT SETTINGS
    required bool isEmotes,
    required double textSize,
    required bool displayTimestamp,
    required List hiddenUsersIds,
    required ChatEventsSettings chatEventsSettings,
    required ChatSettings chatSettings,
    //GENERAL SETTINGS
    required GeneralSettings generalSettings,
    required FloatingDashboardSettings floatingDashboardSettings,
    //CONNECTIONS SETTINGS
    required bool isObsConnected,
    required String obsWebsocketUrl,
    required String obsWebsocketPassword,
    required String streamElementsAccessToken,
    required List browserTabs,
    required List obsConnectionsHistory,
    required StreamElementsSettings streamElementsSettings,
    //TTS SETTINGS
    required TtsSettings ttsSettings,
  }) : super(
          //CHAT SETTINGS
          isEmotes: isEmotes,
          textSize: textSize,
          displayTimestamp: displayTimestamp,
          hiddenUsersIds: hiddenUsersIds,
          chatEventsSettings: chatEventsSettings,
          chatSettings: chatSettings,
          //GENERAL SETTINGS
          generalSettings: generalSettings,
          floatingDashboardSettings: floatingDashboardSettings,
          //CONNECTIONS SETTINGS
          obsWebsocketUrl: obsWebsocketUrl,
          obsWebsocketPassword: obsWebsocketPassword,
          isObsConnected: isObsConnected,
          streamElementsAccessToken: streamElementsAccessToken,
          browserTabs: browserTabs,
          obsConnectionsHistory: obsConnectionsHistory,
          streamElementsSettings: streamElementsSettings,
          //TTS SETTINGS
          ttsSettings: ttsSettings
        );

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
        'floatingDashboardSettings': floatingDashboardSettings?.toJson(),
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
        'obsConnectionsHistory': obsConnectionsHistory,
        'streamElementsSettings': streamElementsSettings?.toJson(),
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
      floatingDashboardSettings: map['floatingDashboardSettings'] != null
          ? FloatingDashboardSettingsDTO.fromJson(
              map['floatingDashboardSettings'])
          : const Settings.defaultSettings().floatingDashboardSettings!,
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
      streamElementsAccessToken: map['streamElementsAccessToken'] != null
          ? map['streamElementsAccessToken'] as String
          : const Settings.defaultSettings().streamElementsAccessToken!,
      browserTabs: map['browserTabs'] != null
          ? map['browserTabs'] as List
          : const Settings.defaultSettings().browserTabs!,
      obsConnectionsHistory: map['obsConnectionsHistory'] != null
          ? map['obsConnectionsHistory'] as List
          : const Settings.defaultSettings().obsConnectionsHistory!,
      streamElementsSettings: map['streamElementsSettings'] != null
          ? StreamElementsSettingsDTO.fromJson(map['streamElementsSettings'])
          : const Settings.defaultSettings().streamElementsSettings!,
      //TTS SETTINGS
      ttsSettings: map['ttsSettings'] != null
          ? TtsSettingsDTO.fromJson(map['ttsSettings'])
          : const Settings.defaultSettings().ttsSettings!,
    );
  }
}
