import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/print_duration.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget poll(
  BuildContext context,
  TwitchTabViewController controller,
) {
  TwitchPoll? poll = controller.twitchEventSub?.currentPoll.value;

  if (poll == null) {
    return Container();
  }

  if (poll.status == PollStatus.empty) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "poll_empty".tr,
        ),
      ],
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "poll".tr,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(poll.title),
          Text("votes_total".trParams({'total': poll.totalVotes.toString()})),
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
                    style: const TextStyle(
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
                      "${(percentage * 100).toStringAsFixed(2)} % (${choice.votes})",
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
          Obx(
            (() => Text(
                  "ends_in".trParams({
                    "time": printDuration(controller.remainingTimePoll.value)
                  }),
                )),
          ),
          Visibility(
            visible: poll.status == PollStatus.active,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
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
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    controller.endPoll("TERMINATED");
                  },
                  child: Text(
                    'end'.tr,
                    style: const TextStyle(
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
