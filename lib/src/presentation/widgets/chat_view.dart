import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';

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
          },
          child: Container(
            width: width,
            padding: EdgeInsets.only(top: 10, left: 10, bottom: height * 0.07),
            decoration: BoxDecoration(
              color: Color(0xFF282828),
            ),
            child: ListView(
              controller: controller.scrollController,
              children: [
                Visibility(
                  visible: controller.chatMessages.length < 100,
                  child: Text(
                    "Welcome on ${controller.twitchData.twitchUser.displayName} 's chat room !",
                    style: TextStyle(
                      color: Color(0xFF878585),
                    ),
                  ),
                ),
                for (TwitchChatMessage message in controller.chatMessages)
                  InkWell(
                    onTap: () {
                      if (controller.selectedMessage.value == null) {
                        controller.selectedMessage.value = message;
                      } else {
                        controller.selectedMessage.value = null;
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
          child: Visibility(
            visible: controller.selectedMessage.value != null,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
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
                  Text(
                    controller.selectedMessage.value?.authorName ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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

                  //TODO : créer un widget juste pour ce type de button (qu'on retrouve uniquement ici d'après les maquettes)
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFF282828),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      "Delete message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            "Ban",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            "Timeout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                ],
              ),
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
            message: controller.isChatConnected.value
                ? "Connected"
                : "Connecting...",
            isProgress: !controller.isChatConnected.value,
          ),
        ),
      ]),
    );
  }

  Widget chatMessage(TwitchChatMessage message) {
    return Container(
      padding: EdgeInsets.only(top: 4),
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
          for (String word in message.message.trim().split(' '))
            if (message.emotes.entries.firstWhereOrNull((element) => element
                    .value
                    .where((position) =>
                        message.message.substring(int.parse(position[0]),
                            int.parse(position[1]) + 1) ==
                        word)
                    .isNotEmpty) !=
                null)
              Wrap(children: [
                Image(
                  image: NetworkImage(
                      "https://static-cdn.jtvnw.net/emoticons/v2/" +
                          message
                              .emotes.entries
                              .firstWhere((element) => element
                                  .value
                                  .where((position) =>
                                      message.message.substring(
                                          int.parse(position[0]),
                                          int.parse(position[1]) + 1) ==
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
    );
  }
}
