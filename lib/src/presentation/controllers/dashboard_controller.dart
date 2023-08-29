//make a class

//CHOOSE BETWEEN
//make a way to create groups
//make a way to register new functions in these groups
//so from other controllers we can register new functions to the dashboard
//need specify the group, type of action on dashboard and a title

//OR
//we define all available functions here and we use the Get.find to get the controllers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';

class DashboardController extends GetxController {
  DashboardController();

  RxList<FloatingEvent> userEvents = <FloatingEvent>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() async {
    userEvents.addAll([
      FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.green,
        title: "Start stream",
        dashboardActionsProvider: DashboardActionsProvider.obs,
        action: (dynamic v) {
          debugPrint('ok');
        },
      ),
      FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.orange,
        title: "Clear TTS queue",
        dashboardActionsProvider: DashboardActionsProvider.twitch,
        action: (dynamic v) {
          debugPrint('ok');
        },
      ),
      FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.slider,
        color: Colors.pink,
        title: "TTS volume",
        dashboardActionsProvider: DashboardActionsProvider.twitch,
        action: (dynamic v) {
          debugPrint('ok');
        },
      ),
      FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.toggle,
        color: Colors.blueAccent,
        title: "TTS enabled",
        dashboardActionsProvider: DashboardActionsProvider.twitch,
        action: (dynamic v) {
          debugPrint('ok');
        },
      ),
    ]);
    super.onReady();
  }
}
