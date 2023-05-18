import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/floating_dashboard_settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';

import '../../domain/entities/settings/chat_events_settings.dart';
import '../../domain/entities/settings/floating_dashboard_settings.dart';

class SettingsDTO extends Settings {
  const SettingsDTO({
    //CHAT SETTINGS
    required bool isEmotes,
    required double textSize,
    required double emotesSize,
    required bool displayTimestamp,
    required bool alternateChannel,
    required String alternateChannelName,
    required List hiddenUsersIds,
    required ChatEventsSettings chatEventsSettings,
    //GENERAL SETTINGS
    required bool isDarkMode,
    required bool keepSpeakerOn,
    required Map appLanguage,
    required FloatingDashboardSettings floatingDashboardSettings,
    //CONNECTIONS SETTINGS
    required bool isObsConnected,
    required String obsWebsocketUrl,
    required String obsWebsocketPassword,
    required String streamElementsAccessToken,
    required List browserTabs,
    required List obsConnectionsHistory,
    //TTS SETTINGS
    required bool ttsEnabled,
    required String language,
    required List prefixsToIgnore,
    required List prefixsToUseTtsOnly,
    required double volume,
    required double pitch,
    required double rate,
    required Map<String, String> voice,
    required List ttsUsersToIgnore,
    required bool ttsMuteViewerName,
  }) : super(
          //CHAT SETTINGS
          isEmotes: isEmotes,
          textSize: textSize,
          emotesSize: emotesSize,
          displayTimestamp: displayTimestamp,
          alternateChannel: alternateChannel,
          alternateChannelName: alternateChannelName,
          hiddenUsersIds: hiddenUsersIds,
          chatEventsSettings: chatEventsSettings,
          //GENERAL SETTINGS
          isDarkMode: isDarkMode,
          keepSpeakerOn: keepSpeakerOn,
          appLanguage: appLanguage,
          floatingDashboardSettings: floatingDashboardSettings,
          //CONNECTIONS SETTINGS
          obsWebsocketUrl: obsWebsocketUrl,
          obsWebsocketPassword: obsWebsocketPassword,
          isObsConnected: isObsConnected,
          streamElementsAccessToken: streamElementsAccessToken,
          browserTabs: browserTabs,
          obsConnectionsHistory: obsConnectionsHistory,
          //TTS SETTINGS
          ttsEnabled: ttsEnabled,
          language: language,
          prefixsToIgnore: prefixsToIgnore,
          prefixsToUseTtsOnly: prefixsToUseTtsOnly,
          volume: volume,
          pitch: pitch,
          rate: rate,
          voice: voice,
          ttsUsersToIgnore: ttsUsersToIgnore,
          ttsMuteViewerName: ttsMuteViewerName,
        );

  Map toJson() => {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
        'hiddenUsersIds': hiddenUsersIds,
        'chatEventsSettings': chatEventsSettings?.toJson(),
        //GENERAL
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'appLanguage': appLanguage,
        'floatingDashboardSettings': floatingDashboardSettings?.toJson(),
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
        'obsConnectionsHistory': obsConnectionsHistory,
        //TTS
        'ttsEnabled': ttsEnabled,
        'language': language,
        'prefixsToIgnore': prefixsToIgnore,
        'prefixsToUseTtsOnly': prefixsToUseTtsOnly,
        'volume': volume,
        'pitch': pitch,
        'rate': rate,
        'voice': voice,
        'ttsUsersToIgnore': ttsUsersToIgnore,
        'ttsMuteViewerName': ttsMuteViewerName,
      };

