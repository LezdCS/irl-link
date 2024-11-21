import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  CrashlyticsTalkerObserver();

  @override
  void onError(TalkerError err) {
    FirebaseCrashlytics.instance.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
    );
  }

  @override
  void onException(TalkerException err) {
    FirebaseCrashlytics.instance.recordError(
      err.exception,
      err.stackTrace,
      reason: err.message,
    );
  }
}
