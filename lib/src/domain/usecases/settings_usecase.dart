import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:sqflite/sqflite.dart';

class SettingsUseCase {
  final SettingsRepository settingsRepository;
  SettingsUseCase({required this.settingsRepository});

  Future<DataState<Settings>> getSettings({required Database database}) {
    return settingsRepository.getSettings(database);
  }

  Future<void> setSettings({required Settings settings, required Database database}) {
    return settingsRepository.setSettings(settings, database);
  }
}
