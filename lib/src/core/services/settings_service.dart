import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsService extends GetxService {
  SettingsService({required this.settingsEvents});
  final SettingsEvents settingsEvents;

  Rx<Settings> settings = const Settings.defaultSettings().obs;

  Future<SettingsService> init() async {
    settings.value = await getSettings();
    return this;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await settingsEvents.getSettings();
    if (settings is DataFailed) {
      return const Settings.defaultSettings();
    }
    settings.value = settingsResult.data!;

    // DARK MODE
    if (!settings.value.generalSettings!.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
    }

    return settings.value;
  }

  Future<void> saveSettings() async {
    settings.refresh();
    settingsEvents.setSettings(settings: settings.value);
  }
}
