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

  Future<Settings> updateSettings() async {
    settings.value = await getSettings();
    return settings.value;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await settingsEvents.getSettings();
    if (settings is DataFailed) {
      return const Settings.defaultSettings();
    }
    settings.value = settingsResult.data!;
    return settings.value;
  }

  Future<void> saveSettings() async {
    settingsEvents.setSettings(settings: settings.value);
  }
}