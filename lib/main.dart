import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/core/resources/themes.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wakelock/wakelock.dart';
import 'firebase_options.dart';
import 'src/core/resources/AppTranslations.dart';
import 'src/core/utils/globals.dart' as Globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Wakelock.enable();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Globals.version = packageInfo.version;
  Globals.buildNumber = packageInfo.buildNumber;
  Globals.appName = packageInfo.appName;
  Globals.packageName = packageInfo.packageName;
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginView(),
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.INITIAL,
      initialBinding: LoginBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US')
    );
  }
}
