import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class Tts extends GetView<SettingsViewController> {
  const Tts({super.key});

  @override
  Widget build(BuildContext context) {
    final TtsService ttsService = Get.find<TtsService>();

    TextEditingController addTtsIgnoredUsersController =
        TextEditingController();
    TextEditingController addTtsIgnoredPrefixsController =
        TextEditingController();
    TextEditingController addTtsAllowedPrefixsController =
        TextEditingController();

    if (controller.ttsSettings.value == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Obx(
      () {
        List<dynamic> ttsVoicesFiltered = controller
            .getVoiceForLanguage(controller.ttsSettings.value!.language);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
              "text_to_speech".tr,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  Visibility(
                    visible: Platform.isIOS,
                    child: const Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          color: Colors.amber,
                        ),
                        Expanded(
                          child: Text(
                            'If your device is currently in Silent Mode it could prevent the TTS to work.',
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "enable_tts".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: controller.ttsSettings.value!.ttsEnabled,
                        onChanged: (value) {
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsEnabled: value,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "language".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      DropdownButton(
                        value: ttsService.ttsLanguages.firstWhereOrNull(
                          (element) =>
                              element == controller.ttsSettings.value!.language,
                        ),
                        hint: const Text("Select a language"),
                        onChanged: (value) async {
                          dynamic firstVoiceForLanguage = controller
                              .getVoiceForLanguage(value.toString())
                              .first;
                          Map<String, String> voice = {
                            "name": firstVoiceForLanguage["name"],
                            "locale": firstVoiceForLanguage["locale"],
                          };
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            language: value.toString(),
                            voice: voice,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                        items: List.generate(
                          ttsService.ttsLanguages.length,
                          (index) => DropdownMenuItem(
                            value: ttsService.ttsLanguages[index],
                            child: Text(
                              ttsService.ttsLanguages[index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (Platform.isAndroid)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "voice".tr,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        DropdownButton(
                          value: ttsService.ttsVoices.firstWhereOrNull(
                            (element) =>
                                element["name"] ==
                                controller.ttsSettings.value!.voice["name"],
                          ),
                          hint: const Text("Select a voice"),
                          onChanged: (Object? value) async {
                            Map<String, String> voice = {
                              "name": (value as Map)["name"],
                              "locale": value["locale"],
                            };
                            TtsSettings ttsSettings = controller
                                .ttsSettings.value!
                                .copyWith(voice: voice);
                            controller.setTtsSettings(ttsSettings);
                          },
                          items: List.generate(
                            ttsVoicesFiltered.length,
                            (index) => DropdownMenuItem(
                              value: ttsVoicesFiltered[index],
                              child: Text(
                                ttsVoicesFiltered[index]["name"],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "volume".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Slider(
                        value: controller.ttsSettings.value!.volume,
                        onChanged: (value) async {
                          TtsSettings ttsSettings = controller
                              .ttsSettings.value!
                              .copyWith(volume: value);
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "speech_rate".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Slider(
                        value: controller.ttsSettings.value!.rate,
                        onChanged: (value) async {
                          TtsSettings ttsSettings = controller
                              .ttsSettings.value!
                              .copyWith(rate: value);
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "pitch".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Slider(
                        value: controller.ttsSettings.value!.pitch,
                        onChanged: (value) async {
                          TtsSettings ttsSettings = controller
                              .ttsSettings.value!
                              .copyWith(pitch: value);
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "mute_viewer_name".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: controller.ttsSettings.value!.ttsMuteViewerName,
                        onChanged: (value) {
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsMuteViewerName: value,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "only_read_vip".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: controller.ttsSettings.value!.ttsOnlyVip,
                        onChanged: (value) {
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsOnlyVip: value,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "only_read_mod".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: controller.ttsSettings.value!.ttsOnlyMod,
                        onChanged: (value) {
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsOnlyMod: value,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "only_read_sub".tr,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: controller.ttsSettings.value!.ttsOnlySubscriber,
                        onChanged: (value) {
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsOnlySubscriber: value,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _ttsDialog(
                        title: 'Ignored prefixs',
                        description:
                            'Message starting with these prefixs will not be read aloud.',
                        textFieldHint: 'Prefix',
                        list: controller.ttsSettings.value!.prefixsToIgnore,
                        onDeleted: (index) {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.prefixsToIgnore,
                          )..removeAt(index);
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            prefixsToIgnore: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                        controller: controller,
                        textFieldController: addTtsIgnoredPrefixsController,
                        onAdd: () {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.prefixsToIgnore,
                          )..add(
                              addTtsIgnoredPrefixsController.text.trim(),
                            );
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            prefixsToIgnore: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                          addTtsIgnoredPrefixsController.clear();
                        },
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
                                style: const TextStyle(
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
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _ttsDialog(
                        title: 'Allowed prefixs',
                        description:
                            'Only messages starting with these prefixs will be read aloud.',
                        textFieldHint: 'Prefix',
                        list: controller.ttsSettings.value!.prefixsToUseTtsOnly,
                        onDeleted: (index) {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.prefixsToUseTtsOnly,
                          )..removeAt(index);
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            prefixsToUseTtsOnly: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                        controller: controller,
                        textFieldController: addTtsAllowedPrefixsController,
                        onAdd: () {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.prefixsToUseTtsOnly,
                          )..add(
                              addTtsAllowedPrefixsController.text.trim(),
                            );
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            prefixsToUseTtsOnly: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                          addTtsAllowedPrefixsController.clear();
                        },
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
                                style: const TextStyle(
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
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _ttsDialog(
                        title: 'Ignored users',
                        description: 'Users that will not be read aloud.',
                        textFieldHint: 'Username',
                        list: controller.ttsSettings.value!.ttsUsersToIgnore,
                        onDeleted: (index) {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.ttsUsersToIgnore,
                          )..removeAt(index);
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsUsersToIgnore: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                        },
                        controller: controller,
                        textFieldController: addTtsIgnoredUsersController,
                        onAdd: () {
                          final updatedList = List<String>.from(
                            controller.ttsSettings.value!.ttsUsersToIgnore,
                          )..add(
                              addTtsIgnoredUsersController.text.trim(),
                            );
                          TtsSettings ttsSettings =
                              controller.ttsSettings.value!.copyWith(
                            ttsUsersToIgnore: updatedList,
                          );
                          controller.setTtsSettings(ttsSettings);
                          addTtsIgnoredUsersController.clear();
                        },
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
                              style: const TextStyle(
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
        );
      },
    );
  }

  void _ttsDialog({
    required String title,
    required String description,
    required String textFieldHint,
    required List list,
    required Function onDeleted,
    required TextEditingController textFieldController,
    required Function onAdd,
    required SettingsViewController controller,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: Theme.of(Get.context!).textTheme.bodyLarge,
      buttonColor: const Color(0xFF9147ff),
      cancelTextColor: const Color(0xFF9147ff),
      textCancel: "cancel".tr,
      radius: 10,
      content: Column(
        children: [
          Text(
            description,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: list.isNotEmpty,
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      onDeleted: () {
                        onDeleted(index);
                        Get.back();
                      },
                      label: Text(list[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: textFieldHint,
                    labelText: textFieldHint,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(Get.context!).colorScheme.tertiary,
                    ),
                    onPressed: () {
                      onAdd();
                      Get.back();
                    },
                    child: Text(
                      "add".tr,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
