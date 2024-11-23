import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final Mappr _mappr;
  final Talker talker;
  SettingsRepositoryImpl({required this.talker}) : _mappr = Mappr();

  @override
  Future<DataState<Settings>> getSettings() async {
    final box = GetStorage();
    talker.logTyped(SettingsLog('Retrieving settings.'));
    var settingsString = box.read('settings');
    if (settingsString != null) {
      talker.logTyped(SettingsLog('Settings found.'));
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      talker.logTyped(SettingsLog('Settings JSON: $settingsJson'));
      Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
      return DataSuccess(settings);
    }
    talker.info('No settings found.');
    SettingsDTO settingsDTO = SettingsDTO.blank();
    Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
    return DataSuccess(settings);
  }

  @override
  Future<void> setSettings(Settings settings) async {
    final box = GetStorage();
    SettingsDTO settingsDTO = _mappr.convert<Settings, SettingsDTO>(settings);
    String settingsJson = jsonEncode(settingsDTO.toJson());
    talker.logTyped(SettingsLog('Saving settings: $settingsJson'));
    box.write('settings', settingsJson);
  }
}
