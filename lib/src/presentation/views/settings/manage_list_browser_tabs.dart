import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/settings/browser_settings_controller.dart';

class ManageListBrowserTabs extends GetView<BrowserSettingsController> {
  const ManageListBrowserTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              onPressed: () => Get.back(),
            ),
            actions: const [],
            title: Text(
              "manage_browser_tabs".tr,
            ),
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                ReorderableListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 18,
                    right: 18,
                    bottom: 8,
                  ),
                  itemCount: controller.browserTabs.length,
                  onReorder: (int oldIndex, int newIndex) {
                    // TODO(LezdCS): Implement reordering
                    // if (newIndex > oldIndex) {
                    //   newIndex -= 1;
                    // }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    BrowserTab elem = controller.browserTabs[index];
                    return Dismissible(
                      key: ValueKey(elem),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            Text(
                              'edit'.tr,
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
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
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          bool delete = false;
                          await Get.defaultDialog(
                            content: Container(),
                            title: 'delete'.tr,
                            textCancel: "cancel".tr,
                            textConfirm: "confirm".tr,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            buttonColor: const Color(0xFF9147ff),
                            cancelTextColor: const Color(0xFF9147ff),
                            confirmTextColor: Colors.white,
                            radius: 10,
                            onConfirm: () {
                              controller.removeBrowserTab(elem);
                              delete = true;
                            },
                          );
                          return delete;
                        } else if (direction == DismissDirection.startToEnd) {
                          bool edit = false;
                          await Get.defaultDialog(
                            content: _editDialog(
                              context,
                              controller,
                              elem,
                            ),
                            title: "edit".tr,
                            textCancel: "cancel".tr,
                            textConfirm: "confirm".tr,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            buttonColor: const Color(0xFF9147ff),
                            cancelTextColor: const Color(0xFF9147ff),
                            confirmTextColor: Colors.white,
                            radius: 10,
                            onConfirm: () {
                              controller.editBrowserTab(elem);
                              edit = true;
                            },
                          );
                          return edit;
                        }
                        return false;
                      },
                      onDismissed: (direction) {
                        // Actions are handled in the dialog confirmations
                        // This callback is kept empty to prevent duplicate actions
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          elem.title,
                        ),
                      ),
                    );
                  },
                ),
                _addGroupButton(context, controller),
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
  BrowserSettingsController controller,
) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('new_browser_tab'.tr),
          const Icon(Icons.add),
        ],
      ),
    ),
  );
}

Widget _addDialog(BuildContext context, BrowserSettingsController controller) {
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
          textInputAction: TextInputAction.next,
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
          textInputAction: TextInputAction.done,
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
          Text(
            "enabled".tr,
            style: const TextStyle(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "is_audio_source".tr,
                  style: const TextStyle(
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
            const Text(
              "On iOS we have limitations with the tabs, only the focused one can play audio, so to bypass this issue you can select this option to make this as an audio source. You wont be able to interact with this tab, but it will play audio.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _editDialog(
  BuildContext context,
  BrowserSettingsController controller,
  BrowserTab elem,
) {
  controller.addBrowserUrlController.text = elem.url;
  controller.addBrowserTitleController.text = elem.title;
  controller.addBrowserToggled.value = elem.toggled;
  controller.addBrowserAudioSourceToggled.value = elem.iOSAudioSource;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Form(
        key: controller.addBrowserTitleKey,
        child: TextFormField(
          controller: controller.addBrowserTitleController,
          textInputAction: TextInputAction.next,
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
          textInputAction: TextInputAction.done,
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
          Text(
            "enabled".tr,
            style: const TextStyle(
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
            Text(
              "is_audio_source".tr,
              style: const TextStyle(
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
