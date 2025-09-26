import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/kick_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/kick_remote_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
import 'package:irllink/src/data/repositories/kick_repository_impl.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/kick/login_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/logout_usecase.dart';
import 'package:irllink/src/domain/usecases/tts/get_tts_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/tts/set_tts_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);
    Dio kickDioClient = initDio(kKickApiUrlBase);
    TalkerService talkerService = Get.find<TalkerService>();
    // Repositories
    final twitchRepository = TwitchRepositoryImpl(
      remoteDataSource: TwitchRemoteDataSourceImpl(
        dioClient: dioTwitchClient,
        talker: talkerService.talker,
      ),
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );

    final kickRepository = KickRepositoryImpl(
      remoteDataSource: KickRemoteDataSourceImpl(
        dioClient: kickDioClient,
        talker: talkerService.talker,
      ),
      localDataSource: KickLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );

    // Use cases
    GetTwitchUsersUseCase getTwitchUsersUseCase =
        GetTwitchUsersUseCase(twitchRepository);
    LogoutUseCase logoutUseCase = LogoutUseCase(twitchRepository);

    LogoutKickUseCase logoutKickUseCase = LogoutKickUseCase(kickRepository);

    final loginUseCase = LoginUseCase(twitchRepository);
    final loginKickUseCase = LoginKickUseCase(kickRepository);

    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );

    final getTtsSettingsUsecase = GetTtsSettingsUsecase(
      settingsRepository: settingsRepository,
    );

    final setTtsSettingsUsecase = SetTtsSettingsUsecase(
      settingsRepository: settingsRepository,
    );
    Get.lazyPut<SettingsViewController>(
      () => SettingsViewController(
        getTwitchUsersUseCase: getTwitchUsersUseCase,
        logoutUseCase: logoutUseCase,
        loginUseCase: loginUseCase,
        homeViewController: Get.find<HomeViewController>(),
        settingsService: Get.find<SettingsService>(),
        storeService: Get.find<StoreService>(),
        ttsService: Get.find<TtsService>(),
        logoutKickUseCase: logoutKickUseCase,
        loginKickUseCase: loginKickUseCase,
        getTtsSettingsUsecase: getTtsSettingsUsecase,
        setTtsSettingsUsecase: setTtsSettingsUsecase,
      ),
    );
  }
}
