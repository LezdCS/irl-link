import 'package:irllink/src/domain/entities/settings.dart';

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
    //GENERAL SETTINGS
    required bool isDarkMode,
    required bool keepSpeakerOn,
    required bool keepScreenOn,
    //CONNECTIONS SETTINGS
    required bool isObsConnected,
    required String obsWebsocketUrl,
    required String obsWebsocketPassword,
    required String streamElementsAccessToken,
    required List browserTabs,
  }) : super(
          //CHAT SETTINGS
          isEmotes: isEmotes,
          textSize: textSize,
          emotesSize: emotesSize,
          displayTimestamp: displayTimestamp,
          alternateChannel: alternateChannel,
          alternateChannelName: alternateChannelName,
          hiddenUsersIds: hiddenUsersIds,
          //GENERAL SETTINGS
          isDarkMode: isDarkMode,
          keepSpeakerOn: keepSpeakerOn,
          keepScreenOn: keepScreenOn,
          //CONNECTIONS SETTINGS
          obsWebsocketUrl: obsWebsocketUrl,
          obsWebsocketPassword: obsWebsocketPassword,
          isObsConnected: isObsConnected,
          streamElementsAccessToken: streamElementsAccessToken,
          browserTabs: browserTabs,
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
        //GENERAL
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'keepScreenOn': keepScreenOn,
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
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
      //GENERAL SETTINGS
      isDarkMode: map['isDarkMode'] != null
          ? map['isDarkMode'] as bool
          : Settings.defaultSettings().isDarkMode!,
      keepSpeakerOn: map['keepSpeakerOn'] != null
          ? map['keepSpeakerOn'] as bool
          : Settings.defaultSettings().keepSpeakerOn!,
      keepScreenOn: map['keepScreenOn'] != null
          ? map['keepScreenOn'] as bool
          : Settings.defaultSettings().keepScreenOn!,
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
    );
  }
}
