import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings/obs_settings_controller.dart';

class ObsSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ObsSettingsController());
  }
}
