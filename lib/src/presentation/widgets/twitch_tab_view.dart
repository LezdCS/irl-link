import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';

class TwitchTabView extends GetView<TwitchTabViewController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          color: Color(0xFF0e0e10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 12.0, bottom: 12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.circle,
                            color: controller.twitchStreamInfos.value.isOnline!
                                ? Colors.green
                                : Colors.red),
                        Padding(padding: EdgeInsets.only(right: 10.0)),
                        Text(controller.twitchStreamInfos.value.isOnline!
                            ? "Online"
                            : "Offline"),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.only(right: 20.0, top: 12.0, bottom: 12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person_outline, color: Colors.red),
                        Text(
                          controller.twitchStreamInfos.value.viewerCount
                              .toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                        ),
                        Text("viewers"),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20, top: 13),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              controller: controller.titleFormController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Your stream\'s title',
                                labelText: 'Enter your stream\'s title',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 12),
                        backgroundColor: Colors.deepPurpleAccent,
                        fixedSize: Size(50, 20),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20, top: 13),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Enter the nickname',
                                labelText: 'Raid Someone',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.deepPurpleAccent,
                        fixedSize: Size(50, 20),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Raid',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  children: <Widget>[
                    Title(
                      title: "Chat Moderation :",
                      color: Colors.white,
                      child: Text(
                        "Chat Moderation :",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Wrap(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5, top: 5),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                              backgroundColor: controller
                                      .twitchStreamInfos.value.isFollowerMode!
                                  ? Colors.purple
                                  : Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              controller.twitchStreamInfos.value =
                                  controller.twitchStreamInfos.value.copyWith(
                                      isFollowerMode: !controller
                                          .twitchStreamInfos
                                          .value
                                          .isFollowerMode!);
                              controller.changeChatSettings();
                            },
                            child: Text(
                              'Followers Only',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, top: 5),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                              backgroundColor: controller
                                      .twitchStreamInfos.value.isSubscriberMode!
                                  ? Colors.purple
                                  : Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              controller.twitchStreamInfos.value =
                                  controller.twitchStreamInfos.value.copyWith(
                                      isSubscriberMode: !controller
                                          .twitchStreamInfos
                                          .value
                                          .isSubscriberMode!);
                              controller.changeChatSettings();
                            },
                            child: Text(
                              'Subscribers Only',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5, top: 2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                              backgroundColor: controller
                                      .twitchStreamInfos.value.isEmoteMode!
                                  ? Colors.purple
                                  : Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              controller.twitchStreamInfos.value =
                                  controller.twitchStreamInfos.value.copyWith(
                                      isEmoteMode: !controller.twitchStreamInfos
                                          .value.isEmoteMode!);
                              controller.changeChatSettings();
                            },
                            child: Text(
                              'Emote Only',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, top: 2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                              backgroundColor:
                                  controller.twitchStreamInfos.value.isSlowMode!
                                      ? Colors.purple
                                      : Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              controller.twitchStreamInfos.value =
                                  controller.twitchStreamInfos.value.copyWith(
                                      isSlowMode: !controller
                                          .twitchStreamInfos.value.isSlowMode!);
                              controller.changeChatSettings();
                            },
                            child: Text(
                              'Slow Mode',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
