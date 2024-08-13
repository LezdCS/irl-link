import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/core/resources/themes.dart';
import 'package:irllink/src/core/utils/crashlytics_talker_observer.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'firebase_options.dart';
import 'src/core/resources/app_translations.dart';
import 'src/core/utils/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final crashlyticsTalkerObserver = CrashlyticsTalkerObserver();
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(),
    observer: crashlyticsTalkerObserver,
  );
  await initializeService();
  await GetStorage.init();
  await WakelockPlus.enable();
  await KickChat.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.version = packageInfo.version;
  globals.buildNumber = packageInfo.buildNumber;
  globals.appName = packageInfo.appName;
  globals.packageName = packageInfo.packageName;
  globals.talker = talker;
  AppTranslations.initLanguages();
  FlutterForegroundTask.initCommunicationPort();
  runApp(Main(
    talker: talker,
  ));
}

Future<void> initializeService() async {

}

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.talker,
  });
  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: UpgradeAlert(
        upgrader: Upgrader(),
        child: const LoginView(),
      ),
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
        TalkerRouteObserver(talker),
      ],
    );
  }
}
