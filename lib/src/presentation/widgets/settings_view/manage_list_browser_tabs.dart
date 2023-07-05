import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Manage browser tabs",
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
              Container(
                child: controller
                        .homeViewController.settings.value.browserTabs!.isEmpty
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Nothing in the list!",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
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
                            child: ListTile(
                              title: Text(elem['title']),
                              trailing:
                                  !controller.browserTabsSelected.contains(elem)
                                      ? InkWell(
                                          onTap: () =>
                                              controller.removeBrowserTab(elem),
                                          child: const Icon(Icons.close),
                                        )
                                      : null,
                              selected: false,
                              iconColor: Colors.red[800],
                              onLongPress: () => {
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
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            content: _addDialog(context, controller),
                            title: "add".tr,
                            textCancel: "cancel".tr,
                            textConfirm: "add".tr,
                            titleStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            buttonColor: const Color(0xFF9147ff),
                            cancelTextColor: const Color(0xFF9147ff),
                            confirmTextColor: Colors.white,
                            radius: 10,
                            onConfirm: () {
                              controller.addBrowserTab();
                            },
                          );
                        },
                        child: Text(
                          "add".tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _addDialog(context, SettingsViewController controller) {
  controller.addBrowserUrlController.text = '';
  controller.addBrowserTitleController.text = '';
  controller.addBrowserToggled.value = true;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: controller.addBrowserTitleKey,
        child: TextFormField(
          controller: controller.addBrowserTitleController,
          textInputAction: TextInputAction.send,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            enabledBorder: Theme.of(context).inputDecorationTheme.border,
            hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16),
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
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
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          maxLines: 1,
          textCapitalization: TextCapitalization.none,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            enabledBorder: Theme.of(context).inputDecorationTheme.border,
            hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16),
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            hintText: 'Tab url',
            labelText: 'URL',
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Enabled",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 18,
            ),
          ),
          Obx(
            () => Switch(
              value: controller.addBrowserToggled.value,
              onChanged: (value) {
                controller.addBrowserToggled.value = value;
              },
              inactiveTrackColor:
                  Theme.of(context).colorScheme.tertiaryContainer,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _editDialog(context, SettingsViewController controller, elem) {
  controller.addBrowserUrlController.text = elem['url'];
  controller.addBrowserTitleController.text = elem['title'];
  controller.addBrowserToggled.value = elem['toggled'] ?? true;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: controller.addBrowserTitleKey,
        child: TextFormField(
          controller: controller.addBrowserTitleController,
          textInputAction: TextInputAction.send,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            enabledBorder: Theme.of(context).inputDecorationTheme.border,
            hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16),
            hintText: 'Tab title',
            labelText: 'Title',
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
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
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 1,
          textCapitalization: TextCapitalization.none,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            enabledBorder: Theme.of(context).inputDecorationTheme.border,
            hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16),
            hintText: 'Tab url',
            labelText: 'URL',
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Enabled",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 18,
            ),
          ),
          Obx(
            () => Switch(
              value: controller.addBrowserToggled.value,
              onChanged: (value) {
                controller.addBrowserToggled.value = value;
              },
              inactiveTrackColor:
                  Theme.of(context).colorScheme.tertiaryContainer,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );
}
