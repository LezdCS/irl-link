import 'package:irllink/src/domain/entities/settings.dart';

class SettingsDTO extends Settings {
  const SettingsDTO({
    required bool isEmotes,
    required double textSize,
    required double emotesSize,
    required bool displayTimestamp,
    required bool alternateChannel,
    required String alternateChannelName,
  }) : super(
          isEmotes: isEmotes,
          textSize: textSize,
          emotesSize: emotesSize,
          displayTimestamp: displayTimestamp,
          alternateChannel: alternateChannel,
          alternateChannelName: alternateChannelName,
        );

  Map toJson() => {
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
      };

  factory SettingsDTO.fromJson(Map<String, dynamic> map) {
    return SettingsDTO(
      isEmotes: map['isEmotes'] as bool,
      textSize: map['textSize'] as double,
      emotesSize: map['emotesSize'] as double,
      displayTimestamp: map['displayTimestamp'] as bool,
      alternateChannel: map['alternateChannel'] as bool,
      alternateChannelName: map['alternateChannelName'] as String,
    );
  }
}
