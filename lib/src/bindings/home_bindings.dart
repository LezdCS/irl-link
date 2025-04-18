import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/kick_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/streamelements_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/kick_remote_data_source.dart';
import 'package:irllink/src/data/datasources/remote/streamelements_remote_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
import 'package:irllink/src/data/repositories/kick_repository_impl.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/kick/kick_refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/post_kick_chat_nessage_usecase.dart';
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
import 'package:talker_flutter/talker_flutter.dart';

class HomeBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);
    Dio streamElementsDioClient = initDio(kStreamelementsUrlBase);
    Dio dioKickClient = initDio(null);
    Talker talker = Get.find<TalkerService>().talker;
    // Repositories
    final twitchRepository = TwitchRepositoryImpl(
      remoteDataSource: TwitchRemoteDataSourceImpl(
        dioClient: dioTwitchClient,
        talker: talker,
      ),
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talker,
      ),
      talker: talker,
    );
    final streamelementsRepository = StreamelementsRepositoryImpl(
      talker: talker,
      remoteDataSource: StreamelementsRemoteDataSourceImpl(
        dioClient: streamElementsDioClient,
        talker: talker,
      ),
      localDataSource: StreamelementsLocalDataSourceImpl(
        talker: talker,
      ),
    );
    final kickRepository = KickRepositoryImpl(
      remoteDataSource: KickRemoteDataSourceImpl(
        dioClient: dioKickClient,
        talker: talker,
      ),
      localDataSource: KickLocalDataSourceImpl(
        talker: talker,
      ),
      talker: talker,
    );

    // Services
    final settingsService = Get.find<SettingsService>();
    final talkerService = Get.find<TalkerService>();
    final watchService = Get.find<WatchService>();

    // Use cases
    final refreshTwitchAccessTokenUseCase =
        RefreshTwitchTokenUseCase(twitchRepository);
    final refreshKickAccessTokenUseCase =
        KickRefreshTokenUseCase(kickRepository);
    final postKickChatMessageUseCase =
        PostKickChatMessageUseCase(kickRepository);
    final getStreamInfoUseCase = GetStreamInfoUseCase(twitchRepository);
    final setChatSettingsUseCase = SetChatSettingsUseCase(twitchRepository);
    final setStreamTitleUseCase = SetStreamTitleUseCase(twitchRepository);
    final getOverlaysUseCase = StreamElementsGetOverlaysUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final getMeUseCase = StreamElementsGetMeUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final getLocalCredentialsUseCase = StreamElementsGetLocalCredentialsUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final refreshTokenUseCase = StreamElementsRefreshTokenUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final replayActivityUseCase = StreamElementsReplayActivityUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final nextSongUseCase = StreamElementsNextSongUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final removeSongUseCase = StreamElementsRemoveSongUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final resetQueueUseCase = StreamElementsResetQueueUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final updatePlayerStateUseCase = StreamElementsUpdatePlayerStateUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final getLastActivitiesUseCase = StreamElementsGetLastActivitiesUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final getSongPlayingUseCase = StreamElementsGetSongPlayingUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final getSongQueueUseCase = StreamElementsGetSongQueueUseCase(
      streamelementsRepository: streamelementsRepository,
    );

    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        refreshAccessTokenUseCase: refreshTwitchAccessTokenUseCase,
        refreshKickAccessTokenUseCase: refreshKickAccessTokenUseCase,
        settingsService: settingsService,
        talkerService: talkerService,
        postKickChatMessageUseCase: postKickChatMessageUseCase,
      ),
    );

    Get.lazyPut<ObsTabViewController>(
      () => ObsTabViewController(
        watchService: watchService,
        talkerService: talkerService,
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
        watchService: watchService,
        settingsService: settingsService,
        talkerService: talkerService,
      ),
      fenix: true,
    );

    Get.lazyPut<TwitchTabViewController>(
      () => TwitchTabViewController(
        getStreamInfoUseCase: getStreamInfoUseCase,
        setChatSettingsUseCase: setChatSettingsUseCase,
        setStreamTitleUseCase: setStreamTitleUseCase,
        homeViewController: Get.find<HomeViewController>(),
        watchService: watchService,
      ),
    );

    Get.lazyPut<DashboardController>(
      () => DashboardController(
        homeViewController: Get.find<HomeViewController>(),
        settingsService: settingsService,
      ),
      fenix: true,
    );
    Get.lazyPut<RealtimeIrlViewController>(
      () => RealtimeIrlViewController(),
      fenix: true,
    );
  }
}
