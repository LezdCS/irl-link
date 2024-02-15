import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/chats/kick_chat_controller.dart';

void lazyPutKickChat(String chatroomId) {
  Get.lazyPut(
    () => KickChatController(
      chatroomId: chatroomId,
    ),
    tag: chatroomId,
  );
}
