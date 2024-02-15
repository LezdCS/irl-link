import 'package:get/get.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:irllink/src/presentation/controllers/chats/twitch_chat_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

void lazyPutTwitchChat(String channel) {
  Get.lazyPut(
    () => TwitchChatController(
      homeEvents: HomeEvents(
        twitchUseCase: TwitchUseCase(
          twitchRepository: TwitchRepositoryImpl(),
        ),
        settingsUseCase: SettingsUseCase(
          settingsRepository: SettingsRepositoryImpl(),
        ),
      ),
      channel: channel,
    ),
    tag: channel,
  );
}
