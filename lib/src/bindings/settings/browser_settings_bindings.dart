import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings/add_browser_tab_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/edit_browser_tab_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_browser_tabs_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_browser_tab_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/browser_settings_controller.dart';

class BrowserSettingsBinding extends Bindings {
  @override
  void dependencies() {
    final talkerService = Get.find<TalkerService>();

    final settingsRepository = SettingsRepositoryImpl(
      talker: talkerService.talker,
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
    );

    final addBrowserTabUsecase = AddBrowserTabUsecase(settingsRepository);
    final editBrowserTabUsecase = EditBrowserTabUsecase(settingsRepository);
    final removeBrowserTabUsecase = RemoveBrowserTabUsecase(settingsRepository);
    final getBrowserTabsUsecase = GetBrowserTabsUsecase(settingsRepository);

    Get.lazyPut(
      () => BrowserSettingsController(
        talkerService: talkerService,
        addBrowserTabUsecase: addBrowserTabUsecase,
        editBrowserTabUsecase: editBrowserTabUsecase,
        removeBrowserTabUsecase: removeBrowserTabUsecase,
        getBrowserTabsUsecase: getBrowserTabsUsecase,
      ),
    );
  }
}
