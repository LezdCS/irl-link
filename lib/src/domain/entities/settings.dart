import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final bool? alternateChannel;
  final String? alternateChannelName;
  final List? hiddenUsersIds;

  //GENERAL SETTINGS
  final bool? isDarkMode;
  final bool? keepSpeakerOn;

  //CONNECTIONS SETTINGS
  final bool? isObsConnected;
  final String? obsWebsocketUrl;
  final String? obsWebsocketPassword;
  final String? streamElementsAccessToken;
  final List? browserTabs;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.emotesSize,
    required this.displayTimestamp,
    required this.alternateChannel,
    required this.alternateChannelName,
    required this.hiddenUsersIds,

    //GENERAL SETTINGS
    required this.isDarkMode,
    required this.keepSpeakerOn,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.obsWebsocketPassword,
    required this.streamElementsAccessToken,
    required this.browserTabs,
  });

  Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 19,
    this.emotesSize = 20,
    this.displayTimestamp = false,
    this.alternateChannel = false,
    this.alternateChannelName = "",
    this.hiddenUsersIds = const [],

    //GENERAL SETTINGS
    this.isDarkMode = true,
    this.keepSpeakerOn = true,

    //CONNECTIONS SETTINGS
    this.isObsConnected = false,
    this.obsWebsocketUrl = "",
    this.obsWebsocketPassword = "",
    this.streamElementsAccessToken = "",
    this.browserTabs = const [],
  });

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
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
      };

  @override
  List<Object?> get props {
    return [
      //CHAT
      isEmotes,
      textSize,
      emotesSize,
      displayTimestamp,
      alternateChannel,
      alternateChannelName,
      hiddenUsersIds,
      //GENERAL
      isDarkMode,
      keepSpeakerOn,
      //CONNECTIONS
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      streamElementsAccessToken,
      browserTabs,
    ];
  }

  @override
  bool get stringify => true;

  Settings copyWith({
    //CHAT
    bool? isEmotes,
    double? textSize,
    double? emotesSize,
    bool? displayTimestamp,
    bool? alternateChannel,
    String? alternateChannelName,
    List? hiddenUsersIds,
    //GENERAL
    bool? isDarkMode,
    bool? keepSpeakerOn,
    //CONNECTIONS
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? obsWebsocketPassword,
    String? streamElementsAccessToken,
    List? browserTabs,
  }) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        emotesSize: emotesSize ?? this.emotesSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        alternateChannel: alternateChannel ?? this.alternateChannel,
        alternateChannelName: alternateChannelName ?? this.alternateChannelName,
        hiddenUsersIds: hiddenUsersIds ?? this.hiddenUsersIds,
        //GENERAL
        isDarkMode: isDarkMode ?? this.isDarkMode,
        keepSpeakerOn: keepSpeakerOn ?? this.keepSpeakerOn,
        //CONNECTIONS
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        obsWebsocketPassword: obsWebsocketPassword ?? this.obsWebsocketPassword,
        streamElementsAccessToken:
            streamElementsAccessToken ?? this.streamElementsAccessToken,
        browserTabs: browserTabs ?? this.browserTabs,
      );
}
