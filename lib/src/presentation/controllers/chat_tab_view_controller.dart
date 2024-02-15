import 'package:get/get.dart';
import 'package:irllink/src/core/utils/lazy_put_kick_chat.dart';
import 'package:irllink/src/core/utils/lazy_put_twitch_chat.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

enum ChatProvider {
  twitch,
  kick,
}

class ChatTabViewController extends GetxController {
  ChatTabViewController({
    required this.homeEvents,
  });

  final HomeEvents homeEvents;
  RxMap<ChatProvider, String> chats = RxMap();

  @override
  void onInit() {
    for (var chat in chats.entries) {
      if(chat.key == ChatProvider.kick){
        lazyPutKickChat(chat.value);
      } else if (chat.key == ChatProvider.twitch){
        lazyPutTwitchChat(chat.value);
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
