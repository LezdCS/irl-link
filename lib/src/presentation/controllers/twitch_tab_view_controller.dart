import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class TwitchTabViewController extends GetxController{

  RxBool streamState = false.obs;           // état du stream
  RxInt nbViewers = 0.obs;                  // nombre de viewers sur le stream
  RxString streamTitle = "".obs;            // titre du stream
  String raid = "";                         // pseudo de la personne qui va se faire raid

  RxBool isFollowersOnly = false.obs;       // chat en mode followers only
  RxBool isSubscribersOnly = false.obs;     // chat en mode sub only
  RxBool isEmoteOnly = false.obs;           // chat en mode emote only
  RxBool isSlowMode = false.obs;            // chat en slow mode



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}