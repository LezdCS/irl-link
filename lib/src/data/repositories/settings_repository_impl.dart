import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<DataState<Settings>> getSettings() async {
    final box = GetStorage();
    var settingsString = box.read('settings');
    if (settingsString != null) {
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settings = SettingsDTO.fromJson(settingsJson);
      return DataSuccess(settings);
    }
    return DataSuccess(Settings.defaultSettings());
  }

  @override
  Future<void> setSettings(Settings settings) async {
    final box = GetStorage();
    String settingsJson = jsonEncode(settings);
    box.write('settings', settingsJson);
  }
}
