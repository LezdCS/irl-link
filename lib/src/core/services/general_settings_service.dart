import 'dart:async';

import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/usecases/settings/get_general_settings.dart';
import 'package:irllink/src/domain/usecases/settings/set_general_settings.dart';

class GeneralSettingsService extends GetxService {
  GeneralSettingsService({
    required this.getGeneralSettingsUseCase,
    required this.setGeneralSettingsUseCase,
  });

  final GetGeneralSettingsUseCase getGeneralSettingsUseCase;
  final SetGeneralSettingsUseCase setGeneralSettingsUseCase;

  // Reactive general settings that all controllers can listen to
  final Rxn<GeneralSettings> _generalSettings = Rxn<GeneralSettings>();

  // Getter to expose the reactive settings
  Rxn<GeneralSettings> get generalSettings => _generalSettings;

  // Stream controller for broadcasting settings changes
  final _settingsStreamController =
      StreamController<GeneralSettings>.broadcast();

  // Stream that other controllers can listen to
  Stream<GeneralSettings> get settingsStream =>
      _settingsStreamController.stream;

  Future<GeneralSettingsService> init() async {
    await _loadGeneralSettings();
    return this;
  }

  /// Load general settings from the database
  Future<void> _loadGeneralSettings() async {
    final result = await getGeneralSettingsUseCase();
    result.fold(
      (l) => {},
      (r) {
        _generalSettings.value = r;
        _settingsStreamController.add(r);
      },
    );
  }

  /// Update general settings and notify all listeners
  Future<void> updateGeneralSettings(GeneralSettings settings) async {
    final result = await setGeneralSettingsUseCase(params: settings);
    result.fold(
      (l) => {},
      (r) {
        _generalSettings.value = settings;
        _settingsStreamController.add(settings);
      },
    );
  }

  /// Refresh general settings from database and notify listeners
  Future<void> refreshGeneralSettings() async {
    await _loadGeneralSettings();
  }

  /// Get current general settings synchronously
  GeneralSettings? get currentSettings => _generalSettings.value;

  @override
  void onClose() {
    _settingsStreamController.close();
    super.onClose();
  }
}
