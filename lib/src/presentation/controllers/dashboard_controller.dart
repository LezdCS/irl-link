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

  // list of the events the user chosed to have in the dashboard
  RxList<FloatingEvent> userEvents = <FloatingEvent>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void onReady() async {
    userEvents.addAll([
      const FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.green,
        title: "Start stream",
        event: SupportedEvents.obsStreamStart,
      ),
      const FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.orange,
        title: "Stop stream",
        event: SupportedEvents.obsStreamStop,
      ),
      const FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.toggle,
        color: Colors.red,
        title: "Followe only",
        event: SupportedEvents.twitchFollowerOnly,
      ),
    ]);
    super.onReady();
  }
}
