import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import '../../domain/entities/settings/floating_event.dart';

class Dashboard extends GetView {
  final HomeViewController controller;

  Dashboard({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<FloatingEvent> events = [
      new FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.green,
        title: "Start stream",
      ),
      new FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.button,
        color: Colors.orange,
        title: "Clear TTS queue",
      ),
      new FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.slider,
        color: Colors.pink,
        title: "TTS volume",
      ),
      new FloatingEvent(
        dashboardActionsType: DashboardActionsTypes.toggle,
        color: Colors.blueAccent,
        title: "TTS enabled",
      ),
    ];
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 120,
      left: MediaQuery.of(context).size.width / 2 - 150,
      child: Container(
        width: 300,
        height: 234,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            color: context.theme.colorScheme.tertiary,
            width: 1,
          ),
        ),
        child: GridView.builder(
          itemCount: events.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2.3,
          ),
          itemBuilder: (BuildContext context, int index) {
            FloatingEvent event = events[index];
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
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:  Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: 12),
          backgroundColor: event.color,
        ),
        onPressed: () {},
        child: Text(
          event.title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _eventSlider(FloatingEvent event) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:  Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(event.title ?? ""),
          Slider(
            value: 0.5,
            inactiveColor: event.color.withOpacity(0.5),
            activeColor: event.color,
            onChanged: (double value) {},
          ),
        ],
      ),
    );
  }

  Widget _eventToggle(FloatingEvent event) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:  Theme.of(Get.context!).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(event.title ?? ""),
          Switch(
            value: true,
            onChanged: (bool value) {},
            activeColor: event.color,
          ),
        ],
      ),
    );
  }
}
