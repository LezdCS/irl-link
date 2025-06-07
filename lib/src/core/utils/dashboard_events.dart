import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';

enum DashboardActionsProvider {
  custom,
  twitch,
  obs,
  streamElements,
}

// Function returning a string based on the provider
String getDashboardActionProviderString(DashboardActionsProvider? provider) {
  switch (provider) {
    case DashboardActionsProvider.custom:
      return 'Custom';
    case DashboardActionsProvider.twitch:
      return 'Twitch';
    case DashboardActionsProvider.obs:
      return 'OBS';
    case DashboardActionsProvider.streamElements:
      return 'StreamElements';
    default:
      return 'Not supported anymore';
  }
}

enum SupportedEvents {
  none,
  obsStreamStart,
  obsStreamStop,
  obsRecordToggle,
  twitchChatMessage,
  // twitchFollowerOnly,
  // twitchSubOnly,
  // twitchEmoteOnly,
  // twitchSlowMode,
  // twitchCreatePrediction,
  // twitchLockPrediction,
  // twitchEndPrediction,
  // twitchCancelPrediction,
  // twitchCreatePoll,
  // twitchCancelPoll,
  // twitchEndPoll,
}

// Function returning a string based on the supported event
String getSupportedEventString(SupportedEvents event) {
  switch (event) {
    case SupportedEvents.none:
      return 'Select an event';
    case SupportedEvents.obsStreamStart:
      return 'OBS Stream Start';
    case SupportedEvents.obsStreamStop:
      return 'OBS Stream Stop';
    case SupportedEvents.obsRecordToggle:
      return 'OBS Record Toggle';
    case SupportedEvents.twitchChatMessage:
      return 'Twitch Chat Message';
    // case SupportedEvents.twitchFollowerOnly:
    //   return 'Twitch Follower Only';
    // case SupportedEvents.twitchSubOnly:
    //   return 'Twitch Sub Only';
    // case SupportedEvents.twitchEmoteOnly:
    //   return 'Twitch Emote Only';
    // case SupportedEvents.twitchSlowMode:
    //   return 'Twitch Slow Mode';
    // case SupportedEvents.twitchCreatePrediction:
    //   return 'Twitch Create Prediction';
    // case SupportedEvents.twitchLockPrediction:
    //   return 'Twitch Lock Prediction';
    // case SupportedEvents.twitchEndPrediction:
    //   return 'Twitch End Prediction';
    // case SupportedEvents.twitchCancelPrediction:
    //   return 'Twitch Cancel Prediction';
    // case SupportedEvents.twitchCreatePoll:
    //   return 'Twitch Create Poll';
    // case SupportedEvents.twitchCancelPoll:
    //   return 'Twitch Cancel Poll';
    // case SupportedEvents.twitchEndPoll:
    //   return 'Twitch End Poll';
  }
}

Widget? getSupportedEventIcon(SupportedEvents event) {
  switch (event) {
    case SupportedEvents.none:
      return null;
    case SupportedEvents.obsStreamStart:
      return null;
    case SupportedEvents.obsStreamStop:
      return null;
    case SupportedEvents.obsRecordToggle:
      return null;
    case SupportedEvents.twitchChatMessage:
      return const Image(
        image: AssetImage("lib/assets/twitch/twitch_logo.png"),
        width: 16,
      );
    // case SupportedEvents.twitchFollowerOnly:
    //   return Icon(Icons.person);
    // case SupportedEvents.twitchSubOnly:
    //   return Icon(Icons.star);
    // case SupportedEvents.twitchEmoteOnly:
    //   return Icon(Icons.emoji_emotions);
    // case SupportedEvents.twitchSlowMode:
    //   return Icon(Icons.timer);
    // case SupportedEvents.twitchCreatePrediction:
    //   return Icon(Icons.poll);
    // case SupportedEvents.twitchLockPrediction:
    //   return Icon(Icons.lock);
    // case SupportedEvents.twitchEndPrediction:
    //   return Icon(Icons.done);
    // case SupportedEvents.twitchCancelPrediction:
    //   return Icon(Icons.cancel);
    // case SupportedEvents.twitchCreatePoll:
    //   return Icon(Icons.poll);
    // case SupportedEvents.twitchCancelPoll:
    //   return Icon(Icons.cancel);
    // case SupportedEvents.twitchEndPoll:
    //   return Icon(Icons.done);
  }
}

