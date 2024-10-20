import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsService extends GetxService {
  SettingsService({required this.settingsEvents});
  final SettingsEvents settingsEvents;

  late Rx<Settings> settings;

  Future<SettingsService> init() async {
    settings.value = await getSettings();
    return this;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await settingsEvents.getSettings();
    if (settingsResult is DataFailed) {
      // settingsResult is never returned as DataFailed, we always return DataSuccess in the implementation
      Exception(settingsResult.error);
    }
    return settingsResult.data!;
  }

  Future<void> saveSettings() async {
    settings.refresh();
    settingsEvents.setSettings(settings: settings.value);
  }
}
