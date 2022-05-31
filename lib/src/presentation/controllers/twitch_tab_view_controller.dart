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

  Rx<TwitchStreamInfos> twitchStreamInfos =
      TwitchStreamInfos.defaultInfos().obs;

  late Rx<TwitchPrediction>? prediction;
  RxString selectedOutcomeId = "-1".obs;

  late Rx<TwitchPoll>? poll;

  @override
  void onInit() {
    titleFormController = TextEditingController();
    prediction = null;
    poll = null;
    
    super.onInit();
  }

  @override
  void onReady() async {
    homeViewController = Get.find<HomeViewController>();

    refreshData();
    Timer.periodic(Duration(seconds: 20), (timer) {
      refreshData();
    });

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (poll != null) {
        getPoll();
      }

      if (prediction != null) {
        getPrediction();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void refreshData() {
    getStreamInfos();
    getPoll();
    getPrediction();
  }

  void changeChatSettings() {
    homeEvents.setChatSettings(homeViewController.twitchData.accessToken,
        homeViewController.twitchData.twitchUser.id, twitchStreamInfos.value);
  }

  void setStreamTitle() {
    homeEvents.setStreamTitle(homeViewController.twitchData.accessToken,
        homeViewController.twitchData.twitchUser.id, titleFormController.text);
  }

  void getPoll() {
    homeEvents
        .getPoll(homeViewController.twitchData.accessToken,
            homeViewController.twitchData.twitchUser.id)
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

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  void endPoll(String status) {
    homeEvents
        .endPoll(homeViewController.twitchData.accessToken,
            homeViewController.twitchData.twitchUser.id, poll!.value.id, status)
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
        .getPrediction(homeViewController.twitchData.accessToken,
            homeViewController.twitchData.twitchUser.id)
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
          homeViewController.twitchData.accessToken,
          homeViewController.twitchData.twitchUser.id,
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
