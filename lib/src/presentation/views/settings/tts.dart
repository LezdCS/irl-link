import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class Tts extends GetView<SettingsViewController> {
  const Tts({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsService settingsService = Get.find<SettingsService>();
    final TtsService ttsService = Get.find<TtsService>();
    return Obx(
      () {
        Settings settings = settingsService.settings.value;
        List<dynamic> ttsVoicesFiltered =
            controller.getVoiceForLanguage(settings.ttsSettings.language);
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
                        value: settings.ttsSettings.ttsEnabled,
                        onChanged: (value) {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings
                                .copyWith(ttsEnabled: value),
                          );
                          settingsService.saveSettings();
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
                          (element) => element == settings.ttsSettings.language,
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
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              language: value.toString(),
                              voice: voice,
                            ),
                          );
                          await settingsService.saveSettings();
                          ttsService.updateSettings(settings);
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
                                settings.ttsSettings.voice["name"],
                          ),
                          hint: const Text("Select a voice"),
                          onChanged: (Object? value) async {
                            Map<String, String> voice = {
                              "name": (value as Map)["name"],
                              "locale": value["locale"],
                            };
                            settingsService.settings.value = settings.copyWith(
                              ttsSettings:
                                  settings.ttsSettings.copyWith(voice: voice),
                            );
                            await settingsService.saveSettings();
                            ttsService.updateSettings(settings);
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
                        value: settings.ttsSettings.volume,
                        onChanged: (value) async {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings:
                                settings.ttsSettings.copyWith(volume: value),
                          );
                          await settingsService.saveSettings();
                          ttsService.updateSettings(settings);
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
                        value: settings.ttsSettings.rate,
                        onChanged: (value) async {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings:
                                settings.ttsSettings.copyWith(rate: value),
                          );
                          await settingsService.saveSettings();
                          ttsService.updateSettings(settings);
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
                        value: settings.ttsSettings.pitch,
                        onChanged: (value) async {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings:
                                settings.ttsSettings.copyWith(pitch: value),
                          );
                          await settingsService.saveSettings();
                          ttsService.updateSettings(settings);
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
                        value: settings.ttsSettings.ttsMuteViewerName,
                        onChanged: (value) {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings
                                .copyWith(ttsMuteViewerName: value),
                          );
                          settingsService.saveSettings();
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
                        value: settings.ttsSettings.ttsOnlyVip,
                        onChanged: (value) {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings
                                .copyWith(ttsOnlyVip: value),
                          );
                          settingsService.saveSettings();
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
                        value: settings.ttsSettings.ttsOnlyMod,
                        onChanged: (value) {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings
                                .copyWith(ttsOnlyMod: value),
                          );
                          settingsService.saveSettings();
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
                        value: settings.ttsSettings.ttsOnlySubscriber,
                        onChanged: (value) {
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings
                                .copyWith(ttsOnlySubscriber: value),
                          );
                          settingsService.saveSettings();
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
                        list: settings.ttsSettings.prefixsToIgnore,
                        onDeleted: (index) {
                          settings.ttsSettings.prefixsToIgnore.removeAt(index);
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              prefixsToIgnore:
                                  settings.ttsSettings.prefixsToIgnore,
                            ),
                          );
                          settingsService.saveSettings();
                          controller.nothingJustToRefreshDialog.refresh();
                        },
                        controller: controller,
                        textFieldController:
                            controller.addTtsIgnoredPrefixsController,
                        onAdd: () {
                          settings.ttsSettings.prefixsToIgnore.add(
                            controller.addTtsIgnoredPrefixsController.text
                                .trim(),
                          );
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              prefixsToIgnore:
                                  settings.ttsSettings.prefixsToIgnore,
                            ),
                          );
                          controller.addTtsIgnoredPrefixsController.clear();
                          settingsService.saveSettings();
                          controller.nothingJustToRefreshDialog.refresh();
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
                        list: settings.ttsSettings.prefixsToUseTtsOnly,
                        onDeleted: (index) {
                          settings.ttsSettings.prefixsToUseTtsOnly
                              .removeAt(index);
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              prefixsToUseTtsOnly:
                                  settings.ttsSettings.prefixsToUseTtsOnly,
                            ),
                          );
                          controller.nothingJustToRefreshDialog.refresh();
                          settingsService.saveSettings();
                        },
                        controller: controller,
                        textFieldController:
                            controller.addTtsAllowedPrefixsController,
                        onAdd: () {
                          settings.ttsSettings.prefixsToUseTtsOnly.add(
                            controller.addTtsAllowedPrefixsController.text
                                .trim(),
                          );
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              prefixsToUseTtsOnly:
                                  settings.ttsSettings.prefixsToUseTtsOnly,
                            ),
                          );
                          controller.nothingJustToRefreshDialog.refresh();
                          controller.addTtsAllowedPrefixsController.clear();
                          settingsService.saveSettings();
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
                        list: settings.ttsSettings.ttsUsersToIgnore,
                        onDeleted: (index) {
                          settings.ttsSettings.ttsUsersToIgnore.removeAt(index);
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              ttsUsersToIgnore:
                                  settings.ttsSettings.ttsUsersToIgnore,
                            ),
                          );
                          settingsService.saveSettings();
                          controller.nothingJustToRefreshDialog.refresh();
                        },
                        controller: controller,
                        textFieldController:
                            controller.addTtsIgnoredUsersController,
                        onAdd: () {
                          settings.ttsSettings.ttsUsersToIgnore.add(
                            controller.addTtsIgnoredUsersController.text.trim(),
                          );
                          settingsService.settings.value = settings.copyWith(
                            ttsSettings: settings.ttsSettings.copyWith(
                              ttsUsersToIgnore:
                                  settings.ttsSettings.ttsUsersToIgnore,
                            ),
                          );
                          controller.addTtsIgnoredUsersController.clear();
                          settingsService.saveSettings();
                          controller.nothingJustToRefreshDialog.refresh();
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
      content: Obx(
        () => Column(
          children: [
            Text(
              description,
              style:
                  TextStyle(color: controller.nothingJustToRefreshDialog.value),
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
      ),
    );
  }
}
