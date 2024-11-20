import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class DashboardController extends GetxController {
  final HomeViewController homeViewController;
  final SettingsService settingsService;

  // Constructor with dependency injection
  DashboardController({
    required this.homeViewController,
    required this.settingsService,
  });

  // Add a dashboard event
  void addDashboardEvent(DashboardEvent event) {
    Settings settings = settingsService.settings.value;

    List<DashboardEvent> events = [];
    events.addAll(settings.dashboardSettings.userEvents);
    events.add(event);
    settingsService.settings.value = settings.copyWith(
      dashboardSettings:
          settings.dashboardSettings.copyWith(userEvents: events),
    );
    settingsService.saveSettings();

    Get.back();
  }

  // Remove a dashboard event
  void removeDashboardEvent(DashboardEvent event) {
    Settings settings = settingsService.settings.value;

    List<DashboardEvent> events = settings.dashboardSettings.userEvents;
    events.remove(event);
    settingsService.settings.value = settings.copyWith(
      dashboardSettings:
          settings.dashboardSettings.copyWith(userEvents: events),
    );
    settingsService.saveSettings();
  }
}
