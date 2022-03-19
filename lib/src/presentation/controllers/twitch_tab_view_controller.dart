import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import 'home_view_controller.dart';

class TwitchTabViewController extends GetxController {
  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxString streamTitle = "".obs; // titre du stream
  String raid = ""; // pseudo de la personne qui va se faire raid

  late TextEditingController titleFormController;
  late TextEditingController raidFormController;

  // si il edit le titre alors on ne doit pas changer le titre lors d'un fetch des infos de stream
  FocusNode focus = FocusNode();

  late HomeViewController homeViewController;

  Rx<TwitchStreamInfos> twitchStreamInfos =
      TwitchStreamInfos.defaultInfos().obs;

  @override
  void onInit() {
    titleFormController = TextEditingController();
    raidFormController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    homeViewController = Get.find<HomeViewController>();

    getStreamInfos();
    Timer.periodic(Duration(seconds: 30), (timer) {
      getStreamInfos();
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void raidSomeone() {
    raid = raidFormController.text;
    homeViewController.sendChatMessage("/raid " + raid);
    raidFormController.text = "";
  }

  void changeChatSettings() {
    homeEvents.setChatSettings(homeViewController.twitchData.accessToken,
        homeViewController.twitchData.twitchUser.id, twitchStreamInfos.value);
  }

  void setStreamTitle() {
    homeEvents.setStreamTitle(homeViewController.twitchData.accessToken,
        homeViewController.twitchData.twitchUser.id, titleFormController.text);
  }

  void getStreamInfos() {
    homeEvents
        .getStreamInfo(
          homeViewController.twitchData.accessToken,
          homeViewController.twitchData.twitchUser.id,
        )
        .then(
          (value) => {
            if (value.data != null)
              {
                twitchStreamInfos.value = value.data!,
                if (!focus.hasFocus)
                  {
                    titleFormController.text = twitchStreamInfos.value.title!,
                  }
              },
          },
        );
  }
}
