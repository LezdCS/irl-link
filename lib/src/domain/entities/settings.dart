import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final bool? alternateChannel;
  final String? alternateChannelName;

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

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.streamElementsAccessToken,
  });

  Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 20,
    this.emotesSize = 20,
    this.displayTimestamp = false,
    this.alternateChannel = false,
    this.alternateChannelName = "",

    //CONNECTIONS SETTINGS
    this.isObsConnected = false,
    this.obsWebsocketUrl = "",
    this.streamElementsAccessToken = "",
  });

  Map toJson() => {
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'streamElementsAccessToken': streamElementsAccessToken,
      };

  @override
  List<Object?> get props {
    return [
      isEmotes,
      textSize,
      emotesSize,
      displayTimestamp,
      alternateChannel,
      alternateChannelName,
      isObsConnected,
      obsWebsocketUrl,
      streamElementsAccessToken,
    ];
  }

  @override
  bool get stringify => true;

  Settings copyWith({
    bool? isEmotes,
    double? textSize,
    double? emotesSize,
    bool? displayTimestamp,
    bool? alternateChannel,
    String? alternateChannelName,
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? streamElementsAccessToken,
  }) =>
      Settings(
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        emotesSize: emotesSize ?? this.emotesSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        alternateChannel: alternateChannel ?? this.alternateChannel,
        alternateChannelName: alternateChannelName ?? this.alternateChannelName,
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        streamElementsAccessToken:
            streamElementsAccessToken ?? this.streamElementsAccessToken,
      );
}
