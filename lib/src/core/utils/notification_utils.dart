import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Shared notification constants and utilities
/// Can be used from both main isolate and background isolate
class NotificationUtils {
  static const channelId = 'firebase_messaging_channel';
  static const channelName = 'Firebase Messaging Channel';
  static const channelDescription =
      'This channel is used for Firebase Messaging notifications.';

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
}
