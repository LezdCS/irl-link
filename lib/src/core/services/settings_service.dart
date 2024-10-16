import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingsService extends GetxService {
  SettingsService({required this.settingsEvents});
  final SettingsEvents settingsEvents;

  Rx<Settings> settings = const Settings.defaultSettings().obs;
  late Database database;
  
  Future<SettingsService> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'settings.db'),
      onCreate: (db, version) {
        return db.execute(
          // todo: create table settings
          'CREATE TABLE settings(id INTEGER PRIMARY KEY, ... TEXT, ... INTEGER)',
        );
        // todo: if the user was on a version of the app using get storage, we need to transfer his settings to the database

      },
      onUpgrade: (db, oldVersion, newVersion) {
      },
      version: 1,
    );
    settings.value = await getSettings();
    return this;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await settingsEvents.getSettings(database: database);
    if (settings is DataFailed) {
      return const Settings.defaultSettings();
    }
    settings.value = settingsResult.data!;
    return settings.value;
  }

  Future<void> saveSettings() async {
    settings.refresh();
    settingsEvents.setSettings(settings: settings.value, database: database);
  }
}
