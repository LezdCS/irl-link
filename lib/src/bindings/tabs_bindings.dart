import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/kick_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/rtmp_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/streamelements_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/kick_remote_data_source.dart';
import 'package:irllink/src/data/datasources/remote/streamelements_remote_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
import 'package:irllink/src/data/repositories/kick_repository_impl.dart';
import 'package:irllink/src/data/repositories/rtmp_repository_impl.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_categories_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_channels_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/get_kick_local_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/patch_kick_channel_usecase.dart'
    show PatchKickChannelUseCase;
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_browser_tabs_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_stream_info_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_chat_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/set_stream_title_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/rtmp_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TabsBindings extends Bindings {
  @override
  void dependencies() {
    TalkerService talkerService = Get.find<TalkerService>();
    Talker talker = talkerService.talker;
    final rtmpRepository = RtmpRepositoryImpl(
      talker: talker,
      localDataSource: RtmpLocalDataSourceImpl(
        talker: talker,
      ),
    );
    GetRtmpListUseCase getRtmpListUseCase = GetRtmpListUseCase(rtmpRepository);

    Dio dioKickClient = initDio('https://api.kick.com');
    final kickRepository = KickRepositoryImpl(
      talker: talker,
      localDataSource: KickLocalDataSourceImpl(
        talker: talker,
      ),
      remoteDataSource: KickRemoteDataSourceImpl(
        talker: talker,
        dioClient: dioKickClient,
      ),
    );
    GetKickLocalUseCase getKickLocalUseCase =
        GetKickLocalUseCase(kickRepository);

    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);

    TwitchRepositoryImpl twitchRepository = TwitchRepositoryImpl(
      remoteDataSource: TwitchRemoteDataSourceImpl(
        dioClient: dioTwitchClient,
        talker: talker,
      ),
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talker,
      ),
      talker: talker,
    );

    GetTwitchLocalUseCase getTwitchLocalUseCase =
        GetTwitchLocalUseCase(twitchRepository);

    Dio streamElementsDioClient = initDio(kStreamelementsUrlBase);
    final streamelementsRepository = StreamelementsRepositoryImpl(
      talker: talker,
      localDataSource: StreamelementsLocalDataSourceImpl(
        talker: talker,
      ),
      remoteDataSource: StreamelementsRemoteDataSourceImpl(
        dioClient: streamElementsDioClient,
        talker: talker,
      ),
    );
    final getLocalCredentialsUseCase = StreamElementsGetLocalCredentialsUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    final settingsRepository = SettingsRepositoryImpl(
      talker: talker,
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talker,
      ),
    );
    final getBrowserTabsUseCase = GetBrowserTabsUsecase(settingsRepository);
    Get.lazyPut<TabsController>(
      () => TabsController(
        settingsService: Get.find<SettingsService>(),
        homeViewController: Get.find<HomeViewController>(),
        talkerService: talkerService,
        getRtmpListUseCase: getRtmpListUseCase,
        getKickLocalUseCase: getKickLocalUseCase,
        getTwitchLocalUseCase: getTwitchLocalUseCase,
        getLocalCredentialsUseCase: getLocalCredentialsUseCase,
        getBrowserTabsUseCase: getBrowserTabsUseCase,
      ),
    );

    final getKickCategoriesUseCase = GetKickCategoriesUseCase(kickRepository);
    final patchKickChannelUseCase = PatchKickChannelUseCase(kickRepository);
    final getKickChannelsUseCase = GetKickChannelsUseCase(kickRepository);
    Get.lazyPut<KickTabViewController>(
      () => KickTabViewController(
        getKickCategoriesUseCase: getKickCategoriesUseCase,
        patchKickChannelUseCase: patchKickChannelUseCase,
        getKickChannelsUseCase: getKickChannelsUseCase,
      ),
      fenix: true,
    );

    Get.lazyPut<RealtimeIrlViewController>(
      () => RealtimeIrlViewController(),
      fenix: true,
    );

    final getStreamInfoUseCase = GetStreamInfoUseCase(twitchRepository);
    final setChatSettingsUseCase = SetChatSettingsUseCase(twitchRepository);
    final setStreamTitleUseCase = SetStreamTitleUseCase(twitchRepository);
    final watchService = Get.find<WatchService>();
    Get.lazyPut<TwitchTabViewController>(
      () => TwitchTabViewController(
        getStreamInfoUseCase: getStreamInfoUseCase,
        setChatSettingsUseCase: setChatSettingsUseCase,
        setStreamTitleUseCase: setStreamTitleUseCase,
        watchService: watchService,
      ),
      fenix: true,
    );

    Get.lazyPut<ObsTabViewController>(
      () => ObsTabViewController(
        watchService: watchService,
        talkerService: talkerService,
      ),
      fenix: true,
    );

    Get.lazyPut<RtmpTabViewController>(
      () => RtmpTabViewController(
        settingsService: Get.find<SettingsService>(),
        talkerService: talkerService,
        getRtmpListUseCase: getRtmpListUseCase,
      ),
      fenix: true,
    );
  }
}
