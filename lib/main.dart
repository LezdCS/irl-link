import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  await GetStorage.init();
  Wakelock.enable();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginView(),
      initialRoute: AppPages.INITIAL,
      initialBinding: LoginBindings(),
      getPages: AppPages.routes,
    );
  }
}
