import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/convert_to_device_timezone.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';
import 'package:irllink/src/domain/entities/twitch_prediction.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import '../../core/utils/twitch_event_sub.dart';
import '../../domain/entities/twitch_poll.dart';
import 'home_view_controller.dart';

class TwitchTabViewController extends GetxController {
  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;

  FocusNode focus = FocusNode();

  late HomeViewController homeViewController;

  Rx<TwitchStreamInfos> twitchStreamInfos =
      const TwitchStreamInfos.defaultInfos().obs;

  RxString selectedOutcomeId = "-1".obs;

  Timer? refreshDataTimer;
  Timer? refreshDataTimerProgressBar;
  Rx<Duration> myDuration = const Duration(seconds: 15).obs;

  TwitchEventSub? twitchEventSub;
  late Rx<Duration> remainingTimePoll;
  late Rx<Duration> remainingTimePrediction;
  late Rx<Duration> remainingTimeHypeTrain;

  @override
  void onInit() {
    homeViewController = Get.find<HomeViewController>();
    titleFormController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    if (homeViewController.twitchData != null) {
      refreshData();
      refreshDataTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
        refreshData();
      });
      twitchEventSub = TwitchEventSub(
        homeViewController.twitchData!.twitchUser.login,
        homeViewController.twitchData!.accessToken,
      );
      listenToPoll();
      listenToPrediction();

      twitchEventSub!.connect();
    }

    refreshDataTimerProgressBar =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      const reduceSecondsBy = 1;
      final seconds = myDuration.value.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        myDuration.value = const Duration(seconds: 15);
      } else {
        myDuration.value = Duration(seconds: seconds);
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    refreshDataTimer?.cancel();
    refreshDataTimerProgressBar?.cancel();
    super.onClose();
  }

  void listenToPoll() {
    Timer? timer;

    twitchEventSub?.currentPoll.listen((poll) {
      if (poll.status == PollStatus.active) {
        if (timer != null) timer?.cancel();
        remainingTimePoll =
            convertToDeviceTimezone(twitchEventSub!.currentPoll.value.endsAt)
                .difference(DateTime.now())
                .obs;
        if (remainingTimePoll.value.inSeconds > 0) {
          // Every 1 second, refresh remaining time
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              remainingTimePoll.value = convertToDeviceTimezone(poll.endsAt)
                  .difference(DateTime.now());
            },
          );
        }
      } else {
        timer?.cancel();
      }
    });
  }

  void listenToPrediction() {
    Timer? timer;

    twitchEventSub?.currentPrediction.listen((prediction) {
      if (prediction.status == PredictionStatus.active) {
        if (timer != null) timer?.cancel();
        remainingTimePrediction =
            convertToDeviceTimezone(prediction.remainingTime)
                .difference(DateTime.now())
                .obs;
        if (remainingTimePrediction.value.inSeconds > 0) {
          // Every 1 second, refresh remaining time
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              remainingTimePrediction.value =
                  convertToDeviceTimezone(prediction.remainingTime)
                      .difference(DateTime.now());
            },
          );
        }
      } else {
        timer?.cancel();
      }
    });
  }

  void listenToHypeTrain() {
    Timer? timer;

    twitchEventSub?.currentHypeTrain.addListener(() {
      TwitchHypeTrain train =
          twitchEventSub?.currentHypeTrain.value ?? TwitchHypeTrain.empty();

      if (train.id == '') {
        timer?.cancel();
        return;
      }

      if (timer != null) timer?.cancel();

      remainingTimeHypeTrain =
          convertToDeviceTimezone(train.endsAt).difference(DateTime.now()).obs;
      if (remainingTimeHypeTrain.value.inSeconds > 0) {
        // Every 1 second, refresh remaining time
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            remainingTimeHypeTrain.value = convertToDeviceTimezone(train.endsAt)
                .difference(DateTime.now());
          },
        );
      }
    });
  }

  void refreshData() {
    myDuration.value = const Duration(seconds: 15);
    if (homeViewController.twitchData == null) return;
    getStreamInfos();
  }

  void toggleFollowerOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isFollowerMode: !twitchStreamInfos.value.isFollowerMode!);
    changeChatSettings();
  }

  void toggleSubOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isSubscriberMode: !twitchStreamInfos.value.isSubscriberMode!);
    changeChatSettings();
  }

  void toggleEmoteOnly() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isEmoteMode: !twitchStreamInfos.value.isEmoteMode!);
    changeChatSettings();
  }

  void toggleSlowMode(int? time) {
    twitchStreamInfos.value = twitchStreamInfos.value.copyWith(
      isSlowMode: !twitchStreamInfos.value.isSlowMode!,
      slowModeWaitTime: time,
    );
    changeChatSettings();
  }

  void changeChatSettings() {
    if (homeViewController.twitchData == null) return;

    homeEvents.setChatSettings(homeViewController.twitchData!.accessToken,
        homeViewController.twitchData!.twitchUser.id, twitchStreamInfos.value);
  }

  void setStreamTitle() {
    if (homeViewController.twitchData == null) return;

    homeEvents.setStreamTitle(homeViewController.twitchData!.accessToken,
        homeViewController.twitchData!.twitchUser.id, titleFormController.text);
  }

  void createPoll(String question, List<Choice> choices) {
    TwitchPoll newPoll = TwitchPoll(
      id: "",
      title: "",
      choices: choices,
      status: PollStatus.active,
      totalVotes: 0,
      endsAt: DateTime.now(),
    );
    homeEvents.createPoll(homeViewController.twitchData!.accessToken,
        homeViewController.twitchData!.twitchUser.id, newPoll);
  }

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  void endPoll(String status) {
    homeEvents.endPoll(
      homeViewController.twitchData!.accessToken,
      homeViewController.twitchData!.twitchUser.id,
      twitchEventSub!.currentPoll.value.id,
      status,
    );
  }

  // status is either RESOLVED to end prediction with a winner (should provide winning_outcome_id)
  // or CANCELED to end the prediction and refund
  // or LOCKED to lock prediction so user can no longer make predictions
  void endPrediction(String status, String? winningOutcomeId) {
    homeEvents.endPrediction(
      homeViewController.twitchData!.accessToken,
      homeViewController.twitchData!.twitchUser.id,
      twitchEventSub!.currentPrediction.value.id,
      status,
      winningOutcomeId,
    );
  }

  void getStreamInfos() {
    homeEvents
        .getStreamInfo(
          homeViewController.twitchData!.accessToken,
          homeViewController.twitchData!.twitchUser.id,
        )
        .then(
          (value) => {
            if (value.data != null)
              {
                twitchStreamInfos.value = value.data!,
                if (!focus.hasFocus)
                  {
                    titleFormController.text = twitchStreamInfos.value.title!,
                  }
              },
          },
        );
  }
}
