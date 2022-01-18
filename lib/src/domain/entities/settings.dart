import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final bool? alternateChannel;
  final String? alternateChannelName;

  const Settings({
    required this.isEmotes,
    required this.textSize,
    required this.emotesSize,
    required this.displayTimestamp,
    required this.alternateChannel,
    required this.alternateChannelName,
  });

  Settings.defaultSettings({
    this.isEmotes = true,
    this.textSize = 20,
    this.emotesSize = 20,
    this.displayTimestamp = false,
    this.alternateChannel = false,
    this.alternateChannelName = "",
  });

  Map toJson() => {
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
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
  }) =>
      Settings(
        isEmotes: isEmotes,
        textSize: textSize,
        emotesSize: emotesSize,
        displayTimestamp: displayTimestamp,
        alternateChannel: alternateChannel,
        alternateChannelName: alternateChannelName,
      );
}
