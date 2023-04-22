import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/twitch_chat_message.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/widgets/chat_message/event_container.dart';
import 'package:irllink/src/presentation/widgets/chat_message/message_container.dart';
import 'package:irllink/src/presentation/widgets/chat_message/message_row.dart';
import 'package:irllink/src/presentation/widgets/chat_message/moderation_bottom_sheet.dart';

import 'alert_message_view.dart';

class ChatView extends GetView<ChatViewController> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Stack(children: [
        GestureDetector(
          onTap: () {
            if (controller.selectedMessage.value != null) {
              controller.selectedMessage.value = null;
            }
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: width,
            padding: EdgeInsets.only(top: 10, bottom: height * 0.07),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: controller.chatMessages.length == 0
                ? Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Welcome on ${controller.ircChannelJoined} 's chat room !",
                      style: TextStyle(
                        color: Color(0xFF878585),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.chatMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      TwitchChatMessage message =
                          controller.chatMessages[index];
                      return Container(
                        padding: EdgeInsets.only(top: 1, bottom: 1),
                        child: InkWell(
                          onTap: () {
                            if (FocusScope.of(context).isFirstFocus) {
                              FocusScope.of(context).unfocus();
                            }
                            controller.selectedMessage.value = null;
                          },
                          onLongPress: () {
                            if (controller.selectedMessage.value == null) {
                              controller.selectedMessage.value = message;
                            }
                          },
                          child: message.highlightType != null
                              ? EventContainer(
                                  controller: controller,
                                  message: message,
                                  child: MessageRow(
                                    controller: controller,
                                    message: message,
                                  ),
                                )
                              : MessageContainer(
                                  controller: controller,
                                  message: message,
                                  child: MessageRow(
                                    controller: controller,
                                    message: message,
                                  ),
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
                    controller.scrollToBottom();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.white.withOpacity(0.8),
                    child: Icon(
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
            offset: controller.selectedMessage.value != null
                ? Offset.zero
                : Offset(0, 1),
            duration: Duration(milliseconds: 200),
            child: Visibility(
              visible: controller.selectedMessage.value != null,
              child:
                  ModerationBottomSheet(controller: controller, width: width),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: controller.isChatConnected.value ? 0.0 : 1.0,
          duration: Duration(milliseconds: 1000),
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
