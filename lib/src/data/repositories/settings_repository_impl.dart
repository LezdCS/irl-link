import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:sqflite/sqflite.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<DataState<Settings>> getSettings(Database database) async {
    globals.talker?.logTyped(SettingsLog('Retrieving settings.'));
    List<Map<String, dynamic>> maps = await database.query('settings');
    if (maps.isNotEmpty) {
      globals.talker?.logTyped(SettingsLog('Settings found.'));
      SettingsDTO settings = SettingsDTO.fromJson(maps.first);
      return DataSuccess(settings);
    } else {
      globals.talker?.info('No settings found.');
      return DataFailed('No settings found.');
    }
  }

  @override
  Future<void> setSettings(Settings settings, Database database) async {
    await database.update(
      'settings',
      settings.toJson(),
    );
    globals.talker
        ?.logTyped(SettingsLog('Saving settings: ${settings.toJson()}'));
  }
}
