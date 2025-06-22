import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart'
    show TalkerService;
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/domain/usecases/obs/get_obs_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/obs/toggle_obs_usecase.dart';
import 'package:irllink/src/domain/usecases/obs/update_obs_password_usecase.dart';
import 'package:irllink/src/domain/usecases/obs/update_obs_url_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/obs_settings_controller.dart';

class ObsSettingsBindings extends Bindings {
  @override
  void dependencies() {
    final talker = Get.find<TalkerService>().talker;
    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talker,
      ),
      talker: talker,
    );

    final getObsCredentialsUsecase = GetObsCredentialsUsecase(
      settingsRepository: settingsRepository,
    );
    final toggleObsUsecase = ToggleObsUsecase(
      settingsRepository: settingsRepository,
    );
    final updateObsPasswordUsecase = UpdateObsPasswordUsecase(
      settingsRepository: settingsRepository,
    );
    final updateObsUrlUsecase = UpdateObsUrlUsecase(
      settingsRepository: settingsRepository,
    );

    Get.lazyPut(
      () => ObsSettingsController(
        getObsCredentialsUsecase: getObsCredentialsUsecase,
        toggleObsUsecase: toggleObsUsecase,
        updateObsPasswordUsecase: updateObsPasswordUsecase,
        updateObsUrlUsecase: updateObsUrlUsecase,
      ),
    );
  }
}
