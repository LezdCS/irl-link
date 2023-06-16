import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chat_message/event_container.dart';
import 'package:irllink/src/presentation/widgets/chat_message/message_container.dart';
import 'package:irllink/src/presentation/widgets/chat_message/moderation_bottom_sheet.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'alert_message_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.channel,
  });

  final String channel;

  @override
  Widget build(BuildContext context) {
    ChatViewController? controller;
    if (Get.isRegistered<ChatViewController>(tag: channel)) {
      controller = Get.find<ChatViewController>(tag: channel);
    }

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (controller == null) {
      return Container();
    }
    return Obx(
      () => Stack(children: [
        GestureDetector(
          onTap: () {
            if (controller?.homeViewController.selectedMessage.value != null) {
              controller?.homeViewController.selectedMessage.value = null;
            }
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: width,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: height * 0.07),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: controller!.chatMessages.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Welcome on ${controller.twitchChat?.channel} 's chat room !",
                      style: const TextStyle(
                        color: Color(0xFF878585),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.chatMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      ChatMessage message = controller!.chatMessages[index];
                      return Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: InkWell(
                          onTap: () {
                            if (FocusScope.of(context).isFirstFocus) {
                              FocusScope.of(context).unfocus();
                            }
                            controller!.homeViewController.selectedMessage
                                .value = null;
                          },
                          onLongPress: () {
                            controller!.homeViewController.selectedMessage
                                .value ??= message;
                          },
                          child: message.highlightType != null
                              ? EventContainer(
                                  message: message,
                                  selectedMessage: controller
                                      .homeViewController.selectedMessage.value,
                                  displayTimestamp: controller
                                      .homeViewController
                                      .settings
                                      .value
                                      .displayTimestamp!,
                                  textSize: controller.homeViewController
                                      .settings.value.textSize!,
                                  twitchChat: controller.twitchChat!,
                                )
                              : MessageContainer(
                                  selectedMessage: controller
                                      .homeViewController.selectedMessage.value,
                                  message: message,
                                  displayTimestamp: controller
                                      .homeViewController
                                      .settings
                                      .value
                                      .displayTimestamp!,
                                  textSize: controller.homeViewController
                                      .settings.value.textSize!,
                                  twitchChat: controller.twitchChat!,
                                ),
                        ),
                      );
                    },
                  ),
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
                    controller!.scrollToBottom();
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
            offset: controller.homeViewController.selectedMessage.value != null
                ? Offset.zero
                : const Offset(0, 1),
            duration: const Duration(milliseconds: 200),
            child: Visibility(
              visible:
                  controller.homeViewController.selectedMessage.value != null,
              child:
                  ModerationBottomSheet(controller: controller, width: width),
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
      ]),
    );
  }
}
