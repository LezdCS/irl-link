import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:irllink/src/bindings/home_bindings.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/bindings/settings_bindings.dart';
import 'package:irllink/src/presentation/views/home_view.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:irllink/src/presentation/views/settings_view.dart';

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
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBindings(),
    ),
  ];
}
