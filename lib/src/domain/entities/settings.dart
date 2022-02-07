import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final bool? alternateChannel;
  final String? alternateChannelName;

  //GENERAL SETTINGS
  final bool? isDarkMode;
  final bool? keepSpeakerOn;
  final bool? keepScreenOn;

  //CONNECTIONS SETTINGS
  final bool? isObsConnected;
  final String? obsWebsocketUrl;
  final String? streamElementsAccessToken;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.emotesSize,
    required this.displayTimestamp,
    required this.alternateChannel,
    required this.alternateChannelName,

    //GENERAL SETTINGS
    required this.isDarkMode,
    required this.keepSpeakerOn,
    required this.keepScreenOn,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.streamElementsAccessToken,
  });

  Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 19,
    this.emotesSize = 20,
    this.displayTimestamp = false,
    this.alternateChannel = false,
    this.alternateChannelName = "",

    //GENERAL SETTINGS
    this.isDarkMode = true,
    this.keepSpeakerOn = true,
    this.keepScreenOn = true,

    //CONNECTIONS SETTINGS
    this.isObsConnected = false,
    this.obsWebsocketUrl = "",
    this.streamElementsAccessToken = "",
  });

  Map toJson() =>
      {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
        //GENERAL
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'keepScreenOn': keepScreenOn,
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'streamElementsAccessToken': streamElementsAccessToken,
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
      //GENERAL
      isDarkMode,
      keepSpeakerOn,
      keepScreenOn,
      //CONNECTIONS
      isObsConnected,
      obsWebsocketUrl,
      streamElementsAccessToken,
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
    //GENERAL
    bool? isDarkMode,
    bool? keepSpeakerOn,
    bool? keepScreenOn,
    //CONNECTIONS
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? streamElementsAccessToken,
  }) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        emotesSize: emotesSize ?? this.emotesSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        alternateChannel: alternateChannel ?? this.alternateChannel,
        alternateChannelName: alternateChannelName ?? this.alternateChannelName,
        //GENERAL
        isDarkMode: isDarkMode ?? this.isDarkMode,
        keepSpeakerOn:keepSpeakerOn ?? this.keepSpeakerOn,
        keepScreenOn:keepScreenOn ?? this.keepScreenOn,
        //CONNECTIONS
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        streamElementsAccessToken:
        streamElementsAccessToken ?? this.streamElementsAccessToken,
      );
}
