import 'package:flutter/material.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';
import 'package:get/get.dart';

class Tts extends StatelessWidget {
  final SettingsViewController controller;

  const Tts({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  value: true,
                  onChanged: (value) {},
                  inactiveTrackColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  activeTrackColor: Theme.of(context).colorScheme.tertiary,
                  activeColor: Colors.white,
                ),
              ],
            ),
            //prefix to ignore
            //prefix to use TTS only
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
                DropdownMenu(dropdownMenuEntries: []),
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
                  value: 0.5,
                  onChanged: (value) {},
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
                  value: 0.5,
                  onChanged: (value) {},
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
                  value: 0.5,
                  onChanged: (value) {},
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
                  "Voice",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 18,
                  ),
                ),
                DropdownMenu(dropdownMenuEntries: []),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
