import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';

class ObsSettingsController extends GetxController {
  final SettingsService settingsService = Get.find<SettingsService>();

  RxBool obsWebsocketPasswordShow = false.obs;
  RxBool obsWebsocketUrlShow = false.obs;
  late TextEditingController obsWebsocketUrlFieldController;
  late TextEditingController obsWebsocketPasswordFieldController;

  @override
  void onInit() {
    super.onInit();
    Settings settings = settingsService.settings.value;

    obsWebsocketUrlFieldController =
        TextEditingController(text: settings.obsWebsocketUrl);
    obsWebsocketPasswordFieldController =
        TextEditingController(text: settings.obsWebsocketPassword);
  }

  @override
  void onClose() {
    obsWebsocketUrlFieldController.dispose();
    obsWebsocketPasswordFieldController.dispose();
    super.onClose();
  }
}
