import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isInitialized = false;

  static const channelId = 'firebase_messaging_channel';
  static const channelName = 'Firebase Messaging Channel';
  static const channelDescription =
      'This channel is used for Firebase Messaging notifications.';

  Future<NotificationService> init() async {
    await _requestPermission();
    await _setupMessageHandler();

    return this;
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission();
  }

  Future<void> setupFlutterNotifications() async {
    if (isInitialized) {
      return;
    }

    const channel = AndroidNotificationChannel(
      channelId, // id
      channelName, // title
      description: channelDescription, // description
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

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );

    isInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification == null || android == null) {
      return;
    }

    debugPrint(
      'NotificationService: showNotification - Title: ${notification.title}',
    );

    await flutterLocalNotificationsPlugin.show(
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

  Future<void> _setupMessageHandler() async {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message);
    });
  }

  void _handleMessage(RemoteMessage message) {
    // if (message.data['type'] == 'chat') {
    // custom
    // }
  }
}
