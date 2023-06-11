import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:twitch_chat/twitch_chat.dart';

import '../controllers/chat_view_controller.dart';
import 'alert_message_view.dart';
import 'chat_message/event_container.dart';
import 'chat_message/message_container.dart';

class ChatTab extends GetView<ChatViewController> {
  final TwitchChat chat;

  const ChatTab({super.key, 
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Obx(
      () => Stack(
        children: [
          Container(
            width: width,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: height * 0.07),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: controller.chatMessages.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Welcome on ${chat.channel} 's chat room !",
                      style: const TextStyle(
                        color: Color(0xFF878585),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.chatMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      ChatMessage message = controller.chatMessages[index];
                      return Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: InkWell(
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
                                  twitchChat: chat,
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
                                  twitchChat: chat,
                                ),
                        ),
                      );
                    },
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
        ],
      ),
    );
  }
}
