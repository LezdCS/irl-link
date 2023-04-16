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
            "Text To Speech",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Activate TTS",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                    value: controller.settings.value.ttsEnabled!,
                    onChanged: (value) {
                      controller.settings.value =
                          controller.settings.value.copyWith(ttsEnabled: value);
                      controller.saveSettings();
                    },
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    activeTrackColor: Theme.of(context).colorScheme.tertiary,
                    activeColor: Colors.white,
                  ),
                ],
              ),
              //prefixs to ignore
              //prefixs to use TTS only
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
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
                      controller.settings.value =
                          controller.settings.value.copyWith(language: value.toString());
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
                    "Voice",
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
                    "Speech rate",
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
                    "Pitch",
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
            ],
          ),
        ),
      ),
    );
  }
}
