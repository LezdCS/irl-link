import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/print_duration.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';

Widget hypeTrain(
  BuildContext context,
  TwitchHypeTrain? hypetrain,
  Duration? remainingTime,
) {
  if (hypetrain == null || hypetrain.id == '') {
    return Container();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text('LVL ${hypetrain.level}'),
          ),
          const SizedBox(
            width: 10,
          ),
          Text('hype_train'.tr),
        ],
      ),
      Text('${hypetrain.progress}%'),
      Text(
        printDuration(
          remainingTime ?? Duration.zero,
        ),
      ),
    ],
  );
}
