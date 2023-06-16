import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:twitch_chat/twitch_chat.dart';

import 'home_view_controller.dart';

class ChatViewController extends GetxController
    with GetTickerProviderStateMixin {
  ChatViewController({required this.homeEvents, required this.channel});

  final HomeEvents homeEvents;
  final String channel;

  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;
  RxBool isChatConnected = false.obs;
  RxBool isAlertProgress = true.obs;
  Rx<Color> alertColor = const Color(0xFFEC7508).obs;

  RxString alertMessage = "Connecting...".obs;
  TwitchCredentials? twitchData;
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;

  late TextEditingController banDurationInputController;

  Timer? chatDemoTimer;

  late HomeViewController homeViewController;

  TwitchChat? twitchChat;

  @override
  void onInit() async {
    homeViewController = Get.find<HomeViewController>();

    scrollController = ScrollController();
    banDurationInputController = TextEditingController();
    if (Get.arguments != null) {
      await homeEvents.getSettings().then((settings) async {
        twitchData = Get.arguments[0];

        twitchChat = TwitchChat(
          channel,
          twitchData!.twitchUser.login,
          twitchData!.accessToken,
          clientId: kTwitchAuthClientId,
          onConnected: () {
            chatMessages.clear();
          },
          onClearChat: () {
            chatMessages.clear();
          },
          onDeletedMessageByUserId: (String? userId) {
            for (var message in chatMessages) {
              if (message.authorId == userId) {
                message.isDeleted = true;
              }
            }
            chatMessages.refresh();
          },
          onDeletedMessageByMessageId: (String? messageId) {
            chatMessages
                .firstWhereOrNull((message) => message.id == messageId)!
                .isDeleted = true;
            chatMessages.refresh();
          },
          onDone: () {
            twitchChat!.connect();
          },
          onError: () {},
          params: TwitchChatParameters(addFirstMessages: true),
        );

        twitchChat!.isConnected.addListener(() {
          if (twitchChat!.isConnected.value) {
            isChatConnected.value = true;
            isAlertProgress.value = false;
            alertMessage.value = "CONNECTED";
            alertColor.value = const Color(0xFF1DBF1D);
          } else {
            isChatConnected.value = false;
          }
        });

        twitchChat!.chatStream.listen((message) {
          if (homeViewController.settings.value.hiddenUsersIds!
              .contains(message.authorId)) {
            return;
          }
          if (homeViewController.settings.value.ttsEnabled!) {
            readTts(message);
          }
          chatMessages.add(message);

          if (scrollController.hasClients && isAutoScrolldown.value) {
            Timer(const Duration(milliseconds: 100), () {
              if (isAutoScrolldown.value) {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              }
            });
          }
        });

        homeViewController.selectedChat = twitchChat;

        await applySettings();
      });
    } else {
      chatDemoTimer = Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) => {
          chatMessages.add(ChatMessage.randomGeneration(null, null, null)),
          if (scrollController.hasClients && isAutoScrolldown.value)
            {
              Timer(const Duration(milliseconds: 100), () {
                if (isAutoScrolldown.value) {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                }
              }),
            }
        },
      );
      alertMessage.value = "DEMO";
      alertColor.value = const Color(0xFF196DEE);
      isChatConnected.value = false;
      isAlertProgress.value = false;
    }
    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);
    if (twitchData != null) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            if (twitchChat != null && !twitchChat!.isConnected.value) {
              twitchChat!.close();
              twitchChat!.connect();
            }
            break;
          case ConnectivityResult.mobile:
            if (twitchChat != null && !twitchChat!.isConnected.value) {
              twitchChat!.close();
              twitchChat!.connect();
            }
            break;
          case ConnectivityResult.none:
            alertMessage.value = "Network connectivity lost";
            isChatConnected.value = false;
            alertColor.value = const Color(0xFFEC7508);
            isAlertProgress.value = true;
            break;
          case ConnectivityResult.ethernet:
            break;
          case ConnectivityResult.bluetooth:
            break;
          case ConnectivityResult.vpn:
            break;
          case ConnectivityResult.other:
            if (twitchChat != null && !twitchChat!.isConnected.value) {
              twitchChat!.close();
              twitchChat!.connect();
            }
            break;
        }
      });
    }

    super.onReady();
  }

  @override
  void onClose() {
    homeViewController.flutterTts.stop();
    chatDemoTimer?.cancel();
    super.onDelete;
    super.onClose();
  }

  void scrollListener() {
    // if user scroll up -> disable auto scrolldown
    if (isAutoScrolldown.value &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      isAutoScrolldown.value = false;
    }

    double maxPosition = scrollController.position.maxScrollExtent;
    double currentPosition = scrollController.position.pixels;
    double difference = 10.0;

    /// bottom position
    if (!isAutoScrolldown.value &&
        maxPosition - currentPosition <= difference) {
      isAutoScrolldown.value = true;
    }
  }

  /// Delete [message] by his id
  void deleteMessageInstruction(ChatMessage message) {
    TwitchApi.deleteMessage(
      twitchData!.accessToken,
      twitchChat?.channelId,
      message,
      kTwitchAuthClientId,
    );

    if (twitchData == null) message.isDeleted = true;
    homeViewController.selectedMessage.value = null;
  }

  /// Ban user for specific [duration] based on the author name in the [message]
  void timeoutMessageInstruction(ChatMessage message, int duration) {
    TwitchApi.banUser(
      twitchData!.accessToken,
      twitchChat?.channelId,
      message,
      duration,
      kTwitchAuthClientId,
    );
    Get.back();
    homeViewController.selectedMessage.value = null;
  }

  /// Ban user based on the author name in the [message]
  void banMessageInstruction(ChatMessage message) {
    TwitchApi.banUser(
      twitchData!.accessToken,
      twitchChat!.channelId,
      message,
      null,
      kTwitchAuthClientId,
    );
    homeViewController.selectedMessage.value = null;
  }

  /// Hide every future messages from an user (only on this application, not on Twitch)
  void hideUser(ChatMessage message) {
    if (twitchData == null) return;

    List hiddenUsersIds =
        homeViewController.settings.value.hiddenUsersIds! != const []
            ? homeViewController.settings.value.hiddenUsersIds!
            : [];
    if (hiddenUsersIds
            .firstWhereOrNull((userId) => userId == message.authorId) ==
        null) {
      //add user
      hiddenUsersIds.add(message.authorId);
      homeViewController.settings.value = homeViewController.settings.value
          .copyWith(hiddenUsersIds: hiddenUsersIds);
    } else {
      //remove user
      hiddenUsersIds.remove(message.authorId);
      homeViewController.settings.value = homeViewController.settings.value
          .copyWith(hiddenUsersIds: hiddenUsersIds);
    }
    saveSettings();
    homeViewController.selectedMessage.refresh();
  }

  /// Scroll to bottom of the chat
  void scrollToBottom() {
    isAutoScrolldown.value = true;
    if (scrollController.hasClients) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

  void saveSettings() {
    homeEvents.setSettings(settings: homeViewController.settings.value);
  }

  Future applySettings() async {
    isAutoScrolldown.value = true;

    if (twitchChat != null && !twitchChat!.isConnected.value) {
      twitchChat?.connect();
    }
  }

  void changeChannel(String channel) {
    twitchChat?.changeChannel(channel);
  }

  void readTts(ChatMessage message) {
    //check if user is ignored
    if (homeViewController.settings.value.ttsUsersToIgnore!
        .contains(message.authorName)) {
      return;
    }
    //check if message start with ignored prefix
    for (String prefix in homeViewController.settings.value.prefixsToIgnore!) {
      if (message.message.startsWith(prefix)) {
        return;
      }
    }
    //check if message start with allowed prefix
    if (homeViewController.settings.value.prefixsToUseTtsOnly!.isNotEmpty) {
      for (String prefix
          in homeViewController.settings.value.prefixsToUseTtsOnly!) {
        if (message.message.startsWith(prefix) == false) {
          return;
        }
      }
    }
    String text = "user_said_message".trParams(
      {'authorName': message.authorName, 'message': message.message},
    );
    if (homeViewController.settings.value.ttsMuteViewerName!) {
      text = message.message;
    }
    homeViewController.flutterTts.speak(text);
  }
}
