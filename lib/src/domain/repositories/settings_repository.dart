import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<DataState<Settings>> getSettings();
  Future<void> setSettings(
    Settings settings,
  );
}
