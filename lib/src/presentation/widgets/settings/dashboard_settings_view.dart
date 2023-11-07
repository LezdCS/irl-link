import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class DashboardSettingsView extends GetView<SettingsViewController> {
  const DashboardSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find<DashboardController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            onPressed: () => Get.back(),
          ),
          actions: const [],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Dashboard events",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dashboardController.userEvents.length,
                itemBuilder: (context, index) {
                  DashboardEvent event = dashboardController.userEvents[index];
                  ExistingDashboardEvent? eventDetails = dashboardEvents[event.event];
                  return Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: event.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          event.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                         Text(
                          eventDetails?.provider.toString() ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    content: _addDialog(context, controller),
                    title: "add".tr,
                    textCancel: "cancel".tr,
                    textConfirm: "add".tr,
                    titleStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    buttonColor: const Color(0xFF9147ff),
                    cancelTextColor: const Color(0xFF9147ff),
                    confirmTextColor: Colors.white,
                    radius: 10,
                    onConfirm: () {
                      controller.addBrowserTab();
                    },
                  );
                },
                child: const Text('New event'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _addDialog(context, SettingsViewController controller) {
  String title = '';
  SupportedEvents selectedEvent = SupportedEvents.none;
  DashboardActionsTypes? selectedType;
  dynamic customValue = '';
  final formKey = GlobalKey<FormState>();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[700]!,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                hintText: 'Event title',
                labelText: 'Event title',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: ((value) => title = value),
            ),
            DropdownButtonFormField(
              hint: const Text('Event'),
              items: dashboardEvents.entries.map((entry) {
                return DropdownMenuItem(
                  child: Text(entry.value.toString()),
                );
              }).toList(),
              onChanged: (obj) {
                selectedEvent = obj as SupportedEvents;
              },
            ),
            DropdownButtonFormField(
              hint: const Text('Type of input'),
              items: dashboardEvents[dashboardEvents.keys
                  .firstWhereOrNull(
                      (element) => element == selectedEvent)]?.actionsAllowed
                  .map((DashboardActionsTypes type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString()),
                );
              }).toList(),
              onChanged: (type) {
                selectedType = type as DashboardActionsTypes;
              },
            ),
            Visibility(
              visible: selectedEvent == SupportedEvents.twitchChatMessage,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  customValue = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate() && selectedType != null) {
                  DashboardEvent newEvent = DashboardEvent(
                    title: title,
                    event: selectedEvent,
                    dashboardActionsType: selectedType!,
                    color: Colors.red,
                    customValue: customValue,
                  );
                  controller.addDashboardEvent(newEvent);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ],
  );
}
