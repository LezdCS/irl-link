import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    // Repositories
    final twitchRepository = TwitchRepositoryImpl();
    final streamelementsRepository = StreamelementsRepositoryImpl();

    // Use cases
    GetTwitchUsersUseCase getTwitchUsersUseCase =
        GetTwitchUsersUseCase(twitchRepository);
    LogoutUseCase logoutUseCase = LogoutUseCase(twitchRepository);
    StreamElementsLoginUseCase streamElementsLoginUseCase =
        StreamElementsLoginUseCase(
            streamelementsRepository: streamelementsRepository);
    StreamElementsDisconnectUseCase streamElementsDisconnectUseCase =
        StreamElementsDisconnectUseCase(
            streamelementsRepository: streamelementsRepository);

    Get.lazyPut<SettingsViewController>(
      () => SettingsViewController(
        getTwitchUsersUseCase: getTwitchUsersUseCase,
        logoutUseCase: logoutUseCase,
        streamElementsLoginUseCase: streamElementsLoginUseCase,
        streamElementsDisconnectUseCase: streamElementsDisconnectUseCase,
      ),
    );
  }
}
