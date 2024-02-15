import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:kick_chat/kick_chat.dart';

class KickChatViewController extends GetxController {
  KickChatViewController({
    required this.homeEvents,
    required this.chatroomId,
  });

  final HomeEvents homeEvents;
  final String chatroomId;

  late KickChat kickChat;
  RxList<KickMessage> kickMessages = <KickMessage>[].obs;

  @override
  void onInit() {
    kickChat = KickChat(chatroomId);
    kickChat.connect();
    kickChat.chatStream.listen((message) {
      KickEvent? kickEvent = eventParser(message);
      if (kickEvent?.event == TypeEvent.message) {
        kickMessages.add(message);
      }
    });
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

  void onDone() {
    debugPrint('Kick chat closed');
  }

  void onError() {
    debugPrint('Kick chat closed');
  }
}
