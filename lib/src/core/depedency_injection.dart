import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/services/deeplinks_service.dart';
import 'package:irllink/src/core/services/notification_service.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings/get_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/set_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';

Future<void> initializeDependencies() async {
  TalkerService talkerService = await Get.putAsync(
    () => TalkerService().init(),
    permanent: true,
  );

  await Get.putAsync(
    () => DeeplinksService(
      appLinks: AppLinks(),
      talker: talkerService.talker,
    ).init(),
    permanent: true,
  );

  await Get.putAsync(
    () => NotificationService().init(),
    permanent: true,
  );

  Dio dioTwitchClient = initDio(kTwitchApiUrlBase);

  // Repositories
  final settingsRepository = SettingsRepositoryImpl(
    talker: talkerService.talker,
    localDataSource: SettingsLocalDataSourceImpl(
      talker: talkerService.talker,
      storage: GetStorage(),
    ),
  );
  final twitchRepository = TwitchRepositoryImpl(
    dioClient: dioTwitchClient,
    localDataSource: TwitchLocalDataSourceImpl(
      talker: talkerService.talker,
      storage: GetStorage(),
    ),
    talker: talkerService.talker,
  );

  // Use cases
  final getSettingsUseCase = GetSettingsUseCase(settingsRepository);
  final setSettingsUseCase = SetSettingsUseCase(settingsRepository);
  final getTwitchLocalUseCase = GetTwitchLocalUseCase(twitchRepository);

  final settingsService = await Get.putAsync(
    () => SettingsService(
      getSettingsUseCase: getSettingsUseCase,
      setSettingsUseCase: setSettingsUseCase,
    ).init(),
    permanent: true,
  );
  if (!settingsService.settings.value.generalSettings.isDarkMode) {
    Get.changeThemeMode(ThemeMode.light);
  }

  await Get.putAsync(
    () => StoreService(
      getTwitchLocalUseCase: getTwitchLocalUseCase,
      talker: Get.find<TalkerService>().talker,
    ).init(),
    permanent: true,
  );

  final ttsService = await Get.putAsync(
    () => TtsService().init(),
    permanent: true,
  );
  await ttsService.initTts(settingsService.settings.value);

  await Get.putAsync(() => WatchService().init(), permanent: true);

  await Get.putAsync(() => AppInfoService().init(), permanent: true);
}
