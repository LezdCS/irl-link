import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/usecases/dashboard/add_dashboard_event_usecase.dart';
import 'package:irllink/src/domain/usecases/dashboard/delete_dashboard_event_usecase.dart';
import 'package:irllink/src/domain/usecases/dashboard/get_dashboard_events_usecase.dart';

class DashboardController extends GetxController {
  final SettingsService settingsService;

  // Constructor with dependency injection
  DashboardController({
    required this.settingsService,
    required this.getDashboardEventsUseCase,
    required this.addDashboardEventUseCase,
    required this.removeDashboardEventUseCase,
  });

  final GetDashboardEventsUseCase getDashboardEventsUseCase;
  final AddDashboardEventUseCase addDashboardEventUseCase;
  final DeleteDashboardEventUseCase removeDashboardEventUseCase;
  RxList<DashboardEvent> dashboardEvents = <DashboardEvent>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDashboardEvents();
  }

  // Add a dashboard event
  void addDashboardEvent(DashboardEvent event) {
    addDashboardEventUseCase(params: event);

    Get.back();
  }

  // Remove a dashboard event
  void removeDashboardEvent(DashboardEvent event) {
    removeDashboardEventUseCase(params: event);
  }

  void getDashboardEvents() {
    getDashboardEventsUseCase(params: null);
  }
}
