import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class RealtimeIrl extends GetView<SettingsViewController> {
  const RealtimeIrl({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Settings settings = Get.find<SettingsService>().settings.value;

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
                    Get.find<SettingsService>().settings.value =
                        settings.copyWith(
                      rtIrlPushKey: value,
                    );
                    Get.find<SettingsService>().saveSettings();
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                    hintText: "push_key".tr,
                    labelText: "push_key".tr,
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
