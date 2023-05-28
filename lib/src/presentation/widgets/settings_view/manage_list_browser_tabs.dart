import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_view_controller.dart';

class ManageListBrowserTabs extends GetView {
  ManageListBrowserTabs({
    required this.controller,
  });

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
          actions: [],
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
                child: controller.homeViewController.settings.value.browserTabs!
                            .length <=
                        0
                    ? Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Nothing in the list!",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      )
                    : ReorderableListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
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
                            key: ValueKey(
                              controller.homeViewController.settings.value
                                  .browserTabs![index],
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 10),
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                  content:
                                      _editDialog(context, controller, elem),
                                  title: "Edit",
                                  textCancel: "cancel".tr,
                                  textConfirm: "Confirm",
                                  titleStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  buttonColor: Color(0xFF9147ff),
                                  cancelTextColor: Color(0xFF9147ff),
                                  confirmTextColor: Colors.white,
                                  radius: 10,
                                  onConfirm: () {
                                    controller.editBrowserTab(elem);
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    elem['title'],
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () {
                                        controller.removeBrowserTab(elem);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
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
                            buttonColor: Color(0xFF9147ff),
                            cancelTextColor: Color(0xFF9147ff),
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

Widget _addDialog(context, controller) {
  controller.addBrowserUrlController.text = '';
  controller.addBrowserTitleController.text = '';
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
      SizedBox(
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
    ],
  );
}

Widget _editDialog(context, controller, elem) {
  controller.addBrowserUrlController.text = elem['url'];
  controller.addBrowserTitleController.text = elem['title'];
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
      SizedBox(
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
    ],
  );
}
