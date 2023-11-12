//make a class

//CHOOSE BETWEEN
//make a way to create groups
//make a way to register new functions in these groups
//so from other controllers we can register new functions to the dashboard
//need specify the group, type of action on dashboard and a title

//OR
//we define all available functions here and we use the Get.find to get the controllers

import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class DashboardController extends GetxController {
  DashboardController();

  HomeViewController homeViewController = Get.find<HomeViewController>();

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void onReady() async {
    super.onReady();
  }

  // Add a dashboard event
  void addDashboardEvent(DashboardEvent event) {
    List<DashboardEvent> events = [];
    events.addAll(homeViewController.settings.value.dashboardSettings!.userEvents);
    events.add(event);
    homeViewController.settings.value =
        homeViewController.settings.value.copyWith(
      dashboardSettings: homeViewController.settings.value.dashboardSettings!
          .copyWith(userEvents: events),
    );
    homeViewController.saveSettings();
    homeViewController.settings.refresh();
    Get.back();
  }

  // Remove a dashboard event
  void removeDashboardEvent(DashboardEvent event) {
    List<DashboardEvent> events =
        homeViewController.settings.value.dashboardSettings!.userEvents;
    events.remove(event);
    homeViewController.settings.value =
        homeViewController.settings.value.copyWith(
      dashboardSettings: homeViewController.settings.value.dashboardSettings!
          .copyWith(userEvents: events),
    );
    homeViewController.saveSettings();
    homeViewController.settings.refresh();
  }
}
