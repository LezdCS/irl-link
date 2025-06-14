import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings/get_hidden_users_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_hidden_user_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/hidden_users_settings_controller.dart';

class HiddenUsersSettingsBinding extends Bindings {
  @override
  void dependencies() {
    final talker = Get.find<TalkerService>().talker;
    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talker,
      ),
      talker: talker,
    );

    final getHiddenUsersUseCase = GetHiddenUsersUseCase(
      settingsRepository: settingsRepository,
    );
    final removeHiddenUserUseCase = RemoveHiddenUserUseCase(
      settingsRepository: settingsRepository,
    );

    Get.lazyPut(
      () => HiddenUsersSettingsController(
        getHiddenUsersUseCase: getHiddenUsersUseCase,
        removeHiddenUserUseCase: removeHiddenUserUseCase,
      ),
    );
  }
}
