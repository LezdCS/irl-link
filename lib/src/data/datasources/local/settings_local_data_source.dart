import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsDTO?> getSettings();
  Future<void> setSettings(SettingsDTO settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Talker talker;
  final GetStorage _storage;

  SettingsLocalDataSourceImpl({
    required this.talker,
    GetStorage? storage,
  }) : _storage = storage ?? GetStorage();

  @override
  Future<SettingsDTO?> getSettings() async {
    talker.logCustom(SettingsLog('Retrieving settings from local storage.'));
    var settingsString = _storage.read('settings');
    if (settingsString != null) {
      talker.logCustom(SettingsLog('Settings found in local storage.'));
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      talker.logCustom(SettingsLog('Settings JSON: $settingsJson'));
      return settingsDTO;
    }
    talker.info('No settings found in local storage.');
    return null;
  }

  @override
  Future<void> setSettings(SettingsDTO settings) async {
    String settingsJson = jsonEncode(settings.toJson());
    talker.logCustom(
      SettingsLog('Saving settings to local storage: $settingsJson'),
    );
    await _storage.write('settings', settingsJson);
  }
}