  factory SettingsDTO.fromJson(Map<String, dynamic> map) {
    return SettingsDTO(
      //CHAT SETTINGS
      isEmotes: map['isEmotes'] != null
          ? map['isEmotes'] as bool
          : Settings.defaultSettings().isEmotes!,
      textSize: map['textSize'] != null
          ? map['textSize'] as double
          : Settings.defaultSettings().textSize!,
      emotesSize: map['emotesSize'] != null
          ? map['emotesSize'] as double
          : Settings.defaultSettings().emotesSize!,
      displayTimestamp: map['displayTimestamp'] != null
          ? map['displayTimestamp'] as bool
          : Settings.defaultSettings().displayTimestamp!,
      alternateChannel: map['alternateChannel'] != null
          ? map['alternateChannel'] as bool
          : Settings.defaultSettings().alternateChannel!,
      alternateChannelName: map['alternateChannelName'] != null
          ? map['alternateChannelName'] as String
          : Settings.defaultSettings().alternateChannelName!,
      hiddenUsersIds: map['hiddenUsersIds'] != null
          ? map['hiddenUsersIds'] as List
          : Settings.defaultSettings().hiddenUsersIds!,
      chatEventsSettings: map['chatEventsSettings'] != null
          ? ChatEventsSettingsDTO.fromJson(map['chatEventsSettings'])
          : Settings.defaultSettings().chatEventsSettings!,
      //GENERAL SETTINGS
      isDarkMode: map['isDarkMode'] != null
          ? map['isDarkMode'] as bool
          : Settings.defaultSettings().isDarkMode!,
      keepSpeakerOn: map['keepSpeakerOn'] != null
          ? map['keepSpeakerOn'] as bool
          : Settings.defaultSettings().keepSpeakerOn!,
        appLanguage: map['appLanguage'] != null
          ? map['appLanguage'] as Map
          : Settings.defaultSettings().appLanguage!,
      floatingDashboardSettings: map['floatingDashboardSettings'] != null
          ? FloatingDashboardSettingsDTO.fromJson(map['floatingDashboardSettings'])
          : Settings.defaultSettings().floatingDashboardSettings!,
      //CONNECTIONS SETTINGS
      isObsConnected: map['isObsConnected'] != null
          ? map['isObsConnected'] as bool
          : Settings.defaultSettings().isObsConnected!,
      obsWebsocketUrl: map['obsWebsocketUrl'] != null
          ? map['obsWebsocketUrl'] as String
          : Settings.defaultSettings().obsWebsocketUrl!,
      obsWebsocketPassword: map['obsWebsocketPassword'] != null
          ? map['obsWebsocketPassword'] as String
          : Settings.defaultSettings().obsWebsocketPassword!,
      streamElementsAccessToken: map['streamElementsAccessToken'] != null
          ? map['streamElementsAccessToken'] as String
          : Settings.defaultSettings().streamElementsAccessToken!,
      browserTabs: map['browserTabs'] != null
          ? map['browserTabs'] as List
          : Settings.defaultSettings().browserTabs!,
      obsConnectionsHistory: map['obsConnectionsHistory'] != null
          ? map['obsConnectionsHistory'] as List
          : Settings.defaultSettings().obsConnectionsHistory!,
      //TTS SETTINGS
      ttsEnabled: map['ttsEnabled'] != null
          ? map['ttsEnabled'] as bool
          : Settings.defaultSettings().ttsEnabled!,
      language: map['language'] != null
          ? map['language'] as String
          : Settings.defaultSettings().language!,
      prefixsToIgnore: map['prefixsToIgnore'] != null
          ? map['prefixsToIgnore'] as List
          : Settings.defaultSettings().prefixsToIgnore!,
      prefixsToUseTtsOnly: map['prefixsToUseTtsOnly'] != null
          ? map['prefixsToUseTtsOnly'] as List
          : Settings.defaultSettings().prefixsToUseTtsOnly!,
      volume: map['volume'] != null
          ? map['volume'] as double
          : Settings.defaultSettings().volume!,
      pitch: map['pitch'] != null
          ? map['pitch'] as double
          : Settings.defaultSettings().pitch!,
      rate: map['rate'] != null
          ? map['rate'] as double
          : Settings.defaultSettings().rate!,
      voice: map['voice'] != null
          ? {"name": map["voice"]["name"], "locale": map["voice"]["locale"]}
          : Settings.defaultSettings().voice!,
      ttsUsersToIgnore: map['ttsUsersToIgnore'] != null
          ? map['ttsUsersToIgnore'] as List
          : Settings.defaultSettings().ttsUsersToIgnore!,
      ttsMuteViewerName: map['ttsMuteViewerName'] != null
          ? map['ttsMuteViewerName'] as bool
          : Settings.defaultSettings().ttsMuteViewerName!,
    );
  }
}
