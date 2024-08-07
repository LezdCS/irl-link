import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../controllers/settings_view_controller.dart';

class ManageListBrowserTabs extends GetView {
  const ManageListBrowserTabs({
    super.key,
    required this.controller,
  });

  @override
  final SettingsViewController controller;

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
          actions: controller.browserTabsSelected.isNotEmpty
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      for (var tab in controller.browserTabsSelected) {
                        controller.removeBrowserTab(tab);
                      }
                      controller.browserTabsSelected.value = [];
                    },
                  )
                ]
              : const [],
          title: const Text(
            "Manage browser tabs",
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              Container(
                child: controller
                        .homeViewController.settings.value.browserTabs!.isEmpty
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text(
                          "Nothing in the list!",
                        ),
                      )
                    : ReorderableListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 8, left: 18, right: 18, bottom: 8),
                        itemCount: controller.homeViewController.settings.value
                            .browserTabs!.length,
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final element = controller
                              .homeViewController.settings.value.browserTabs!
                              .removeAt(oldIndex);
                          controller
                              .homeViewController.settings.value.browserTabs!
                              .insert(newIndex, element);
                          controller.saveSettings();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var elem = controller.homeViewController.settings
                              .value.browserTabs![index];
                          return Container(
                            key: ValueKey(controller.homeViewController.settings
                                .value.browserTabs![index]),
                            color: controller.browserTabsSelected.contains(elem)
                                ? Colors.red[800]
                                : Theme.of(context).colorScheme.secondary,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                elem['title'],
                              ),
                              trailing: !controller.browserTabsSelected
                                      .contains(elem)
                                  ? Wrap(
                                      children: [
                                        InkWell(
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.orange,
                                            size: 22,
                                          ),
                                          onTap: () {
                                            Get.defaultDialog(
                                              content: _editDialog(
                                                  context, controller, elem),
                                              title: 'Edit',
                                              textCancel: "cancel".tr,
                                              textConfirm: "confirm".tr,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              buttonColor:
                                                  const Color(0xFF9147ff),
                                              cancelTextColor:
                                                  const Color(0xFF9147ff),
                                              confirmTextColor: Colors.white,
                                              radius: 10,
                                              onConfirm: () {
                                                controller.editBrowserTab(elem);
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () => {
                                            Get.defaultDialog(
                                              content: Container(),
                                              title: 'Delete',
                                              textCancel: "cancel".tr,
                                              textConfirm: "confirm".tr,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              buttonColor:
                                                  const Color(0xFF9147ff),
                                              cancelTextColor:
                                                  const Color(0xFF9147ff),
                                              confirmTextColor: Colors.white,
                                              radius: 10,
                                              onConfirm: () {
                                                controller
                                                    .removeBrowserTab(elem);
                                              },
                                            )
                                          },
                                          child: const Icon(Icons.close),
                                        ),
                                      ],
                                    )
                                  : null,
                              selected: false,
                              iconColor: Colors.red[800],
                              onTap: () => {
                                if (controller.browserTabsSelected
                                    .contains(elem))
                                  {controller.browserTabsSelected.remove(elem)}
                                else
                                  {controller.browserTabsSelected.add(elem)}
                              },
                            ),
                          );
                        },
                      ),
              ),
              _addGroupButton(context, controller),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _addGroupButton(
    BuildContext context, SettingsViewController controller) {
  return InkWell(
    onTap: () {
      Get.defaultDialog(
        content: _addDialog(context, controller),
        title: "add".tr,
        textCancel: "cancel".tr,
        textConfirm: "add".tr,
        backgroundColor: Theme.of(context).colorScheme.surface,
        buttonColor: const Color(0xFF9147ff),
        cancelTextColor: const Color(0xFF9147ff),
        confirmTextColor: Colors.white,
        radius: 10,
        onConfirm: () {
          controller.addBrowserTab();
        },
      );
    },
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('New browser tab'),
          Icon(Icons.add),
        ],
      ),
    ),
  );
}

Widget _addDialog(context, SettingsViewController controller) {
  controller.addBrowserUrlController.text = '';
  controller.addBrowserTitleController.text = '';
  controller.addBrowserToggled.value = true;
  controller.addBrowserAudioSourceToggled.value = false;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: controller.addBrowserTitleKey,
        child: TextFormField(
          controller: controller.addBrowserTitleController,
          textInputAction: TextInputAction.send,
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            hintText: 'Tab title',
            labelText: 'Title',
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Form(
        key: controller.addBrowserUrlKey,
        child: TextFormField(
          controller: controller.addBrowserUrlController,
          textInputAction: TextInputAction.send,
          maxLines: 1,
          textCapitalization: TextCapitalization.none,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            hintText: 'Tab url',
            labelText: 'URL',
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Enabled",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Obx(
            () => Switch(
              value: controller.addBrowserToggled.value,
              onChanged: (value) {
                controller.addBrowserToggled.value = value;
              },
            ),
          ),
        ],
      ),
      Visibility(
        visible: Platform.isIOS,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Is an audio source",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Obx(
              () => Switch(
                value: controller.addBrowserAudioSourceToggled.value,
                onChanged: (value) {
                  controller.addBrowserAudioSourceToggled.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _editDialog(context, SettingsViewController controller, elem) {
  controller.addBrowserUrlController.text = elem['url'];
  controller.addBrowserTitleController.text = elem['title'];
  controller.addBrowserToggled.value = elem['toggled'] ?? true;
  controller.addBrowserAudioSourceToggled.value =
      elem['iOSAudioSource'] ?? false;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: controller.addBrowserTitleKey,
        child: TextFormField(
          controller: controller.addBrowserTitleController,
          textInputAction: TextInputAction.send,
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            hintText: 'Tab title',
            labelText: 'Title',
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Form(
        key: controller.addBrowserUrlKey,
        child: TextFormField(
          controller: controller.addBrowserUrlController,
          textInputAction: TextInputAction.send,
          maxLines: 1,
          textCapitalization: TextCapitalization.none,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            hintText: 'Tab url',
            labelText: 'URL',
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Enabled",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Obx(
            () => Switch(
              value: controller.addBrowserToggled.value,
              onChanged: (value) {
                controller.addBrowserToggled.value = value;
              },
            ),
          ),
        ],
      ),
      Visibility(
        visible: Platform.isIOS,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Is an audio source",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Obx(
              () => Switch(
                value: controller.addBrowserAudioSourceToggled.value,
                onChanged: (value) {
                  controller.addBrowserAudioSourceToggled.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
