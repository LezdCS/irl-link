import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

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
                      return InkWell(
                        onTap: () {
                          if (FocusScope.of(context).isFirstFocus) {
                            FocusScope.of(context).unfocus();
                          }
                          controller.selectedMessage.value = null;
                        },
                        onLongPress: () {
                          if (controller.selectedMessage.value == null) {
                            controller.selectedMessage.value =
                                controller.chatMessages[index];
                          }
                        },
                        child: chatMessage(controller.chatMessages[index]),
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
            offset: controller.selectedMessage.value  != null ? Offset.zero : Offset(0, 1),
            duration: Duration(milliseconds: 200),
            child: Visibility(
              visible: controller.selectedMessage.value != null,
              child: moderationView(width),
            ),
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
        decoration: BoxDecoration(
          color: controller.selectedMessage.value == message
              ? Theme.of(Get.context!).colorScheme.secondary
              : Theme.of(Get.context!).colorScheme.background,
          border: message.isBitDonation
              ? Border(
                  left: BorderSide(width: 5.0, color: Color(0xFF9147ff)),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: message.isBitDonation,
              child: Container(
                child: Text(
                  'Cheered ${message.bitAmount.toString()} Bits',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Visibility(
                  visible: controller.settings.value.displayTimestamp!,
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(message.timestamp))}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                for (TwitchBadge badge in message.badges)
                  Container(
                    padding: EdgeInsets.only(right: 4, top: 3),
                    child: Image(
                      image: NetworkImage(badge.imageUrl1x),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                Text(
                  message.isAction
                      ? message.authorName + " "
                      : message.authorName + ": ",
                  style: TextStyle(
                    color:
                        Color(int.parse(message.color.replaceAll('#', '0xff'))),
                    fontSize: controller.settings.value.textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (message.isDeleted)
                  Text(
                    "<message deleted>",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                    ),
                  )
                else
                  for (Widget i in message.messageWidgetsBuild) i,
              ],
            ),
          ],
        ));
  }

  void timeoutDialog() {
    final List<Map<String, int>> timeoutValues = [
      {"10s": 10},
      {"1m": 60},
      {"10m": 600},
      {"30m": 1800},
    ];

    Get.defaultDialog(
      title: "Timeout",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Color(0xFF282828),
      buttonColor: Color(0xFF9147ff),
      cancelTextColor: Color(0xFF9147ff),
      textCancel: "Cancel",
      radius: 10,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(timeoutValues.length, (index) {
              return InkWell(
                onTap: () => controller.timeoutMessageInstruction(
                    controller.selectedMessage.value!,
                    timeoutValues[index].values.first),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    timeoutValues[index].keys.first,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextField(
                    controller: controller.banDurationInputController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (String value) {
                      if (int.tryParse(value) != null) {
                        controller.timeoutMessageInstruction(
                            controller.selectedMessage.value!,
                            int.parse(value));
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      hintText: 'Custom duration (s)',
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 5),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (int.tryParse(
                            controller.banDurationInputController.text) !=
                        null) {
                      controller.timeoutMessageInstruction(
                          controller.selectedMessage.value!,
                          int.parse(
                              controller.banDurationInputController.text));
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget moderationView(double width) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFa970ff)),
        color: Color(0xFF18181b),
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
              onTap: () => timeoutDialog(),
              child: moderationViewButton(Icons.timer, "Timeout"),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () =>
                  controller.hideUser(controller.selectedMessage.value!),
              child: (controller.selectedMessage.value != null &&
                      controller.settings.value.hiddenUsersIds!
                              .firstWhereOrNull((userId) =>
                                  controller.selectedMessage.value!.authorId ==
                                  userId) !=
                          null)
                  ? moderationViewButton(Icons.visibility, "Unhide user")
                  : moderationViewButton(Icons.visibility_off, "Hide user"),
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
        color: Color(0xFF0e0e10),
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
