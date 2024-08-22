import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<DataState<Settings>> getSettings() async {
    final box = GetStorage();
    var settingsString = box.read('settings');
    globals.talker?.info('Retrieving settings...');
    if (settingsString != null) {
      globals.talker?.info('Settings found.');
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settings = SettingsDTO.fromJson(settingsJson);
      globals.talker?.info('Settings: $settingsJson');
      return DataSuccess(settings);
    }
    globals.talker?.info('No settings found.');
    return DataSuccess(const Settings.defaultSettings());
  }

  @override
  Future<void> setSettings(Settings settings) async {
    final box = GetStorage();
    String settingsJson = jsonEncode(settings.toJson());
    globals.talker?.info('Saving settings: $settingsJson');
    box.write('settings', settingsJson);
  }
}
