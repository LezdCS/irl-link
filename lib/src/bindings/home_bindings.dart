import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';

class HomeBindings extends Bindings {
  @override
  Future<void> dependencies() async {

    final twitchRepository = TwitchRepositoryImpl();
    final streamelementsRepository = StreamelementsRepositoryImpl();

    // Use cases
    final twitchUseCase = TwitchUseCase(twitchRepository: twitchRepository);
    final streamelementsUseCase = StreamelementsUseCase(streamelementsRepository: streamelementsRepository);

    // HomeEvents instance reused across controllers
    final homeEvents = HomeEvents(
      twitchUseCase: twitchUseCase,
      streamelementsUseCase: streamelementsUseCase,
    );

    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        homeEvents: homeEvents,
      ),
    );

    Get.lazyPut<ObsTabViewController>(
      () => ObsTabViewController(
        homeEvents: homeEvents
      ),
      fenix: true,
    );

    Get.lazyPut<StreamelementsViewController>(
      () => StreamelementsViewController(
        streamelementsEvents: StreamelementsEvents(
          streamelementsUseCase: streamelementsUseCase,
        ),
      ),
      fenix: true,
    );

    Get.lazyPut<TwitchTabViewController>(
      () => TwitchTabViewController(
        homeEvents: homeEvents
      ),
    );

    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<RealtimeIrlViewController>(
      () => RealtimeIrlViewController(),
      fenix: true,
    );
  }
}
