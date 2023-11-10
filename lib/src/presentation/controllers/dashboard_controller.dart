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
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class DashboardController extends GetxController {
  DashboardController();

  // List of the events in the user dashboard
  RxList<DashboardEvent> userEvents = <DashboardEvent>[].obs;

  @override
  void onInit() {
    List<DashboardEvent> events = Get.find<HomeViewController>().settings.value.dashboardSettings!.userEvents;
    debugPrint(events.toString());
    userEvents.addAll(events);
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void onReady() async {
    userEvents.addAll([
      const DashboardEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.green,
        title: "Start stream",
        event: SupportedEvents.obsStreamStart,
        customValue: null,
      ),
      const DashboardEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Color.fromARGB(255, 124, 20, 20),
        title: "Stop stream",
        event: SupportedEvents.obsStreamStop,
        customValue: null,
      ),
    ]);
    super.onReady();
  }
}
