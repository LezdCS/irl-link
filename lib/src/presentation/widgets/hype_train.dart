import 'package:flutter/material.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';

Widget hypeTrain(
  BuildContext context,
  TwitchTabViewController controller,
) {
  return controller.twitchEventSub?.currentHypeTrain.value != null
      ? ValueListenableBuilder(
          valueListenable: controller.twitchEventSub!.currentHypeTrain,
          builder: (context, hypetrain, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Text('LVL ${hypetrain!.level}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Hype Train'),
                  ],
                ),
                Text('${hypetrain.progress}%'),
                Text(_printDuration(hypetrain.endsAt))
              ],
            );
          },
        )
      : Container();
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
