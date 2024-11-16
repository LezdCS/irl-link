import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/usecases/settings/get_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/set_settings_usecase.dart';

class SettingsService extends GetxService {
  SettingsService(
      {required this.getSettingsUseCase, required this.setSettingsUseCase});

  final GetSettingsUseCase getSettingsUseCase;
  final SetSettingsUseCase setSettingsUseCase;

  late Rx<Settings> settings;

  Future<SettingsService> init() async {
    settings = (await getSettings()).obs;
    return this;
  }

  Future<Settings> getSettings() async {
    DataState<Settings> settingsResult = await getSettingsUseCase();
    if (settingsResult is DataFailed) {
      // settingsResult is never returned as DataFailed, we always return DataSuccess in the implementation
      Exception(settingsResult.error);
    }
    return settingsResult.data!;
  }

  Future<void> saveSettings() async {
    settings.refresh();
    await setSettingsUseCase(
      params: settings.value,
    );
  }
}
