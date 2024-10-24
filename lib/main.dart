import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/firebase_options.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/core/resources/app_translations.dart';
import 'package:irllink/src/core/resources/themes.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/services/realtime_irl_task_handler.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:irllink/src/presentation/events/login_events.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await GetStorage.init();
  await WakelockPlus.enable();
  await KickChat.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppTranslations.initLanguages();
  FlutterForegroundTask.initCommunicationPort();

  await initializeDependencies();

  final talkerService = await Get.putAsync(
    () => TalkerService().init(),
    permanent: true,
  );

  runApp(Main(
    talker: talkerService.talker,
  ));
}

Future<void> initializeDependencies() async {
  // Repositories
  SettingsRepositoryImpl settingsRepository = SettingsRepositoryImpl();
  TwitchRepositoryImpl twitchRepository = TwitchRepositoryImpl();

  // Use cases
  final settingsUseCase =
      SettingsUseCase(settingsRepository: settingsRepository);
  final twitchUseCase = TwitchUseCase(twitchRepository: twitchRepository);

  // Events
  final settingsEvents = SettingsEvents(
    settingsUseCase: settingsUseCase,
    twitchUseCase: twitchUseCase,
  );
  final loginEvents = LoginEvents(
    twitchUseCase: twitchUseCase,
  );

  final settingsService = await Get.putAsync(
    () => SettingsService(settingsEvents: settingsEvents).init(),
    permanent: true,
  );
  if (!settingsService.settings.value.generalSettings.isDarkMode) {
    Get.changeThemeMode(ThemeMode.light);
  }

  await Get.putAsync(
    () => StoreService(loginEvents: loginEvents).init(),
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

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(RealtimeIrlTaskHandler());
}

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.talker,
  });
  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const LoginView(),
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      initialBinding: LoginBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      navigatorObservers: [
        TalkerRouteObserver(talker),
      ],
      logWriterCallback: localLogWriter,
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    if (isError) {
      talker.error(text);
    } else {
      if (text.startsWith('Instance')) {
        talker.logTyped(GetxInstanceLog(text, false));
        return;
      }
      if (text.endsWith('onDelete() called') ||
          text.endsWith('deleted from memory')) {
        talker.logTyped(GetxInstanceLog(text, true));
        return;
      }
      if (text.contains('GOING TO ROUTE') || text.contains('CLOSE TO ROUTE')) {
        return;
      }
      if (text.startsWith('REMOVING ROUTE')) {
        talker.logTyped(RouterLog(text));
        return;
      }
      talker.log(text);
    }
  }
}
