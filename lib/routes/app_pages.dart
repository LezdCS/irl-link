import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/presentation/controllers/HomeViewController.dart';
import 'package:irllink/src/presentation/controllers/SettingsViewController.dart';
import 'package:irllink/src/presentation/views/homeView.dart';
import 'package:irllink/src/presentation/views/loginView.dart';
import 'package:irllink/src/presentation/views/settingsView.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeViewController>(() => HomeViewController());
      }),
      children: [],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsViewController>(() => SettingsViewController());
      }),
    ),
  ];
}
