import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsService extends GetxService {
SettingsService({required this.settingsEvents});
  final SettingsEvents settingsEvents;

  Settings settings = const Settings.defaultSettings();

  Future<SettingsService> init() async {
    settings = await getSettings();
    return this;
  }

  Future<Settings> updateSettings() async {
    settings = await getSettings();
    return settings;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await settingsEvents.getSettings();
    if (settings is DataFailed) {
      return const Settings.defaultSettings();
    }
    settings = settingsResult.data!;
    return settings;
  }

  Future<void> saveSettings() async {
    settingsEvents.setSettings(settings: settings);
  }
}