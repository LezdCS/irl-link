import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/bindings/chats_bindings.dart';
import 'package:irllink/src/bindings/home_bindings.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/bindings/settings/browser_settings_bindings.dart';
import 'package:irllink/src/bindings/settings/hidden_users_bindings.dart';
import 'package:irllink/src/bindings/settings/rtmp_settings_bindings.dart';
import 'package:irllink/src/bindings/settings/streamelements_settings_bindings.dart';
import 'package:irllink/src/bindings/settings_bindings.dart';
import 'package:irllink/src/bindings/tabs_bindings.dart';
import 'package:irllink/src/presentation/views/home_view.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:irllink/src/presentation/views/settings/manage_list_browser_tabs.dart';
import 'package:irllink/src/presentation/views/settings/manage_list_hidden_users.dart';
import 'package:irllink/src/presentation/views/settings/rtmp_settings.dart';
import 'package:irllink/src/presentation/views/settings/stream_elements.dart';
import 'package:irllink/src/presentation/views/settings_view.dart';

class AppPages {
  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBindings(),
      bindings: [
        TabsBindings(),
        ChatsBindings(),
      ],
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: Routes.rtmpSettings,
      page: () => const RtmpSettings(),
      binding: RtmpSettingsBinding(),
    ),
    GetPage(
      name: Routes.streamelementsSettings,
      page: () => const StreamelementsSettings(),
      binding: StreamelementsSettingsBinding(),
    ),
    GetPage(
      name: Routes.browserSettings,
      page: () => const ManageListBrowserTabs(),
      binding: BrowserSettingsBinding(),
    ),
    GetPage(
      name: Routes.hiddenUsersSettings,
      page: () => const ManageListHiddenUsers(),
      binding: HiddenUsersSettingsBinding(),
    ),
  ];
}
