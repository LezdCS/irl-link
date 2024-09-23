import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/widgets/alert_message_view.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/event_container.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/shared/message_container.dart';
import 'package:irllink/src/presentation/widgets/chats/chat_message/twitch/moderation_bottom_sheet.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch_chat;

class ChatView extends GetView<ChatViewController> {
  const ChatView({
    super.key,
    required this.chatGroup,
  });

  final ChatGroup chatGroup;

  @override
  ChatViewController get controller =>
      Get.find<ChatViewController>(tag: chatGroup.id);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    bool multiplePlatform = atLeastTwoNotEmpty([
      controller.kickChats,
      controller.twitchChats,
      controller.youtubeChats
    ]);

    return Obx(
      () {
        Settings settings = Get.find<SettingsService>().settings.value;

        return Stack(children: [
          GestureDetector(
            onTap: () {
              if (controller.homeViewController.selectedMessage.value != null) {
                controller.homeViewController.selectedMessage.value = null;
              }
              FocusScope.of(context).unfocus();
            },
            onDoubleTap: () {
              // Open a confirmation dialog to reconnect to the chat
              Get.defaultDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: "confirm".tr,
                middleText: "reconnect_question".tr,
                textConfirm: "confirm".tr,
                textCancel: "cancel".tr,
                confirmTextColor: Theme.of(context).textTheme.bodyLarge!.color,
                cancelTextColor: Theme.of(context).textTheme.bodyLarge!.color,
                buttonColor: Theme.of(context).colorScheme.tertiary,
                onConfirm: () {
                  for (twitch_chat.TwitchChat twitchChat
                      in controller.twitchChats) {
                    twitchChat.close();
                    twitchChat.connect();
                  }
                  Get.back();
                },
                onCancel: () {
                  Get.back();
                },
              );
            },
            child: Container(
              width: width,
              height: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: height * 0.07),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: controller.chatMessages.isNotEmpty
                  ? ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.chatMessages.length,
                      itemBuilder: (BuildContext context, int index) {
                        ChatMessage message = controller.chatMessages[index];
                        return InkWell(
                          onTap: () {
                            if (FocusScope.of(context).isFirstFocus) {
                              FocusScope.of(context).unfocus();
                            }
                            controller.homeViewController.selectedMessage
                                .value = null;
                          },
                          onLongPress: () {
                            controller.homeViewController.selectedMessage
                                .value ??= message;
                          },
                          child: message.eventType != null
                              ? EventContainer(
                                  message: message,
                                  selectedMessage: controller
                                      .homeViewController.selectedMessage.value,
                                  displayTimestamp: settings.displayTimestamp!,
                                  textSize: settings.textSize!,
                                  hideDeletedMessages: settings
                                      .chatSettings!.hideDeletedMessages,
                                  cheerEmotes: controller.cheerEmotes,
                                  thirdPartEmotes: controller.thirdPartEmotes,
                                  showPlatformBadge: multiplePlatform,
                                )
                              : MessageContainer(
                                  selectedMessage: controller
                                      .homeViewController.selectedMessage.value,
                                  message: message,
                                  displayTimestamp: settings.displayTimestamp!,
                                  textSize: settings.textSize!,
                                  hideDeletedMessages: settings
                                      .chatSettings!.hideDeletedMessages,
                                  cheerEmotes: controller.cheerEmotes,
                                  thirdPartEmotes: controller.thirdPartEmotes,
                                  showPlatformBadge: multiplePlatform,
                                ),
                        );
                      },
                    )
                  : controller.chatGroup.channels.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "welcome_to_chat".trParams(
                              {
                                "channel":
                                    controller.chatGroup.channels.first.channel,
                              },
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        )
                      : Container(),
            ),
          ),
          Positioned(
            bottom: height * 0.07,
            left: 0,
            right: 0,
            child: Visibility(
              visible: !controller.isAutoScrolldown.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.scrollToBottom();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      color: Colors.white.withOpacity(0.8),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.07,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset:
                  controller.homeViewController.selectedMessage.value != null
                      ? Offset.zero
                      : const Offset(0, 1),
              duration: const Duration(milliseconds: 200),
              child: Visibility(
                visible:
                    controller.homeViewController.selectedMessage.value != null,
                child: ModerationBottomSheet(controller: controller),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: controller.isChatConnected.value ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 1000),
            child: AlertMessageView(
              color: controller.alertColor.value,
              message: controller.alertMessage.value,
              isProgress: controller.isAlertProgress.value,
            ),
          ),
        ]);
      },
    );
  }
}

bool atLeastTwoNotEmpty(List<List> lists) {
  int count = 0;

  for (final list in lists) {
    if (list.isNotEmpty) {
      count++;
      if (count >= 2) {
        return true;
      }
    }
  }

  return false;
}
