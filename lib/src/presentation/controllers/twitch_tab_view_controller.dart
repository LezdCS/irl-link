import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import 'home_view_controller.dart';

class TwitchTabViewController extends GetxController {
  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxBool streamState = false.obs; // état du stream
  RxInt nbViewers = 0.obs; // nombre de viewers sur le stream
  RxString streamTitle = "".obs; // titre du stream
  String raid = ""; // pseudo de la personne qui va se faire raid

  RxBool isFollowersOnly = false.obs; // chat en mode followers only
  RxBool isSubscribersOnly = false.obs; // chat en mode sub only
  RxBool isEmoteOnly = false.obs; // chat en mode emote only
  RxBool isSlowMode = false.obs; // chat en slow mode

  late TextEditingController titleFormController;
  //todo : utiliser un FocusNode pour vérifier si l'utilisateur edit le Titre
  // si il edit le titre alors on ne doit pas changer le titre lors d'un fetch des infos de stream
  FocusNode _focus = FocusNode();

  late HomeViewController homeViewController;

  @override
  void onInit() {
    titleFormController = new TextEditingController();
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

  void getStreamInfos() {
    //todo : enlever le getTwitchUser et n'utiliser que le twitch id de l'utilisateur connecté pour le getStreamInfo
    // pour le moment on garde le getTwitchUser pour faire des tests sur d'autres streamers
    homeEvents
        .getTwitchUser(
          username: homeViewController.chatViewController.ircChannelJoined,
          accessToken: homeViewController.twitchData.accessToken,
        )
        .then(
          (value) => homeEvents
              .getStreamInfo(
                homeViewController.twitchData.accessToken,
                value.data!.id,
              )
              .then(
                (value) => {
                  if (value.data != null)
                    {
                      nbViewers.value = value.data!.viewerCount,
                      streamTitle.value = value.data!.title,
                      streamState.value = value.data!.isOnline,
                      titleFormController.text = streamTitle.value,
                    },
                },
              ),
        );
  }
}