class ExistingDashboardEvent {
  final DashboardActionsProvider provider;
  final List<DashboardActionsTypes> actionsAllowed;
  final dynamic value;
  final Function action;

  const ExistingDashboardEvent({
    required this.provider,
    required this.actionsAllowed,
    this.value,
    required this.action,
  });
}

Map<SupportedEvents, ExistingDashboardEvent> dashboardEvents = {
  SupportedEvents.obsStreamStart: ExistingDashboardEvent(
    provider: DashboardActionsProvider.obs,
    actionsAllowed: [DashboardActionsTypes.button],
    action: (v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStream();
    },
  ),
  SupportedEvents.obsStreamStop: ExistingDashboardEvent(
    provider: DashboardActionsProvider.obs,
    actionsAllowed: [DashboardActionsTypes.button],
    action: (v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.stopStream();
    },
  ),
  SupportedEvents.obsRecordToggle: ExistingDashboardEvent(
    provider: DashboardActionsProvider.obs,
    actionsAllowed: [DashboardActionsTypes.toggle],
    value: Get.find<ObsTabViewController>().isRecording,
    action: (v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStopRecording();
    },
  ),
  SupportedEvents.twitchChatMessage: ExistingDashboardEvent(
    provider: DashboardActionsProvider.twitch,
    actionsAllowed: [DashboardActionsTypes.button],
    action: (String v) {
      String channel =
          Get.find<HomeViewController>().twitchData.value!.twitchUser.login;
      Get.find<HomeViewController>().sendChatMessage(v, channel);
    },
  ),
  // SupportedEvents.twitchFollowerOnly: ExistingDashboardEvent(
  //   provider: DashboardActionsProvider.twitch,
  //   actionsAllowed: [DashboardActionsTypes.toggle],
  //   value: Get.find<TwitchTabViewController>()
  //       .twitchStreamInfos
  //       .value
  //       .isFollowerMode,
  //   action: (dynamic v) {
  //     TwitchTabViewController twitchTabViewController =
  //         Get.find<TwitchTabViewController>();
  //     twitchTabViewController.toggleFollowerOnly();
  //   },
  // ),
  // SupportedEvents.twitchSubOnly: ExistingDashboardEvent(
  //   provider: DashboardActionsProvider.twitch,
  //   actionsAllowed: [DashboardActionsTypes.toggle],
  //   value: Get.find<TwitchTabViewController>()
  //       .twitchStreamInfos
  //       .value
  //       .isSubscriberMode,
  //   action: (dynamic v) {
  //     TwitchTabViewController twitchTabViewController =
  //         Get.find<TwitchTabViewController>();
  //     twitchTabViewController.toggleSubOnly();
  //   },
  // ),
  // SupportedEvents.twitchEmoteOnly: ExistingDashboardEvent(
  //   provider: DashboardActionsProvider.twitch,
  //   actionsAllowed: [DashboardActionsTypes.toggle],
  //   value:
  //       Get.find<TwitchTabViewController>().twitchStreamInfos.value.isEmoteMode,
  //   action: (dynamic v) {
  //     TwitchTabViewController twitchTabViewController =
  //         Get.find<TwitchTabViewController>();
  //     twitchTabViewController.toggleFollowerOnly();
  //   },
  // ),
  // SupportedEvents.twitchSlowMode: ExistingDashboardEvent(
  //   provider: DashboardActionsProvider.twitch,
  //   actionsAllowed: [DashboardActionsTypes.toggle],
  //   value:
  //       Get.find<TwitchTabViewController>().twitchStreamInfos.value.isSlowMode,
  //   action: (bool v) {
  //     TwitchTabViewController twitchTabViewController =
  //         Get.find<TwitchTabViewController>();
  //     twitchTabViewController.toggleSlowMode(v ? 30 : 0);
  //   },
  // ),
};
