import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/domain/entities/se_activity.dart';
import 'package:irllink/src/domain/entities/se_song.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'home_view_controller.dart';

class StreamelementsViewController extends GetxController
    with GetTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;

  RxList<SeActivity> activities = <SeActivity>[].obs;
  late ScrollController activitiesScrollController;

  RxList<SeSong> songRequestQueue = <SeSong>[].obs;
  late ScrollController songRequestScrollController;

  Socket? socket;
  late String jwt = "";

  RxBool isSocketConnected = false.obs;

  late HomeViewController homeViewController;

  @override
  Future<void> onInit() async {
    homeViewController = Get.find<HomeViewController>();

    tabController = TabController(length: 1, vsync: this);
    activitiesScrollController = ScrollController();
    songRequestScrollController = ScrollController();

    homeViewController.homeEvents
        .getSettings()
        .then((value) => applySettings());

    super.onInit();
  }


  @override
  void onClose() {
    socket?.close();
    super.onClose();
  }

  void replayEvent(SeActivity activity) {
    streamelementsEvents.replayActivity(jwt, activity);
  }

  Future<void> applySettings() async {
    if (jwt != homeViewController.settings.value.streamElementsAccessToken!) {
      socket?.dispose();
      socket = null;
      activities.clear();
      jwt = homeViewController.settings.value.streamElementsAccessToken!;
      connectWebsocket();
    }
  }

  Future<void> login() async {
    StreamelementsAuthParams params = const StreamelementsAuthParams();
    await streamelementsEvents.login(params: params);
  }

  void nextSong() {
    if (songRequestQueue.isNotEmpty) {
      songRequestQueue.removeAt(0);
    }
  }

  void removeSong(SeSong song) {
    songRequestQueue.remove(song);
  }

  void resetQueue() {
    songRequestQueue.clear();
  }

  /// Connect to WebSocket
  Future<void> connectWebsocket() async {
    socket = io(
        'https://realtime.streamelements.com',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());
    socket!.connect();
    socket!.on('connect_error', (data) => onError());
    socket!.on('connect', (data) => onConnect());
    socket!.on('disconnect', (data) => onDisconnect());
    socket!.on('authenticated', (data) => onAuthenticated(data));
    socket!.on(
      'event:test',
      (data) => {
        parseTestEvent(data),
      },
    );
    socket!.on('event', (data) {
      // Structure as on https://dev.streamelements.com/docs/widgets/6707a030af0b9-custom-widget-events
      parseEvent(data);
    });
    socket!.on(
      'event:update',
      (data) => {
        // debugPrint(data.toString())
      },
    );
    socket!.on(
      'event:reset',
      (data) => {
        // debugPrint(data.toString())
      },
    );
  }

  Future<void> onConnect() async {
    socket?.emit('authenticate', {"method": 'jwt', "token": jwt});
  }

  Future<void> onError() async {
    isSocketConnected.value = false;
    debugPrint('Error connecting to StreamElements websocket');
  }

  Future<void> onDisconnect() async {
    isSocketConnected.value = false;
    debugPrint('Disconnected from StreamElements websocket');
  }

  Future<void> onAuthenticated(data) async {
    isSocketConnected.value = true;
    debugPrint('Connected to StreamElements websocket');
  }

  void parseTestEvent(data) {
    dynamic widget = data[0];
    String listener = widget["listener"];
    dynamic event = widget["event"];
    switch (listener) {
      case "follower-latest":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showFollowerActivity) return;
        SeActivity activity = SeActivity(
          id: "1",
          channel: "",
          username: event["name"],
          activityType: ActivityType.follow,
          isTest: true,
        );
        activities.add(activity);
        break;
      case "subscriber-latest":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showSubscriberActivity) return;
        SeActivity activity = SeActivity(
          id: "1",
          channel: "",
          username: event["name"],
          message: event["message"],
          tier: event["tier"],
          gifted: event["gifted"],
          sender: event["sender"],
          activityType: ActivityType.subscription,
          isTest: true,
        );
        activities.add(activity);
        break;
      case "tip-latest":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showDonationActivity) return;
        SeActivity activity = SeActivity(
          id: "1",
          channel: "",
          username: event["name"],
          message: event["message"],
          amount: event["amount"].toString(),
          activityType: ActivityType.tip,
          isTest: true,
        );
        activities.add(activity);
        break;
      case "cheer-latest":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showCheerActivity) return;
        SeActivity activity = SeActivity(
          id: "1",
          channel: "",
          username: event["name"],
          message: event["message"],
          amount: event["amount"].toString(),
          activityType: ActivityType.cheer,
          isTest: true,
        );
        activities.add(activity);
        break;
      case "host-latest":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showHostActivity) return;
        SeActivity activity = SeActivity(
          id: "1",
          channel: "",
          username: event["name"],
          amount: event["amount"].toString(),
          activityType: ActivityType.host,
          isTest: true,
        );
        activities.add(activity);
        break;
      case "raid-latest":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showRaidActivity) return;
        SeActivity activity = SeActivity(
          channel: "",
          id: "1",
          username: event["name"],
          amount: event["amount"].toString(),
          activityType: ActivityType.raid,
          isTest: true,
        );
        activities.add(activity);
        break;
      default:
        break;
    }
  }

  void parseEvent(data) {
    dynamic event = data[0];
    String type = event["type"];
    switch (type) {
      case "follow":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showFollowerActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          activityType: ActivityType.follow,
        );
        activities.add(activity);
        break;
      case "subscriber":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showSubscriberActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          message: event["data"]["message"],
          amount: event["data"]["amount"].toString(),
          tier: event["data"]["tier"],
          gifted: event["data"]["gifted"],
          sender: event["data"]["sender"],
          activityType: ActivityType.subscription,
        );
        activities.add(activity);
        break;
      case "tip":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showDonationActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          amount: event["data"]["amount"].toString(),
          currency: event["data"]["currency"],
          activityType: ActivityType.tip,
        );
        activities.add(activity);
        break;
      case "cheer":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showCheerActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          message: event["data"]["message"],
          amount: event["data"]["amount"].toString(),
          activityType: ActivityType.cheer,
        );
        activities.add(activity);
        break;
      case "host":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showHostActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          amount: event["data"]["amount"].toString(),
          activityType: ActivityType.host,
        );
        activities.add(activity);
        break;
      case "raid":
        if (!homeViewController
            .settings.value.streamElementsSettings!.showRaidActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["displayName"],
          amount: event["data"]["amount"].toString(),
          activityType: ActivityType.raid,
        );
        activities.add(activity);
        break;
      default:
        break;
    }
  }
}
