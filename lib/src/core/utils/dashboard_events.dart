import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';

Map dashboardEvents = {
  'obs.strean.start': {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.button],
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStream();
    },
  },
  'obs.strean.stop': {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.button],
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.stopStream();
    },
  },
  'obs.recording.toggle': {
    'provider': DashboardActionsProvider.obs,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value': Get.find<ObsTabViewController>().isRecording,
    'action': (dynamic v) {
      ObsTabViewController obsTabViewController =
          Get.find<ObsTabViewController>();
      obsTabViewController.startStopRecording();
    },
  },
  'twitch.followers-only.toggle': {
    'provider': DashboardActionsProvider.twitch,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value': Get.find<TwitchTabViewController>()
        .twitchStreamInfos
        .value
        .isFollowerMode,
    'action': (dynamic v) {
      TwitchTabViewController twitchTabViewController =
          Get.find<TwitchTabViewController>();
      twitchTabViewController.toggleFollowerOnly();
    },
  },
  'twitch.sub-only.toggle': {
    'provider': DashboardActionsProvider.twitch,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value': Get.find<TwitchTabViewController>()
        .twitchStreamInfos
        .value
        .isSubscriberMode,
    'action': (dynamic v) {
      TwitchTabViewController twitchTabViewController =
          Get.find<TwitchTabViewController>();
      twitchTabViewController.toggleSubOnly();
    },
  },
  'twitch.emote-only.toggle': {
    'provider': DashboardActionsProvider.twitch,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value':
        Get.find<TwitchTabViewController>().twitchStreamInfos.value.isEmoteMode,
    'action': (dynamic v) {
      TwitchTabViewController twitchTabViewController =
          Get.find<TwitchTabViewController>();
      twitchTabViewController.toggleFollowerOnly();
    },
  },
  'twitch.slow-mode.toggle': {
    'provider': DashboardActionsProvider.twitch,
    'actionsAllowed': [DashboardActionsTypes.toggle],
    'value':
        Get.find<TwitchTabViewController>().twitchStreamInfos.value.isSlowMode,
    'action': (dynamic v) {
      TwitchTabViewController twitchTabViewController =
          Get.find<TwitchTabViewController>();
      twitchTabViewController.toggleSlowMode(30);
    },
  },
};