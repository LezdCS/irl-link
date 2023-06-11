import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_view_controller.dart';

class ChatsJoined extends GetView<SettingsViewController> {
  const ChatsJoined({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController channelTextController = TextEditingController();

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
            "Chats joined",
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
              Container(
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 10),
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.homeViewController.twitchData?.twitchUser
                                .login ??
                            '',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.hideMyself(!controller.homeViewController
                              .settings.value.chatSettings!.joinMyself);
                        },
                        child: Icon(
                          controller.homeViewController.settings.value
                                  .chatSettings!.joinMyself
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: controller.homeViewController.settings.value
                                  .chatSettings!.joinMyself
                              ? Colors.green
                              : Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 8, left: 18, right: 18, bottom: 8),
                itemCount: controller.homeViewController.settings.value
                    .chatSettings!.chatsJoined.length,
                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final element = controller.homeViewController.settings.value
                      .chatSettings!.chatsJoined
                      .removeAt(oldIndex);
                  controller.homeViewController.settings.value.chatSettings!
                      .chatsJoined
                      .insert(newIndex, element);
                },
                itemBuilder: (BuildContext context, int index) {
                  var elem = controller.homeViewController.settings.value
                      .chatSettings!.chatsJoined[index];

                  return Container(
                    key: ValueKey(
                      elem,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            elem,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.removeChatJoined(elem);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                              content:
                                  _addDialog(context, channelTextController),
                              title: "add".tr,
                              textCancel: "cancel".tr,
                              textConfirm: "add".tr,
                              titleStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              buttonColor: const Color(0xFF9147ff),
                              cancelTextColor: const Color(0xFF9147ff),
                              confirmTextColor: Colors.white,
                              radius: 10,
                              onConfirm: () {
                                List channels = controller
                                            .homeViewController
                                            .settings
                                            .value
                                            .chatSettings!
                                            .chatsJoined ==
                                        const []
                                    ? []
                                    : controller.homeViewController.settings
                                        .value.chatSettings!.chatsJoined;
                                channels.add(channelTextController.text.trim());
                                controller.homeViewController.settings.value =
                                    controller.homeViewController.settings.value
                                        .copyWith(
                                            chatSettings: controller
                                                .homeViewController
                                                .settings
                                                .value
                                                .chatSettings!
                                                .copyWith(
                                                    chatsJoined: channels));
                                controller.saveSettings();
                                controller.homeViewController.settings
                                    .refresh();
                                channelTextController.text = '';
                                Get.back();
                              },
                              onCancel: () {
                                channelTextController.text = '';
                              });
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

  Widget _addDialog(context, channelTextController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          child: TextFormField(
            controller: channelTextController,
            textInputAction: TextInputAction.send,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            maxLines: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the channel name';
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
              hintText: 'Channel name',
              labelText: 'Channel name',
            ),
          ),
        ),
      ],
    );
  }
}
