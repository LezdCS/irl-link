import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class RealtimeIrl extends GetView {
  const RealtimeIrl({
    super.key,
    required this.controller,
  });

  @override
  final SettingsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Icon(
              Icons.map,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Realtime IRL',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.rtIrlInputController,
                  obscureText: !controller.rtIrlKeyShow.value,
                  onChanged: (value) {
                    controller.homeViewController.settings.value =
                        controller.homeViewController.settings.value.copyWith(
                      rtIrlPushKey: value,
                    );
                    controller.saveSettings();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                    hintText: 'Push Key',
                    labelText: 'Push Key',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(controller.rtIrlKeyShow.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Theme.of(context).primaryIconTheme.color,
                      onPressed: () {
                        controller.rtIrlKeyShow.value =
                            !controller.rtIrlKeyShow.value;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
