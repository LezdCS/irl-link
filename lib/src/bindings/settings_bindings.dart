import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/streamelements_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/streamelements_remote_data_source.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);
    Dio streamElementsDioClient = initDio(kStreamelementsUrlBase);
    Talker talker = Get.find<TalkerService>().talker;
    // Repositories
    final twitchRepository = TwitchRepositoryImpl(
      dioClient: dioTwitchClient,
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talker,
        storage: GetStorage(),
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
        storage: GetStorage(),
      ),
    );

    // Use cases
    GetTwitchUsersUseCase getTwitchUsersUseCase =
        GetTwitchUsersUseCase(twitchRepository);
    LogoutUseCase logoutUseCase = LogoutUseCase(twitchRepository);
    StreamElementsLoginUseCase streamElementsLoginUseCase =
        StreamElementsLoginUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    StreamElementsDisconnectUseCase streamElementsDisconnectUseCase =
        StreamElementsDisconnectUseCase(
      streamelementsRepository: streamelementsRepository,
    );

    Get.lazyPut<SettingsViewController>(
      () => SettingsViewController(
        getTwitchUsersUseCase: getTwitchUsersUseCase,
        logoutUseCase: logoutUseCase,
        streamElementsLoginUseCase: streamElementsLoginUseCase,
        streamElementsDisconnectUseCase: streamElementsDisconnectUseCase,
        homeViewController: Get.find<HomeViewController>(),
        settingsService: Get.find<SettingsService>(),
        storeService: Get.find<StoreService>(),
        ttsService: Get.find<TtsService>(),
      ),
    );
  }
}
