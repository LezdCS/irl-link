import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:sqflite/sqflite.dart';

abstract class SettingsRepository {
  Future<DataState<Settings>> getSettings(
    Database database,
  );

  Future<void> setSettings(
    Settings settings,
    Database database,
  );
}
