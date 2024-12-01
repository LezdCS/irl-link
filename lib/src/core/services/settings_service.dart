import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/usecases/settings/get_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/set_settings_usecase.dart';

class SettingsService extends GetxService {
  SettingsService({
    required this.getSettingsUseCase,
    required this.setSettingsUseCase,
  });

  final GetSettingsUseCase getSettingsUseCase;
  final SetSettingsUseCase setSettingsUseCase;

  late Rx<Settings> settings;

  Future<SettingsService> init() async {
    await getSettings();
    return this;
  }

  Future<void> getSettings() async {
    final settingsResult = await getSettingsUseCase();

    settingsResult.fold(
      (l) => debugPrint(l.message),
      (r) => settings = r.obs,
    );
  }

  Future<void> saveSettings() async {
    settings.refresh();
    final setResult = await setSettingsUseCase(
      params: settings.value,
    );
    setResult.fold(
      (l) => debugPrint(l.message),
      (r) => {},
    );
  }
}
