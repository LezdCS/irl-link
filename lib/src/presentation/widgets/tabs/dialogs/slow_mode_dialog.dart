import 'package:flutter/material.dart';

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

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(slowModeValues.length, (index) {
          return InkWell(
            onTap: () => controller.toggleSlowMode(
              slowModeValues[index].values.first,
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.only(
                  left: 5, right: 5, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: Color(0xFF121212),
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
  );
}
