import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/presentation/views/loginView.dart';

class SettingsViewController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }

  void logout() {
    box.remove('twitchToken');
    Get.offAll(LoginView());
  }
}
