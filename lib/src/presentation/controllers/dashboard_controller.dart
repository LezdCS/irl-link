import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class DashboardController extends GetxController {
  DashboardController();

  HomeViewController homeViewController = Get.find<HomeViewController>();

  // Add a dashboard event
  void addDashboardEvent(DashboardEvent event) {
    Settings settings = Get.find<SettingsService>().settings.value;

    List<DashboardEvent> events = [];
    events.addAll(settings.dashboardSettings!.userEvents);
    events.add(event);
    Get.find<SettingsService>().settings.value = settings.copyWith(
      dashboardSettings:
          settings.dashboardSettings!.copyWith(userEvents: events),
    );
    Get.find<SettingsService>().saveSettings();

    Get.back();
  }

  // Remove a dashboard event
  void removeDashboardEvent(DashboardEvent event) {
    Settings settings = Get.find<SettingsService>().settings.value;

    List<DashboardEvent> events = settings.dashboardSettings!.userEvents;
    events.remove(event);
    Get.find<SettingsService>().settings.value = settings.copyWith(
      dashboardSettings:
          settings.dashboardSettings!.copyWith(userEvents: events),
    );
    Get.find<SettingsService>().saveSettings();
  }
}
