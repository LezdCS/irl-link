import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/twitch_stream_infos.dart';
import 'package:irllink/src/presentation/events/home_events.dart';

import '../../domain/entities/twitch_poll.dart';
import '../../domain/entities/twitch_prediction.dart';
import 'home_view_controller.dart';

class TwitchTabViewController extends GetxController {
  TwitchTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  late TextEditingController titleFormController;
  RxString streamTitle = "".obs;

  FocusNode focus = FocusNode();

  late HomeViewController homeViewController;
  RxBool isDemo = false.obs;

  Rx<TwitchStreamInfos> twitchStreamInfos =
      TwitchStreamInfos.defaultInfos().obs;

  late Rx<TwitchPrediction>? prediction;
  RxString selectedOutcomeId = "-1".obs;

  late Rx<TwitchPoll>? poll;

  Timer? refreshDataTimer;
  Timer? refreshDataTimerProgressBar;
  Rx<Duration> myDuration = const Duration(seconds: 15).obs;

  @override
  void onInit() {
    homeViewController = Get.find<HomeViewController>();
    titleFormController = TextEditingController();
    prediction = null;
    poll = null;

    super.onInit();
  }

  @override
  void onReady() async {
    if (homeViewController.twitchData != null) {
      refreshData();
      refreshDataTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
        refreshData();
      });
    } else {
      isDemo.value = true;
    }

    refreshDataTimerProgressBar = Timer.periodic(const Duration(seconds: 1), (timer) {
      final reduceSecondsBy = 1;
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

  void refreshData() {
    myDuration.value = const Duration(seconds: 15);
    if (homeViewController.twitchData == null) return;
    getStreamInfos();
    getPoll();
    getPrediction();
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

  void toggleSlowMode() {
    twitchStreamInfos.value = twitchStreamInfos.value
        .copyWith(isSlowMode: !twitchStreamInfos.value.isSlowMode!);
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

  void getPoll() {
    homeEvents
        .getPoll(homeViewController.twitchData!.accessToken,
            homeViewController.twitchData!.twitchUser.id)
        .then((value) => {
              if (value.error != null)
                {
                  poll = null,
                }
              else
                {
                  if (poll == null)
                    {
                      poll = value.data!.obs,
                    }
                  else
                    {
                      poll!.value = value.data!,
                    }
                }
            });
  }

  void createPoll(String question, List<Choice> choices) {
    TwitchPoll newPoll = TwitchPoll(
        id: "",
        title: "",
        choices: choices,
        status: PollStatus.ACTIVE,
        totalVotes: 0);
    homeEvents.createPoll(homeViewController.twitchData!.accessToken,
        homeViewController.twitchData!.twitchUser.id, newPoll);
    // .then((value) => {
    //       if (value.error != null)
    //         {
    //           poll = null,
    //         }
    //       else
    //         {
    //           if (poll == null)
    //             {
    //               poll = value.data!.obs,
    //             }
    //           else
    //             {
    //               poll!.value = value.data!,
    //             }
    //         }
    //     });
  }

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  void endPoll(String status) {
    homeEvents
        .endPoll(
            homeViewController.twitchData!.accessToken,
            homeViewController.twitchData!.twitchUser.id,
            poll!.value.id,
            status)
        .then((value) => {
              if (value.data != null)
                {
                  poll!.value = value.data!,
                }
              else
                {
                  poll = null,
                }
            });
  }

  void getPrediction() {
    homeEvents
        .getPrediction(homeViewController.twitchData!.accessToken,
            homeViewController.twitchData!.twitchUser.id)
        .then((value) => {
              if (value.error != null)
                {
                  prediction = null,
                }
              else
                {
                  if (prediction == null)
                    {
                      prediction = value.data!.obs,
                    }
                  else
                    {
                      prediction!.value = value.data!,
                    }
                }
            });
  }

  // status is either RESOLVED to end prediction with a winner (should provide winning_outcome_id)
  // or CANCELED to end the prediction and refund
  // or LOCKED to lock prediction so user can no longer make predictions
  void endPrediction(String status, String? winningOutcomeId) {}

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
