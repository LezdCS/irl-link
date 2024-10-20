import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class DashboardSettingsView extends GetView<DashboardController> {
  const DashboardSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsViewController settingsViewController =
        Get.find<SettingsViewController>();

    return Obx(
      () {
        Settings settings = Get.find<SettingsService>().settings.value;
        return Scaffold(
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
                value: settings.dashboardSettings.activated,
                onChanged: (value) {
                  Get.find<SettingsService>().settings.value =
                      settings.copyWith(
                    dashboardSettings: settings.dashboardSettings.copyWith(
                      activated: value,
                    ),
                  );
                  Get.find<SettingsService>().saveSettings();
                },
              ),
            ],
            title: Text(
              "dashboard_events".tr,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                _addGroupButton(context, controller, settingsViewController),
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settings.dashboardSettings.userEvents.length,
                  itemBuilder: (context, index) {
                    DashboardEvent event =
                        settings.dashboardSettings.userEvents[index];
                    ExistingDashboardEvent? eventDetails =
                        dashboardEvents[event.event];
                    return Dismissible(
                      key: Key('${event.title}-$index'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Text('delete'.tr),
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) => Future.value(true),
                      onDismissed: (context) {
                        controller.removeDashboardEvent(event);
                      },
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
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _addGroupButton(
    BuildContext context,
    DashboardController dashboardController,
    SettingsViewController settingsViewController) {
  return InkWell(
    onTap: () {
      Get.defaultDialog(
        content: _addDialog(context, dashboardController),
        title: "new_event".tr,
        cancel: null,
        confirm: Container(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        buttonColor: const Color(0xFF9147ff),
        cancelTextColor: const Color(0xFF9147ff),
        confirmTextColor: Colors.white,
        radius: 10,
        onConfirm: () {
          settingsViewController.addBrowserTab();
        },
      );
    },
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("new_event".tr),
          const Icon(Icons.add),
        ],
      ),
    ),
  );
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
              hintText: "event_title".tr,
              labelText: "event_title".tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please_enter_text".tr;
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
              Widget? icon = getSupportedEventIcon(event);
              return DropdownMenuItem(
                value: event,
                child: Row(
                  children: [
                    icon ?? const SizedBox(),
                    icon != null
                        ? const SizedBox(
                            width: 8,
                          )
                        : const SizedBox(),
                    Text(
                      getSupportedEventString(event),
                    ),
                  ],
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == SupportedEvents.none) {
                return "please_select_event".tr;
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
              hint: Text("type_input".tr),
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
                  hintText: "your_message".tr,
                  labelText: "your_message".tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please_enter_text".tr;
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
            child: Text("submit".tr),
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
          title: "pick_color".tr,
          backgroundColor: Theme.of(Get.context!).colorScheme.surface,
          content: BlockPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
          ),
        );
      },
      // Row with circle showing currently selected color
      child: Row(
        children: [
          Text("background_color".tr),
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
