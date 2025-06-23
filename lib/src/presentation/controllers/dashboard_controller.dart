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
  void addDashboardEvent(DashboardEvent event) async {
    final result = await addDashboardEventUseCase(params: event);
    result.fold(
      (failure) {},
      (success) {
        // Refresh the events list after successful addition
        getDashboardEvents();
      },
    );
    Get.back();
  }

  // Remove a dashboard event
  void removeDashboardEvent(DashboardEvent event) async {
    final result = await removeDashboardEventUseCase(params: event);
    result.fold(
      (failure) {},
      (success) {
        // Refresh the events list after successful removal
        getDashboardEvents();
      },
    );
  }

  void getDashboardEvents() async {
    final result = await getDashboardEventsUseCase(params: null);
    result.fold(
      (failure) {},
      (events) {
        // Update the reactive list with the fetched events
        dashboardEvents.assignAll(events);
      },
    );
  }
}
