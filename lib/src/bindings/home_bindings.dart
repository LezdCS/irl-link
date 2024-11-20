import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_last_activities_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_me_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_overlays_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_song_playing_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_song_queue_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/next_song_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/remove_song_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/replay_activity_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/reset_queue_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/update_player_state_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_stream_info_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_chat_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_stream_title_usecase.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';

class HomeBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    // Repositories
    final twitchRepository = TwitchRepositoryImpl();
    final streamelementsRepository = StreamelementsRepositoryImpl();
    // Use cases
    final refreshTwitchAccessTokenUseCase =
        RefreshTwitchTokenUseCase(twitchRepository);
    final getStreamInfoUseCase = GetStreamInfoUseCase(twitchRepository);
    final setChatSettingsUseCase = SetChatSettingsUseCase(twitchRepository);
    final setStreamTitleUseCase = SetStreamTitleUseCase(twitchRepository);
    final getOverlaysUseCase = StreamElementsGetOverlaysUseCase(
        streamelementsRepository: streamelementsRepository);
    final getMeUseCase = StreamElementsGetMeUseCase(
        streamelementsRepository: streamelementsRepository);
    final getLocalCredentialsUseCase = StreamElementsGetLocalCredentialsUseCase(
        streamelementsRepository: streamelementsRepository);
    final refreshTokenUseCase = StreamElementsRefreshTokenUseCase(
        streamelementsRepository: streamelementsRepository);
    final replayActivityUseCase = StreamElementsReplayActivityUseCase(
        streamelementsRepository: streamelementsRepository);
    final nextSongUseCase = StreamElementsNextSongUseCase(
        streamelementsRepository: streamelementsRepository);
    final removeSongUseCase = StreamElementsRemoveSongUseCase(
        streamelementsRepository: streamelementsRepository);
    final resetQueueUseCase = StreamElementsResetQueueUseCase(
        streamelementsRepository: streamelementsRepository);
    final updatePlayerStateUseCase = StreamElementsUpdatePlayerStateUseCase(
        streamelementsRepository: streamelementsRepository);
    final getLastActivitiesUseCase = StreamElementsGetLastActivitiesUseCase(
        streamelementsRepository: streamelementsRepository);
    final getSongPlayingUseCase = StreamElementsGetSongPlayingUseCase(
        streamelementsRepository: streamelementsRepository);
    final getSongQueueUseCase = StreamElementsGetSongQueueUseCase(
        streamelementsRepository: streamelementsRepository);

    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        refreshAccessTokenUseCase: refreshTwitchAccessTokenUseCase,
      ),
    );

    Get.lazyPut<ObsTabViewController>(
      () => ObsTabViewController(
        watchService: Get.find<WatchService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<StreamelementsViewController>(
      () => StreamelementsViewController(
        getOverlaysUseCase: getOverlaysUseCase,
        getMeUseCase: getMeUseCase,
        getLocalCredentialsUseCase: getLocalCredentialsUseCase,
        refreshTokenUseCase: refreshTokenUseCase,
        replayActivityUseCase: replayActivityUseCase,
        nextSongUseCase: nextSongUseCase,
        removeSongUseCase: removeSongUseCase,
        resetQueueUseCase: resetQueueUseCase,
        updatePlayerStateUseCase: updatePlayerStateUseCase,
        getLastActivitiesUseCase: getLastActivitiesUseCase,
        getSongPlayingUseCase: getSongPlayingUseCase,
        getSongQueueUseCase: getSongQueueUseCase,
        homeViewController: Get.find<HomeViewController>(),
        watchService: Get.find<WatchService>(),
        settingsService: Get.find<SettingsService>(),
        talkerService: Get.find<TalkerService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<TwitchTabViewController>(
      () => TwitchTabViewController(
        getStreamInfoUseCase: getStreamInfoUseCase,
        setChatSettingsUseCase: setChatSettingsUseCase,
        setStreamTitleUseCase: setStreamTitleUseCase,
        homeViewController: Get.find<HomeViewController>(),
        watchService: Get.find<WatchService>(),
      ),
    );

    Get.lazyPut<DashboardController>(
        () => DashboardController(
              homeViewController: Get.find<HomeViewController>(),
              settingsService: Get.find<SettingsService>(),
            ),
        fenix: true);
    Get.lazyPut<RealtimeIrlViewController>(
      () => RealtimeIrlViewController(),
      fenix: true,
    );
  }
}
