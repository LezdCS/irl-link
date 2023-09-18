import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import '../../domain/entities/settings/floating_event.dart';

class Dashboard extends GetView {
  @override
  final DashboardController controller;

  const Dashboard({
    super.key,
    required this.controller,
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
        child: GridView.builder(
          itemCount: controller.userEvents.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 1.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            FloatingEvent event = controller.userEvents[index];
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
        ),
      ),
    );
  }

  Widget _eventButton(FloatingEvent event) {
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
          dashboardEvents[event.event].action();
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

  Widget _eventSlider(FloatingEvent event) {
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
          Slider(
            value: 0.5,
            inactiveColor: event.color.withOpacity(0.5),
            activeColor: event.color,
            onChanged: (double value) {
              dashboardEvents[event.event].action(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _eventToggle(FloatingEvent event) {
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
          Switch(
            value: true,
            onChanged: (bool value) {
              dashboardEvents[event.event].action(value);
            },
            activeColor: event.color,
          ),
        ],
      ),
    );
  }
}
