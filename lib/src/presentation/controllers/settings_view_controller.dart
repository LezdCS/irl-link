import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({required this.settingsEvents});

  final SettingsEvents settingsEvents;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  late TextEditingController alternateChannelChatController;

  @override
  void onInit() {
    alternateChannelChatController = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    settingsEvents.getSettings().then((value) => {
          if (value.error == null)
            {
              settings.value = value.data!,
              alternateChannelChatController.text = settings.value.alternateChannelName!,
            }
        });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    settingsEvents.logout().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }

  void saveSettings() {
    settingsEvents.setSettings(settings: settings.value);
  }
}
