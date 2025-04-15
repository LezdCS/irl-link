import 'package:talker_flutter/talker_flutter.dart';

class GetxInstanceLog extends TalkerLog {
  bool isDeleteAction;
  GetxInstanceLog(String super.message, {required this.isDeleteAction});

  /// Your custom log title
  @override
  String get title => 'GetX Instance ${isDeleteAction ? '🔴' : '🟢'}';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}

class SettingsLog extends TalkerLog {
  SettingsLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'Settings 🛠️';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(152);
}

class RouterLog extends TalkerLog {
  RouterLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'route';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(135);
}

class StreamElementsLog extends TalkerLog {
  StreamElementsLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'StreamElements 🚀';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..rgb(r: 0, g: 63, b: 222);
}

class ObsLog extends TalkerLog {
  ObsLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'OBS 💻';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..rgb(r: 51, g: 102, b: 204);
}

class TwitchLog extends TalkerLog {
  TwitchLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'Twitch 🎮';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..rgb(r: 145, g: 70, b: 255);
}

class KickLog extends TalkerLog {
  KickLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'Kick 🎮';
}
