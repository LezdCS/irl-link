import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import 'home_view_controller.dart';


class TwitchTabViewController extends GetxController{

  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxBool streamState = false.obs;           // état du stream
  RxInt nbViewers = 0.obs;                  // nombre de viewers sur le stream
  RxString streamTitle = "".obs;            // titre du stream
  String raid = "";                         // pseudo de la personne qui va se faire raid

  RxBool isFollowersOnly = false.obs;       // chat en mode followers only
  RxBool isSubscribersOnly = false.obs;     // chat en mode sub only
  RxBool isEmoteOnly = false.obs;           // chat en mode emote only
  RxBool isSlowMode = false.obs;            // chat en slow mode

 late HomeViewController homeViewController;


  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    homeViewController = Get.find<HomeViewController>();
    homeEvents.getStreamInfo(homeViewController.twitchData.accessToken, homeViewController.twitchData.twitchUser.id);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}