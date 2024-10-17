import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingsService extends GetxService {
  SettingsService({required this.settingsEvents});
  final SettingsEvents settingsEvents;

  Rx<Settings> settings = const Settings.defaultSettings().obs;
  late Database database;

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _createTableSettingsV1(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS settings');
    batch.execute(
      '''CREATE TABLE settings
          (
          isEmotes INTEGER,
          textSize REAL,
          displayTimestamp INTEGER,
          hiddenUsersIds TEXT,
          chatEventsSettings TEXT,
          chatSettings TEXT,
          generalSettings TEXT,
          dashboardSettings TEXT,
          isObsConnected INTEGER,
          obsWebsocketUrl TEXT,
          obsWebsocketPassword TEXT,
          browserTabs TEXT,
          obsConnectionsHistory TEXT,
          streamElementsSettings TEXT,
          rtIrlPushKey TEXT,
          ttsSettings TEXT
          )
          ''',
    );
  }

  void _migrateFromGetStorage() {
    // We get the settings from GetStorage
    final settingsJson = GetStorage().read('settings');
    if (settingsJson != null) {
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      // We save the settings in the database
      settingsEvents.setSettings(settings: settingsDTO, database: database);
      // We delete the settings from GetStorage
      GetStorage().remove('settings');
    }
  }

  Future<SettingsService> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'irllink.db'),
      onConfigure: onConfigure,
      onCreate: (db, version) async {
        var batch = db.batch();
        // We create all the tables
        _createTableSettingsV1(batch);
        await batch.commit();
        _migrateFromGetStorage(); //this can be removed only if every user has updated to the version with the migration
      },
      onUpgrade: (db, oldVersion, newVersion) {
      },
      version: 1,
    );
    settings.value = await getSettings();
    return this;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult =
        await settingsEvents.getSettings(database: database);
    if (settings is DataFailed) {
      return const Settings.defaultSettings();
    }
    return settingsResult.data!;
  }

  Future<void> saveSettings() async {
    settings.refresh();
    settingsEvents.setSettings(settings: settings.value, database: database);
  }
}
