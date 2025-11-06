import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/firebase_options.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/core/depedency_injection.dart';
import 'package:irllink/src/core/resources/app_translations.dart';
import 'package:irllink/src/core/resources/themes.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/notification_utils.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // KickChat.configureLogging(Level.ALL);

  if (Platform.isAndroid) {
    debugPaintSizeEnabled = false;
    debugRepaintRainbowEnabled = false;
    debugRepaintTextRainbowEnabled = false;
  }

  try {
    await GetStorage.init();
  } catch (e) {
    // Can't use Crashlytics yet, Firebase not initialized
    debugPrint('Error initializing GetStorage: $e');
    rethrow;
  }

  try {
    await WakelockPlus.enable();
  } catch (e) {
    // Non-critical, continue
    debugPrint('Error enabling Wakelock: $e');
  }

  try {
    await KickChat.init();
  } catch (e) {
    // Non-critical, continue
    debugPrint('Error initializing KickChat: $e');
  }

  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInitialized = true;
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
    rethrow;
  }

  // Set up error handling for release builds after Firebase is initialized
  if (firebaseInitialized) {
    FlutterError.onError = (errorDetails) {
      FlutterError.presentError(errorDetails);
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      }
    };

    // Handle errors outside of Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      return true;
    };
  }

  // Initialize the database
  try {
    await DatabaseHelper.instance.database;
  } catch (e, stack) {
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    }
    rethrow;
  }

  FirebaseMessaging.onBackgroundMessage(_handleFirebaseMessagingBackground);
  NotificationUtils.getFcmToken().then((token) {
    debugPrint('fcmToken: $token');
  }).catchError((e, stack) {
    debugPrint('Failed to get FCM token: $e');
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(e, stack);
    }
  });

  AppTranslations.initLanguages();
  FlutterForegroundTask.initCommunicationPort();

  await FlutterDownloader.initialize(
    debug: kDebugMode, // Only enable debug in debug mode
    ignoreSsl:
        true, // option: set to false to disable working with http links (default: false)
  );

  try {
    await initializeDependencies();
  } catch (e, stack) {
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    }
    rethrow;
  }

  runApp(const Main());
}

@pragma('vm:entry-point')
Future<void> _handleFirebaseMessagingBackground(RemoteMessage message) async {
  // Background message handler runs in a separate isolate
  // GetX dependencies are not available here, so we need to initialize everything manually
  try {
    // Initialize Firebase (safe to call multiple times, but in a separate isolate it's needed)
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      // Firebase might already be initialized, which is fine
      // Only rethrow if it's a different error
      if (!e.toString().contains('already been initialized')) {
        rethrow;
      }
    }

    // Use shared utility to initialize and show notification
    final flutterLocalNotificationsPlugin =
        await NotificationUtils.initializeNotifications();
    await NotificationUtils.showNotificationFromMessage(
      flutterLocalNotificationsPlugin,
      message,
    );
  } catch (e, stack) {
    // Record error to Crashlytics if available
    try {
      await FirebaseCrashlytics.instance.recordError(e, stack);
    } catch (_) {
      // If Crashlytics isn't available, just ignore
    }
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final talkerService = Get.find<TalkerService>();

    return GetMaterialApp(
      home: const LoginView(),
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      initialBinding: LoginBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      navigatorObservers: [
        TalkerRouteObserver(talkerService.talker),
      ],
      logWriterCallback: localLogWriter,
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    final talkerService = Get.find<TalkerService>();
    if (isError) {
      talkerService.talker.error(text);
    } else {
      if (text.startsWith('Instance')) {
        talkerService.talker
            .logCustom(GetxInstanceLog(text, isDeleteAction: false));
        return;
      }
      if (text.endsWith('onDelete() called') ||
          text.endsWith('deleted from memory')) {
        talkerService.talker
            .logCustom(GetxInstanceLog(text, isDeleteAction: true));
        return;
      }
      if (text.contains('GOING TO ROUTE') || text.contains('CLOSE TO ROUTE')) {
        return;
      }
      if (text.startsWith('REMOVING ROUTE')) {
        talkerService.talker.logCustom(RouterLog(text));
        return;
      }
      talkerService.talker.log(text);
    }
  }
}
