import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class DashboardController extends GetxController {
  DashboardController();

  HomeViewController homeViewController = Get.find<HomeViewController>();

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
