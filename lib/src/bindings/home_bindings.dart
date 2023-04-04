import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        homeEvents: HomeEvents(
          twitchUseCase: TwitchUseCase(
            twitchRepository: TwitchRepositoryImpl(),
          ),
          settingsUseCase: SettingsUseCase(
            settingsRepository: SettingsRepositoryImpl(),
          ),
        ),
      ),
    );
    Get.find<HomeViewController>();

    Get.lazyPut<ObsTabViewController>(() => ObsTabViewController(
          homeEvents: HomeEvents(
            twitchUseCase: TwitchUseCase(
              twitchRepository: TwitchRepositoryImpl(),
            ),
            settingsUseCase: SettingsUseCase(
              settingsRepository: SettingsRepositoryImpl(),
            ),
          ),
        ));
    Get.find<ObsTabViewController>();

    // Get.lazyPut<StreamelementsViewController>(
    //   () => StreamelementsViewController(
    //     streamelementsEvents: StreamelementsEvents(
    //       streamelementsUseCase: StreamelementsUseCase(
    //         streamelementsRepository: StreamelementsRepositoryImpl(),
    //       ),
    //     ),
    //   ),
    // );
    // Get.find<StreamelementsViewController>();

    Get.lazyPut<ChatViewController>(
      () => ChatViewController(
        homeEvents: HomeEvents(
          twitchUseCase: TwitchUseCase(
            twitchRepository: TwitchRepositoryImpl(),
          ),
          settingsUseCase: SettingsUseCase(
            settingsRepository: SettingsRepositoryImpl(),
          ),
        ),
      ),
    );
    Get.find<ChatViewController>();

    Get.lazyPut<TwitchTabViewController>(() => TwitchTabViewController(
          homeEvents: HomeEvents(
            twitchUseCase: TwitchUseCase(
              twitchRepository: TwitchRepositoryImpl(),
            ),
            settingsUseCase: SettingsUseCase(
              settingsRepository: SettingsRepositoryImpl(),
            ),
          ),
        ));
    Get.find<TwitchTabViewController>();
  }
}
