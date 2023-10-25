import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';

enum DashboardActionsProvider {
  custom,
  twitch,
  obs,
  streamElements,
}

enum SupportedEvents {
  none,
  obsStreamStart,
  obsStreamStop,
  obsRecordToggle,
  twitchChatMessage,
  twitchFollowerOnly,
  twitchSubOnly,
  twitchEmoteOnly,
  twitchSlowMode,
  // twitchCreatePrediction,
  // twitchLockPrediction,
  // twitchEndPrediction,
  // twitchCancelPrediction,
  // twitchCreatePoll,
  // twitchCancelPoll,
  // twitchEndPoll,
}

Map dashboardEvents = {
  SupportedEvents.obsStreamStart: {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.button],
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStream();
    },
  },
  SupportedEvents.obsStreamStop: {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.button],
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.stopStream();
    },
  },
  SupportedEvents.obsRecordToggle: {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value': Get.find<ObsTabViewController>().isRecording,
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStopRecording();
    },
  },
  SupportedEvents.twitchChatMessage: {
    'provider': DashboardActionsProvider.twitch,
    'actionsAllowed': [DashboardActionsTypes.button],
    'action': (dynamic v) {
      Get.find<HomeViewController>().sendChatMessage(v);
    },
  },
  SupportedEvents.twitchFollowerOnly: {
    // 'provider': DashboardActionsProvider.twitch,
    // 'actionsAllowed': [DashboardActionsTypes.toggle],
    // 'value': Get.find<TwitchTabViewController>()
    //     .twitchStreamInfos
    //     .value
    //     .isFollowerMode,
    // 'action': (dynamic v) {
    //   TwitchTabViewController twitchTabViewController =
    //       Get.find<TwitchTabViewController>();
    //   twitchTabViewController.toggleFollowerOnly();
    // },
  },
  SupportedEvents.twitchSubOnly: {
    // 'provider': DashboardActionsProvider.twitch,
    // 'actionsAllowed': [DashboardActionsTypes.toggle],
    // 'value': Get.find<TwitchTabViewController>()
    //     .twitchStreamInfos
    //     .value
    //     .isSubscriberMode,
    // 'action': (dynamic v) {
    //   TwitchTabViewController twitchTabViewController =
    //       Get.find<TwitchTabViewController>();
    //   twitchTabViewController.toggleSubOnly();
    // },
  },
  SupportedEvents.twitchEmoteOnly: {
    // 'provider': DashboardActionsProvider.twitch,
    // 'actionsAllowed': [DashboardActionsTypes.toggle],
    // 'value':
    //     Get.find<TwitchTabViewController>().twitchStreamInfos.value.isEmoteMode,
    // 'action': (dynamic v) {
    //   TwitchTabViewController twitchTabViewController =
    //       Get.find<TwitchTabViewController>();
    //   twitchTabViewController.toggleFollowerOnly();
    // },
  },
  SupportedEvents.twitchSlowMode: {
    // 'provider': DashboardActionsProvider.twitch,
    // 'actionsAllowed': [DashboardActionsTypes.toggle],
    // 'value':
    //     Get.find<TwitchTabViewController>().twitchStreamInfos.value.isSlowMode,
    // 'action': (bool v) {
    //   TwitchTabViewController twitchTabViewController =
    //       Get.find<TwitchTabViewController>();
    //   twitchTabViewController.toggleSlowMode(v ? 30 : 0);
    // },
  },
};