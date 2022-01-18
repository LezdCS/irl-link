import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository settingsRepository;
  SettingsUseCase({required this.settingsRepository});

  Future<DataState<Settings>> getSettings() {
    return settingsRepository.getSettings();
  }

  Future<void> setSettings({required Settings settings}) {
    return settingsRepository.setSettings(settings);
  }
}
