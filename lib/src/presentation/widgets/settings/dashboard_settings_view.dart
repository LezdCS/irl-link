import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          actions: [
            Switch(
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.white,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.tertiaryContainer,
              value: controller.homeViewController.settings.value
                  .dashboardSettings!.activated,
              onChanged: (value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  dashboardSettings: controller
                      .homeViewController.settings.value.dashboardSettings!
                      .copyWith(
                    activated: value,
                  ),
                );
                controller.saveSettings();
              },
            ),
          ],
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dashboardController.homeViewController.settings.value
                    .dashboardSettings!.userEvents.length,
                itemBuilder: (context, index) {
                  DashboardEvent event = dashboardController.homeViewController
                      .settings.value.dashboardSettings!.userEvents[index];
                  ExistingDashboardEvent? eventDetails =
                      dashboardEvents[event.event];
                  return Slidable(
                    key: Key('${event.title}-$index'),
                    // startActionPane: ActionPane(
                    //   motion: const ScrollMotion(),
                    //   extentRatio: 0.25,
                    //   children: [
                    //     SlidableAction(
                    //       backgroundColor:
                    //           Theme.of(context).colorScheme.background,
                    //       onPressed: (context) {},
                    //       icon: Icons.edit,
                    //       label: 'Edit',
                    //     ),
                    //   ],
                    // ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          onPressed: (context) {
                            dashboardController.removeDashboardEvent(event);
                          },
                          icon: Icons.delete,
                          label: 'Delete',
                          foregroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: Container(
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
                            getDashboardActionProviderString(
                              eventDetails?.provider,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    content: _addDialog(context, dashboardController),
                    title: "New event".tr,
                    cancel: null,
                    confirm: Container(),
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

Widget _addDialog(context, DashboardController dashboardController) {
  String title = '';
  Rx<SupportedEvents> selectedEvent = SupportedEvents.none.obs;
  DashboardActionsTypes? selectedType;
  dynamic customValue = '';
  Rx<Color> selectedColor = Colors.grey.obs;
  final formKey = GlobalKey<FormState>();
  return Obx(
    () => Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              hintText: 'Event title',
              labelText: 'Event title',
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
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
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            isExpanded: true,
            value: SupportedEvents.values[0],
            items: SupportedEvents.values.map((event) {
              return DropdownMenuItem(
                value: event,
                child: Text(
                  getSupportedEventString(event),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == SupportedEvents.none) {
                return 'Please select an event';
              }
              return null;
            },
            onChanged: (obj) {
              selectedEvent.value = obj as SupportedEvents;
              selectedType = dashboardEvents[dashboardEvents.keys
                      .firstWhereOrNull(
                          (element) => element == selectedEvent.value)]
                  ?.actionsAllowed[0];
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: selectedEvent.value != SupportedEvents.none,
            child: DropdownButtonFormField(
              isExpanded: true,
              hint: const Text('Type of input'),
              value: dashboardEvents[dashboardEvents.keys.firstWhereOrNull(
                      (element) => element == selectedEvent.value)]
                  ?.actionsAllowed[0],
              items: dashboardEvents[dashboardEvents.keys.firstWhereOrNull(
                      (element) => element == selectedEvent.value)]
                  ?.actionsAllowed
                  .map((DashboardActionsTypes type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    getDashboardActionTypeString(type),
                  ),
                );
              }).toList(),
              onChanged: (type) {
                selectedType = type as DashboardActionsTypes;
              },
            ),
          ),
          Visibility(
            visible: selectedEvent.value == SupportedEvents.twitchChatMessage,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  hintText: 'Your message',
                  labelText: 'Your message',
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
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
          ),
          const SizedBox(
            height: 10,
          ),
          colorPickerPreview(selectedColor.value, (Color color) {
            selectedColor.value = color;
            Get.back();
          }),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.tertiary,
              ),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                DashboardEvent newEvent = DashboardEvent(
                  title: title,
                  event: selectedEvent.value,
                  dashboardActionsType: selectedType!,
                  color: selectedColor.value,
                  customValue: customValue,
                );
                dashboardController.addDashboardEvent(newEvent);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    ),
  );
}

Widget colorPickerPreview(Color color, Function(Color) onColorChanged) {
  return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: 'Pick a color!',
          backgroundColor: Theme.of(Get.context!).colorScheme.background,
          content: BlockPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
          ),
        );
      },
      // Row with circle showing currently selected color
      child: Row(
        children: [
          const Text('Background color'),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              color: color,
              height: 20,
            ),
          ),
        ],
      ));
}
