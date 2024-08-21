import 'package:talker_flutter/talker_flutter.dart';

class GetxInstanceLog extends TalkerLog {
  bool isDeleteAction;
  GetxInstanceLog(String super.message, this.isDeleteAction);
  /// Your custom log title
  @override
  String get title =>'GetX Instance ${isDeleteAction ? '🔴': '🟢'}';

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

