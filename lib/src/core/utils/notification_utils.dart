import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Shared notification constants and utilities
/// Can be used from both main isolate and background isolate
class NotificationUtils {
  static const channelId = 'firebase_messaging_channel';
  static const channelName = 'Firebase Messaging Channel';
  static const channelDescription =
      'This channel is used for Firebase Messaging notifications.';

  static String? _cachedFcmToken;
  static Future<String?>? _pendingTokenFuture;

  /// Initialize the notification plugin and channel
  /// This can be called from both main isolate and background isolate
  static Future<FlutterLocalNotificationsPlugin>
      initializeNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    return flutterLocalNotificationsPlugin;
  }

  /// Show a notification from a RemoteMessage
  /// This can be called from both main isolate and background isolate
  static Future<void> showNotificationFromMessage(
    FlutterLocalNotificationsPlugin plugin,
    RemoteMessage message,
  ) async {
    final notification = message.notification;
    if (notification == null) {
      return;
    }

    await plugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          icon: '@mipmap/ic_launcher',
          priority: Priority.high,
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  /// Returns the FCM token with memoization and retry/backoff to avoid
  /// triggering TOO_MANY_REGISTRATIONS on some devices.
  static Future<String?> getFcmToken({
    bool forceRefresh = false,
    int maxAttempts = 4,
    Duration initialDelay = const Duration(milliseconds: 500),
  }) async {
    if (!forceRefresh && _cachedFcmToken != null) {
      return _cachedFcmToken;
    }

    // Ensure only one registration request is in-flight
    if (_pendingTokenFuture != null) {
      return _pendingTokenFuture;
    }

    _pendingTokenFuture = _getFcmTokenWithBackoff(
      maxAttempts: maxAttempts,
      initialDelay: initialDelay,
    );

    try {
      _cachedFcmToken = await _pendingTokenFuture;
      return  await _pendingTokenFuture;
    } finally {
      _pendingTokenFuture = null;
    }
  }

  static Future<String?> _getFcmTokenWithBackoff({
    int maxAttempts = 4,
    Duration initialDelay = const Duration(milliseconds: 500),
  }) async {
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final token = await FirebaseMessaging.instance.getToken();
        return token;
      } catch (e) {
        final message = e.toString();

        final isRegistrationBurst = message.contains('TOO_MANY_REGISTRATIONS') ||
            message.contains('java.io.IOException');

        // If it looks unrelated to registration bursts, bubble up immediately
        if (!isRegistrationBurst || attempt == maxAttempts) {
          rethrow;
        }

        // Exponential backoff with a small jitter
        final baseDelayMs = initialDelay.inMilliseconds;
        final backoffMs = baseDelayMs * (1 << (attempt - 1));
        final jitterMs = Random().nextInt(250);
        final delay = Duration(milliseconds: backoffMs + jitterMs);
        await Future.delayed(delay);
      }
    }

    return null;
  }
}
