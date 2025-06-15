import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/presentation/controllers/settings/browser_settings_controller.dart';

class BrowserSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BrowserSettingsController(
        settingsService: Get.find<SettingsService>(),
      ),
    );
  }
}
