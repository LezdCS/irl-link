import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';

class TwitchTabView extends GetView<TwitchTabViewController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          padding: EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0),
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.circle,
                            color: controller.twitchStreamInfos.value.isOnline!
                                ? Colors.red
                                : Colors.grey),
                        Padding(padding: EdgeInsets.only(right: 10.0)),
                        Text(
                          controller.twitchStreamInfos.value.isOnline!
                              ? "Live"
                              : "Offline",
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, color: Colors.red),
                        Text(
                          controller.twitchStreamInfos.value.viewerCount
                              .toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "viewers",
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.titleFormController,
                      focusNode: controller.focus,
                      style: Theme.of(Get.context!).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Your stream\'s title',
                        labelText: 'Enter your stream\'s title',
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 12),
                      backgroundColor: Colors.deepPurpleAccent,
                      fixedSize: Size(50, 20),
                    ),
                    onPressed: () {
                      controller.setStreamTitle();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.raidFormController,
                      style: Theme.of(Get.context!).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter the nickname',
                        labelText: 'Raid Someone',
                      ),
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
                    onPressed: () {
                      controller.raidSomeone();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      'Raid',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Shortcuts",
                style: TextStyle(
                  color: Theme.of(Get.context!)
                      .textTheme
                      .bodyText1!
                      .color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.twitchStreamInfos.value =
                            controller.twitchStreamInfos.value.copyWith(
                                isFollowerMode: !controller
                                    .twitchStreamInfos.value.isFollowerMode!);
                        controller.changeChatSettings();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller
                                    .twitchStreamInfos.value.isFollowerMode!
                                ? Colors.deepPurpleAccent[200]
                                : Colors.grey[850],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Follower Only",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.twitchStreamInfos.value =
                            controller.twitchStreamInfos.value.copyWith(
                                isSubscriberMode: !controller
                                    .twitchStreamInfos.value.isSubscriberMode!);
                        controller.changeChatSettings();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller
                                    .twitchStreamInfos.value.isSubscriberMode!
                                ? Colors.deepPurpleAccent[200]
                                : Colors.grey[850],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Subscriber only',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.twitchStreamInfos.value =
                            controller.twitchStreamInfos.value.copyWith(
                                isEmoteMode: !controller
                                    .twitchStreamInfos.value.isEmoteMode!);
                        controller.changeChatSettings();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                controller.twitchStreamInfos.value.isEmoteMode!
                                    ? Colors.deepPurpleAccent[200]
                                    : Colors.grey[850],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Emote only',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.twitchStreamInfos.value =
                            controller.twitchStreamInfos.value.copyWith(
                                isSlowMode: !controller
                                    .twitchStreamInfos.value.isSlowMode!);
                        controller.changeChatSettings();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                controller.twitchStreamInfos.value.isSlowMode!
                                    ? Colors.deepPurpleAccent[200]
                                    : Colors.grey[850],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Slow Mode',
                          textAlign: TextAlign.center,
                        ),
                      ),
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
