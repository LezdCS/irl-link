import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
              color: Color(0xFF282828),
            ),
            child: ListView(
              controller: controller.scrollController,
              children: [
                Visibility(
                  visible: controller.chatMessages.length < 100,
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Welcome on ${controller.ircChannelJoined} 's chat room !",
                      style: TextStyle(
                        color: Color(0xFF878585),
                      ),
                    ),
                  ),
                ),
                for (TwitchChatMessage message in controller.chatMessages)
                  InkWell(
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
                    child: chatMessage(message),
                  )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.07,
          width: width,
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
                    color: Colors.black.withOpacity(0.8),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
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
          child: Visibility(
            visible: controller.selectedMessage.value != null,
            child: moderationView(width),
          ),
        ),
        AnimatedOpacity(
          opacity: controller.isChatConnected.value ? 0.0 : 1.0,
          duration: Duration(milliseconds: 1000),
          child: AlertMessageView(
            color: controller.isChatConnected.value
                ? Color(0xFF33A031)
                : Color(0xFFEC7508),
            message: controller.alertMessage.value,
            isProgress: !controller.isChatConnected.value,
          ),
        ),
      ]),
    );
  }

  Widget chatMessage(TwitchChatMessage message) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
      color: controller.selectedMessage.value == message
          ? Colors.grey
          : Color(0xFF282828),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          for (TwitchBadge badge in message.badges)
            Container(
              padding: EdgeInsets.only(right: 4, top: 3),
              child: Image(
                image: NetworkImage(badge.imageUrl1x),
                filterQuality: FilterQuality.high,
                alignment: Alignment.bottomLeft,
              ),
            ),
          Text(
            message.authorName + ": ",
            style: TextStyle(
              color: message.color != ''
                  ? Color(int.parse(message.color.replaceAll('#', '0xff')))
                  : Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          message.deleted
              ? Text(
                  "<message deleted>",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 19,
                  ),
                )
              : Wrap(
                  children: [
                    for (String word in message.message.trim().split(' '))
                      if (message.emotes.entries.firstWhereOrNull((element) =>
                              element.value
                                  .where((position) =>
                                      message.message.substring(
                                          int.parse(position[0]),
                                          int.parse(position[1]) + 1) ==
                                      word)
                                  .isNotEmpty) !=
                          null)
                        Wrap(children: [
                          Image(
                            image: NetworkImage(
                                "https://static-cdn.jtvnw.net/emoticons/v2/" +
                                    message.emotes.entries
                                        .firstWhere((element) => element.value
                                            .where((position) =>
                                                message.message.substring(
                                                    int.parse(position[0]),
                                                    int.parse(position[1]) +
                                                        1) ==
                                                word)
                                            .isNotEmpty)
                                        .key +
                                    "/default/dark/1.0"),
                          ),
                          Text(' '),
                        ])
                      else
                        Text(
                          word + " ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget messageDeleted() {
    return Container(
      child: Text("<message deleted>"),
    );
  }

  void timeoutDialog(double width) {
    Get.defaultDialog(
      title: "Timeout",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Color(0xFF282828),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                    controller.selectedMessage.value!, 10000),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    '10s',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                    controller.selectedMessage.value!, 60000),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    '1m',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                    controller.selectedMessage.value!, 600000),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    '10m',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                    controller.selectedMessage.value!, 1800000),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    '30m',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                width: width * 0.50,
                child: TextField(
                  controller: controller.banDurationInputController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (String value) {
                    if (int.tryParse(value) != null) {
                      controller.timeoutMessageInstruction(
                          controller.selectedMessage.value!, int.parse(value));
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    hintText: 'Custom duration (ms)',
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 5),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (int.tryParse(
                          controller.banDurationInputController.text) !=
                      null) {
                    controller.timeoutMessageInstruction(
                        controller.selectedMessage.value!,
                        int.parse(controller.banDurationInputController.text));
                  }
                },
                child: Container(
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      textCancel: "Cancel",
    );
  }

  Widget moderationView(double width) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedMessage.value?.authorName ?? "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  InkWell(
                    onTap: () => launch("https://twitch.tv/" +
                        controller.selectedMessage.value!.authorName),
                    child: Icon(
                      Icons.open_in_browser,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () => controller.selectedMessage.value = null,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            controller.selectedMessage.value?.message ?? "",
            style: TextStyle(
              color: Color(0xFF575757),
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
          InkWell(
            onTap: () => controller
                .deleteMessageInstruction(controller.selectedMessage.value!),
            child: moderationViewButton(null, "Delete message"),
          ),
          SizedBox(height: 15),
          Row(children: [
            InkWell(
              onTap: () => controller
                  .banMessageInstruction(controller.selectedMessage.value!),
              child: moderationViewButton(Icons.stop, "Ban"),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () => timeoutDialog(width),
              child: moderationViewButton(Icons.timer, "Timeout"),
            ),
          ]),
        ],
      ),
    );
  }

  Widget moderationViewButton(IconData? icon, String message) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        clipBehavior: Clip.none,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
