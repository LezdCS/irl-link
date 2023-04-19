import 'package:flutter/material.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:get/get.dart';

class Tts extends StatelessWidget {
  final SettingsViewController controller;

  const Tts({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
            "text_to_speech".tr,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "enable_tts".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      value: controller.settings.value.ttsEnabled!,
                      onChanged: (value) {
                        controller.settings.value = controller.settings.value
                            .copyWith(ttsEnabled: value);
                        controller.saveSettings();
                      },
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      activeTrackColor: Theme.of(context).colorScheme.tertiary,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "language".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                      value: controller.ttsLanguages.firstWhere(
                        (element) =>
                            element == controller.settings.value.language,
                      ),
                      onChanged: (value) {
                        controller.settings.value = controller.settings.value
                            .copyWith(language: value.toString());
                        controller.saveSettings();
                      },
                      items: List.generate(
                        controller.ttsLanguages.length,
                        (index) => DropdownMenuItem(
                          value: controller.ttsLanguages[index],
                          child: Text(
                            controller.ttsLanguages[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "voice".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                      value: controller.ttsVoices.firstWhere(
                        (element) =>
                            element["name"] ==
                            controller.settings.value.voice!["name"],
                      ),
                      onChanged: (Object? value) {
                        Map<String, String> voice = {
                          "name": (value as Map)["name"],
                          "locale": (value)["locale"],
                        };
                        controller.settings.value =
                            controller.settings.value.copyWith(voice: voice);
                        controller.saveSettings();
                      },
                      items: List.generate(
                        controller.ttsVoices.length,
                        (index) => DropdownMenuItem(
                          value: controller.ttsVoices[index],
                          child: Text(controller.ttsVoices[index]["name"]),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Volume",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    Slider(
                      value: controller.settings.value.volume!,
                      onChanged: (value) {
                        controller.settings.value =
                            controller.settings.value.copyWith(volume: value);
                        controller.saveSettings();
                      },
                      max: 1,
                      min: 0,
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      inactiveColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "speech_rate".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    Slider(
                      value: controller.settings.value.rate!,
                      onChanged: (value) {
                        controller.settings.value =
                            controller.settings.value.copyWith(rate: value);
                        controller.saveSettings();
                      },
                      max: 1,
                      min: 0,
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      inactiveColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "pitch".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 18,
                      ),
                    ),
                    Slider(
                      value: controller.settings.value.pitch!,
                      onChanged: (value) {
                        controller.settings.value =
                            controller.settings.value.copyWith(pitch: value);
                        controller.saveSettings();
                      },
                      max: 1,
                      min: 0,
                      activeColor: Theme.of(context).colorScheme.tertiary,
                      inactiveColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    )
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    _dialogAddIgnoredPrefixs(
                      controller,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "prefixs_ignored".tr,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "prefixs_ignored_details".tr,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _dialogAddAllowedPrefixs(
                      controller,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "prefixs_allowed".tr,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "prefixs_allowed_details".tr,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _dialogAddUsers(
                      controller,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ignored_users".tr,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "ignored_users_details".tr,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dialogAddUsers(
    SettingsViewController controller,
  ) {
    Get.defaultDialog(
      title: "Ignored users",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Color(0xFF0e0e10),
      buttonColor: Color(0xFF9147ff),
      cancelTextColor: Color(0xFF9147ff),
      textCancel: "Back",
      radius: 10,
      content: Obx(
        () => Column(
          children: [
            Text(
              "Users that will not be read aloud.",
              style: TextStyle(color: Colors.grey[400]),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.settings.value.ttsUsersToIgnore!.length,
              itemBuilder: (context, index) {
                return Chip(
                  onDeleted: () {
                    controller.settings.value.ttsUsersToIgnore!.removeAt(index);
                    controller.settings.value = controller.settings.value
                        .copyWith(
                            ttsUsersToIgnore:
                                controller.settings.value.ttsUsersToIgnore!);
                    controller.settings.refresh();
                    controller.saveSettings();
                  },
                  label:
                      Text(controller.settings.value.ttsUsersToIgnore![index]),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: controller.addTtsIgnoredUsersController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      hintText: 'Username',
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                      onPressed: () {
                        controller.settings.value.ttsUsersToIgnore!.add(
                            controller.addTtsIgnoredUsersController.text
                                .trim());
                        controller.settings.value = controller.settings.value
                            .copyWith(
                                ttsUsersToIgnore: controller
                                    .settings.value.ttsUsersToIgnore!);
                        controller.settings.refresh();
                        controller.addTtsIgnoredUsersController.clear();
                        controller.saveSettings();
                      },
                      child: Text(
                        "add".tr,
                        style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _dialogAddIgnoredPrefixs(
    SettingsViewController controller,
  ) {
    Get.defaultDialog(
      title: "Ignored prefixs",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Color(0xFF0e0e10),
      buttonColor: Color(0xFF9147ff),
      cancelTextColor: Color(0xFF9147ff),
      textCancel: "Back",
      radius: 10,
      content: Obx(
        () => Column(
          children: [
            Text(
              "Message starting with these prefixs will not be read aloud.",
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.settings.value.prefixsToIgnore!.length,
              itemBuilder: (context, index) {
                return Chip(
                  onDeleted: () {
                    controller.settings.value.prefixsToIgnore!.removeAt(index);
                    controller.settings.value = controller.settings.value
                        .copyWith(
                            prefixsToIgnore:
                                controller.settings.value.prefixsToIgnore!);
                    controller.settings.refresh();
                    controller.saveSettings();
                  },
                  label:
                      Text(controller.settings.value.prefixsToIgnore![index]),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: controller.addTtsIgnoredPrefixsController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      hintText: 'Prefix',
                      labelText: 'Prefix',
                      labelStyle: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                      onPressed: () {
                        controller.settings.value.prefixsToIgnore!.add(
                            controller.addTtsIgnoredPrefixsController.text
                                .trim());
                        controller.settings.value = controller.settings.value
                            .copyWith(
                                prefixsToIgnore:
                                    controller.settings.value.prefixsToIgnore!);
                        controller.settings.refresh();
                        controller.addTtsIgnoredPrefixsController.clear();
                        controller.saveSettings();
                      },
                      child: Text(
                        "add".tr,
                        style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _dialogAddAllowedPrefixs(
      SettingsViewController controller,
      ) {
    Get.defaultDialog(
      title: "Allowed prefixs",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Color(0xFF0e0e10),
      buttonColor: Color(0xFF9147ff),
      cancelTextColor: Color(0xFF9147ff),
      textCancel: "Back",
      radius: 10,
      content: Obx(
            () => Column(
          children: [
            Text(
              "Only messages starting with these prefixs will be read aloud.",
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.settings.value.prefixsToUseTtsOnly!.length,
              itemBuilder: (context, index) {
                return Chip(
                  onDeleted: () {
                    controller.settings.value.prefixsToUseTtsOnly!.removeAt(index);
                    controller.settings.value = controller.settings.value
                        .copyWith(
                        prefixsToUseTtsOnly:
                        controller.settings.value.prefixsToUseTtsOnly!);
                    controller.settings.refresh();
                    controller.saveSettings();
                  },
                  label:
                  Text(controller.settings.value.prefixsToUseTtsOnly![index]),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: controller.addTtsAllowedPrefixsController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      hintText: 'Prefix',
                      labelText: 'Prefix',
                      labelStyle: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                        Theme.of(Get.context!).colorScheme.tertiary,
                      ),
                      onPressed: () {
                        controller.settings.value.prefixsToUseTtsOnly!.add(
                            controller.addTtsAllowedPrefixsController.text
                                .trim());
                        controller.settings.value = controller.settings.value
                            .copyWith(
                            prefixsToUseTtsOnly:
                            controller.settings.value.prefixsToUseTtsOnly!);
                        controller.settings.refresh();
                        controller.addTtsAllowedPrefixsController.clear();
                        controller.saveSettings();
                      },
                      child: Text(
                        "add".tr,
                        style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
