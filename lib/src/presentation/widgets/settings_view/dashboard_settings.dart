import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class DashboardSettings extends GetView<SettingsViewController> {
  const DashboardSettings({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              Container(),
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

Widget _addDialog(context, channelTextController) {
  String title = '';
  SupportedEvents selectedEvent = SupportedEvents.none;
  DashboardActionsTypes? selectedType;
  String customValue = '';
  final formKey = GlobalKey<FormState>();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
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
                    value: entry.key, child: Text(entry.key));
              }).toList(),
              onChanged: (obj) {
                selectedEvent = obj as SupportedEvents;
              },
            ),
            DropdownButtonFormField(
              hint: const Text('Type of input'),
              items: dashboardEvents.keys
                  .firstWhereOrNull(
                      (element) => element == selectedEvent)['actionsAllowed']
                  .map((type) {
                return DropdownMenuItem(
                    value: type.key, child: Text(type.value));
              }),
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
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate() && selectedType != null) {
                  FloatingEvent newEvent = FloatingEvent(
                    title: title,
                    event: selectedEvent,
                    dashboardActionsType: selectedType!,
                    color: Colors.red,
                  );
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
