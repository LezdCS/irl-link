import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import '../../domain/entities/dashboard_event.dart';

class Dashboard extends GetView<DashboardController> {
  @override
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 250,
      left: MediaQuery.of(context).size.width / 2 - 150,
      child: Container(
        width: 300,
        height: 500,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: controller.homeViewController.settings.value.dashboardSettings!
                .userEvents.isNotEmpty
            ? GridView.builder(
                itemCount: controller.homeViewController.settings.value
                    .dashboardSettings!.userEvents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 1.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  DashboardEvent event = controller.homeViewController.settings
                      .value.dashboardSettings!.userEvents[index];
                  // Check if the event is still supported
                  if (event.event == SupportedEvents.none) {
                    return _disabledServiceEvent(
                        event, "Event not supported anymore");
                  }
                  // Check if the service is enabled
                  bool isServiceEnabled = isDashboardServiceEnabled(event);
                  if (!isServiceEnabled) {
                    return _disabledServiceEvent(event, "Service disabled");
                  }
                  switch (event.dashboardActionsType) {
                    case DashboardActionsTypes.button:
                      return _eventButton(event);
                    case DashboardActionsTypes.slider:
                      return _eventSlider(event);
                    case DashboardActionsTypes.toggle:
                      return _eventToggle(event);
                    default:
                      return _eventButton(event);
                  }
                },
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No events saved",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Settings > General > Dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _disabledServiceEvent(DashboardEvent event, String message) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(event.title),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventButton(DashboardEvent event) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 12),
          backgroundColor: event.color,
        ),
        onPressed: () {
          dashboardEvents[event.event]?.action(event.customValue);
        },
        child: Text(
          event.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _eventSlider(DashboardEvent event) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(event.title),
          Obx(
            () => Slider(
              value: dashboardEvents[event.event]?.value.value,
              inactiveColor: event.color.withOpacity(0.5),
              activeColor: event.color,
              onChanged: (double value) {
                dashboardEvents[event.event]?.action(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventToggle(DashboardEvent event) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(event.title),
          Obx(
            () => Switch(
              value: dashboardEvents[event.event]?.value.value,
              onChanged: (bool value) {
                dashboardEvents[event.event]?.action(value);
                dashboardEvents[event.event]?.value.refresh();
              },
              activeColor: event.color,
            ),
          ),
        ],
      ),
    );
  }

  bool isDashboardServiceEnabled(DashboardEvent event) {
    switch (dashboardEvents[event.event]?.provider) {
      case DashboardActionsProvider.obs:
        if (Get.isRegistered<ObsTabViewController>()) {
          if (Get.find<ObsTabViewController>().isConnected.value) {
            return true;
          }
        }
        break;
      case DashboardActionsProvider.streamElements:
        if (Get.isRegistered<StreamelementsViewController>()) {
          return true;
        }
        break;
      case DashboardActionsProvider.twitch:
        return true;

      case DashboardActionsProvider.custom:
        return true;
      default:
        return false;
    }
    return false;
  }
}
