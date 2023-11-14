import 'dart:async';
import 'package:irllink/src/core/utils/convert_to_device_timezone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/print_duration.dart';
import 'package:irllink/src/domain/entities/twitch_poll.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget poll(
  BuildContext context,
  TwitchTabViewController controller,
  TwitchPoll poll,
) {
  if (poll.status == PollStatus.empty) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "No poll running",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }
  Rx<Duration> remainingTime = convertToDeviceTimezone(poll.endsAt).difference(DateTime.now()).obs;
  if(remainingTime.value.inSeconds > 0) {
    // Every 1 second, refresh remaining time
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        remainingTime.value = convertToDeviceTimezone(poll.endsAt).difference(DateTime.now());
        if (remainingTime.value.inSeconds <= 0) {
          timer.cancel();
        }
      },
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Poll",
        style: TextStyle(
          color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(poll.title),
          Text('Votes: ${poll.totalVotes}'),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: poll.choices.length,
            itemBuilder: (context, index) {
              final choice = poll.choices[index];
              final percentage =
                  poll.totalVotes > 0 ? choice.votes / poll.totalVotes : 0.0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    choice.title,
                    style: TextStyle(
                      color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    barRadius: const Radius.circular(8),
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    lineHeight: 20.0,
                    percent: percentage,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    progressColor: ((poll.status == PollStatus.completed) &&
                            percentage > 0.5)
                        ? Colors.green
                        : Theme.of(context).colorScheme.tertiaryContainer,
                    center: Text(
                        "${(percentage * 100).toStringAsFixed(2)} % (${choice.votes})"),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
          Obx(
            (() => Text('Ends in ${printDuration(remainingTime.value)}')),
          ),
          Visibility(
            visible: poll.status == PollStatus.active,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 12),
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                  onPressed: () {
                    controller.endPoll("ARCHIVED");
                  },
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 12),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    controller.endPoll("TERMINATED");
                  },
                  child: const Text(
                    'End',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
