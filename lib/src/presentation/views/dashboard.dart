import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/twitch_tab_view_controller.dart';

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
        child: controller.dashboardEvents.isNotEmpty
            ? GridView.builder(
                itemCount: controller.dashboardEvents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 1.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  DashboardEvent event = controller.dashboardEvents[index];
                  // Check if the event is still supported
                  if (event.event == SupportedEvents.none) {
                    return _disabledServiceEvent(
                      event,
                      "event_discontinued".tr,
                    );
                  }
                  // Check if the service is enabled
                  bool isServiceEnabled = isDashboardServiceEnabled(event);
                  if (!isServiceEnabled) {
                    return _disabledServiceEvent(event, "service_disabled".tr);
                  }
                  switch (event.dashboardActionsType) {
                    case DashboardActionsTypes.button:
                      return _eventButton(event);
                    case DashboardActionsTypes.slider:
                      return _eventSlider(event);
                    case DashboardActionsTypes.toggle:
                      return _eventToggle(event);
                  }
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "events_empty".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
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
              inactiveColor: event.color.withValues(alpha: 0.5),
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
              activeThumbColor: event.color,
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
      case DashboardActionsProvider.streamElements:
        if (Get.isRegistered<StreamelementsViewController>()) {
          return true;
        }
      case DashboardActionsProvider.twitch:
        if (Get.isRegistered<TwitchTabViewController>()) {
          return true;
        }

      case DashboardActionsProvider.kick:
        if (Get.isRegistered<KickTabViewController>()) {
          return true;
        }

      case DashboardActionsProvider.custom:
        return true;
      default:
        return false;
    }
    return false;
  }
}
