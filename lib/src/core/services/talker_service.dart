import 'package:get/get.dart';
import 'package:irllink/src/core/utils/crashlytics_talker_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService extends GetxService {
  late Talker talker;

  Future<TalkerService> init() async {
    final crashlyticsTalkerObserver = CrashlyticsTalkerObserver();
    talker = TalkerFlutter.init(
      settings: TalkerSettings(
        colors: {
          TalkerLogType.debug.key: AnsiPen()..yellow(),
        },
      ),
      observer: crashlyticsTalkerObserver,
    );
    return this;
  }
}
