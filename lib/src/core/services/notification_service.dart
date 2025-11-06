import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:irllink/src/core/utils/notification_utils.dart';

class NotificationService {
  final _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isInitialized = false;

  Future<NotificationService> init() async {
    await _requestPermission();
    await setupFlutterNotifications(); // Initialize notifications before setting up handlers
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
      NotificationUtils.channelId, // id
      NotificationUtils.channelName, // title
      description: NotificationUtils.channelDescription, // description
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
    // Ensure notifications are initialized before showing
    if (!isInitialized) {
      await setupFlutterNotifications();
    }

    // Use shared utility to show notification
    await NotificationUtils.showNotificationFromMessage(
      flutterLocalNotificationsPlugin,
      message,
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
