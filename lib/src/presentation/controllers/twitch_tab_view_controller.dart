import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import 'home_view_controller.dart';

class TwitchTabViewController extends GetxController {
  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxString streamTitle = "".obs; // titre du stream
  String raid = ""; // pseudo de la personne qui va se faire raid

  late TextEditingController titleFormController;

  //todo : utiliser un FocusNode pour vérifier si l'utilisateur edit le Titre
  // si il edit le titre alors on ne doit pas changer le titre lors d'un fetch des infos de stream
  FocusNode _focus = FocusNode();

  late HomeViewController homeViewController;

  Rx<TwitchStreamInfos> twitchStreamInfos =
      TwitchStreamInfos.defaultInfos().obs;

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

  void changeChatSettings() {
    homeEvents.setChatSettings(homeViewController.twitchData.accessToken,
        homeViewController.twitchData.twitchUser.id, twitchStreamInfos.value);
  }

  void getStreamInfos() {
    //todo : enlever le getTwitchUser et n'utiliser que le twitch id de l'utilisateur connecté pour le getStreamInfo
    // pour le moment on garde le getTwitchUser pour faire des tests sur d'autres streamers
    if (homeViewController.chatViewController.ircChannelJoined !=
        homeViewController.chatViewController.twitchData.twitchUser.login) {
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
                        twitchStreamInfos.value = value.data!,
                        titleFormController.text =
                            twitchStreamInfos.value.title!,
                      },
                  },
                ),
          );
    } else {
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
                  titleFormController.text = twitchStreamInfos.value.title!,
                },
            },
          );
    }
  }
}
