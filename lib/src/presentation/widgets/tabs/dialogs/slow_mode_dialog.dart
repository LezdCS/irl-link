import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/twitch_tab_view_controller.dart';

Widget slowModeDialog(
  BuildContext context,
  TwitchTabViewController controller,
) {
  final List<Map<String, int>> slowModeValues = [
    {"3s": 3},
    {"30s": 30},
    {"1m": 60},
    {"2m": 120},
  ];

  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Select a time',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(slowModeValues.length, (index) {
                  return InkWell(
                    onTap: () => {
                      controller
                          .toggleSlowMode(slowModeValues[index].values.first),
                      Get.back(),
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        slowModeValues[index].keys.first,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
