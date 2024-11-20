import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/twitch_event_sub_service.dart';
import 'package:irllink/src/core/utils/print_duration.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget prediction(
  BuildContext context,
  TwitchPrediction? prediction,
) {
  if (prediction == null) {
    return Container();
  }

  if (prediction.status == PredictionStatus.empty) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "prediction_empty".tr,
        ),
      ],
    );
  }

  final twitchEventSubService = Get.find<TwitchEventSubService>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "prediction".tr,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prediction.title),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prediction.outcomes.length,
            itemBuilder: (context, index) {
              final outcome = prediction.outcomes[index];
              final percentage = prediction.totalUsers > 0
                  ? outcome.users / prediction.totalUsers
                  : 0.0;
              Widget svgPrediction = SvgPicture.asset(
                outcome.color == Colors.blue
                    ? './lib/assets/twitch/prediction-blue.svg'
                    : './lib/assets/twitch/prediction-pink.svg',
                semanticsLabel: 'prediction icon',
                width: 22,
                height: 22,
              );
              return Visibility(
                visible: (prediction.status == PredictionStatus.active ||
                    prediction.status == PredictionStatus.locked ||
                    (prediction.status == PredictionStatus.resolved &&
                        outcome.id == prediction.winningOutcomeId)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        svgPrediction,
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          prediction.status == PredictionStatus.resolved
                              ? "predition_winner".trParams(
                                  {"winner": outcome.title},
                                )
                              : outcome.title,
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                      progressColor: outcome.color,
                      center: Text(
                          "${(percentage * 100).toStringAsFixed(2)} % (${outcome.channelPoints} points)"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
          Obx(
            () => Text(
                '${prediction.status == PredictionStatus.active ? 'locks'.tr : 'ends'.tr} in ${printDuration(twitchEventSubService.remainingTimePrediction.value)}'),
          ),
          Visibility(
            visible: prediction.status != PredictionStatus.resolved &&
                prediction.status != PredictionStatus.canceled,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                  onPressed: () {
                    twitchEventSubService.endPrediction("CANCELED", null);
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
                    prediction.status == PredictionStatus.active
                        ? twitchEventSubService.endPrediction("LOCKED", null)
                        : pickWinnerDialog(
                            context,
                            prediction,
                            twitchEventSubService,
                          );
                  },
                  child: Text(
                    prediction.status == PredictionStatus.active
                        ? 'lock'.tr
                        : 'end'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

void pickWinnerDialog(
  BuildContext context,
  TwitchPrediction prediction,
  TwitchEventSubService twitchEventSubService,
) {
  Get.defaultDialog(
    title: prediction.title,
    titleStyle: const TextStyle(color: Colors.white),
    backgroundColor: const Color(0xFF282828),
    buttonColor: const Color(0xFF9147ff),
    cancelTextColor: const Color(0xFF9147ff),
    confirmTextColor: Colors.white,
    textCancel: "cancel".tr,
    textConfirm: "confirm".tr,
    radius: 10,
    onCancel: () {
      twitchEventSubService.selectedOutcomeId.value = "-1";
      Get.back();
    },
    onConfirm: () {
      twitchEventSubService.endPrediction(
          'RESOLVED', twitchEventSubService.selectedOutcomeId.value);
      twitchEventSubService.selectedOutcomeId.value = "-1";
      Get.back();
    },
    content: Obx(
      () => Column(
        children: List<Widget>.generate(
          prediction.outcomes.length,
          (int index) => ListTile(
            title: Text(prediction.outcomes[index].title),
            leading: Radio(
              value: prediction.outcomes[index].id,
              groupValue: twitchEventSubService.selectedOutcomeId.value,
              onChanged: (String? value) {
                twitchEventSubService.selectedOutcomeId.value = value!;
              },
              activeColor: Colors.green,
            ),
          ),
        ),
      ),
    ),
  );
}
