import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleFirebaseMessaging(RemoteMessage message) async {
  debugPrint('handleFirebaseMessaging: $message');
}
