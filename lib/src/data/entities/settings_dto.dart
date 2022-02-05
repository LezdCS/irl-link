import 'package:irllink/src/domain/entities/settings.dart';

class SettingsDTO extends Settings {
  const SettingsDTO({
    required bool isEmotes,
    required double textSize,
    required double emotesSize,
    required bool displayTimestamp,
    required bool alternateChannel,
    required String alternateChannelName,
    required bool isObsConnected,
    required String obsWebsocketUrl,
    required String streamElementsAccessToken,
  }) : super(
          isEmotes: isEmotes,
          textSize: textSize,
          emotesSize: emotesSize,
          displayTimestamp: displayTimestamp,
          alternateChannel: alternateChannel,
          alternateChannelName: alternateChannelName,
          obsWebsocketUrl: obsWebsocketUrl,
          isObsConnected: isObsConnected,
          streamElementsAccessToken: streamElementsAccessToken,
        );

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

  factory SettingsDTO.fromJson(Map<String, dynamic> map) {
    return SettingsDTO(
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
        isObsConnected: map['isObsConnected'] != null
            ? map['isObsConnected'] as bool
            : Settings.defaultSettings().isObsConnected!,
        obsWebsocketUrl: map['obsWebsocketUrl'] != null
            ? map['obsWebsocketUrl'] as String
            : Settings.defaultSettings().obsWebsocketUrl!,
        streamElementsAccessToken: map['streamElementsAccessToken'] != null
            ? map['streamElementsAccessToken'] as String
            : Settings.defaultSettings().streamElementsAccessToken!);
  }
}
