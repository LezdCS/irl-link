import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<DataState<Settings>> getSettings() async {
    final box = GetStorage();
    globals.talker?.logTyped(SettingsLog('Retrieving settings.'));
    var settingsString = box.read('settings');
    if (settingsString != null) {
      globals.talker?.logTyped(SettingsLog('Settings found.'));
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      globals.talker?.logTyped(SettingsLog('Settings JSON: $settingsJson'));
      Mappr mappr = Mappr();
      Settings settings = mappr.convert<SettingsDTO, Settings>(settingsDTO);
      return DataSuccess(settings);
    }
    globals.talker?.info('No settings found.');
    SettingsDTO settingsDTO = SettingsDTO.blank();
    Mappr mappr = Mappr();
    Settings settings = mappr.convert<SettingsDTO, Settings>(settingsDTO);
    return DataSuccess(settings);
  }

  @override
  Future<void> setSettings(Settings settings) async {
    final box = GetStorage();
    final mappr = Mappr();
    SettingsDTO settingsDTO = mappr.convert<Settings, SettingsDTO>(settings);
    String settingsJson = jsonEncode(settingsDTO.toJson());
    globals.talker?.logTyped(SettingsLog('Saving settings: $settingsJson'));
    box.write('settings', settingsJson);
  }
}
