import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

import 'home_view_controller.dart';

class StreamelementsViewController extends GetxController
    with GetTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;

  RxList<SeActivity> activities = <SeActivity>[].obs;
  late ScrollController activitiesScrollController;

  SeMe? userSeProfile;

  // Song Requests
  RxList<SeSong> songRequestQueue = <SeSong>[].obs;
  Rxn<SeSong> currentSong = Rxn<SeSong>();
  late ScrollController songRequestScrollController;
  RxBool isPlaying = false.obs;

  RxList<SeOverlay> overlays = <SeOverlay>[].obs;

  Socket? socket;
  late String jwt = "";

  RxBool isSocketConnected = false.obs;

  late HomeViewController homeViewController;

  @override
  Future<void> onInit() async {
    homeViewController = Get.find<HomeViewController>();

    tabController = TabController(length: 2, vsync: this);
    activitiesScrollController = ScrollController();
    songRequestScrollController = ScrollController();

    streamelementsEvents.getSettings().then((value) => applySettings());

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
    if (homeViewController.seCredentials.value == null) return;
    if (jwt != homeViewController.seCredentials.value!.accessToken) {
      jwt = homeViewController.seCredentials.value!.accessToken;
      socket?.dispose();
      socket = null;
      activities.clear();
      if (homeViewController.seMe.value != null) {
        handleGetMe(homeViewController.seMe.value!);
      }
      connectWebsocket();
    }
  }

  void handleGetMe(SeMe me) {
    userSeProfile = me;
    streamelementsEvents
        .getOverlays(jwt, me.id)
        .then((value) => overlays.value = value.data!);
    streamelementsEvents
        .getLastActivities(jwt, me.id)
        .then((value) => activities.value = value.data!);
    streamelementsEvents.getSongQueue(jwt, me.id).then((value) => {
          if (value.error == null) {songRequestQueue.value = value.data!}
        });
    streamelementsEvents
        .getSongPlaying(jwt, me.id)
        .then((value) => currentSong.value = value.data!);
  }

  void updatePlayerState(String state) {
    if (userSeProfile == null) return;
    streamelementsEvents.updatePlayerState(jwt, userSeProfile!.id, state);
  }

  void nextSong() {
    if (userSeProfile == null) return;
    streamelementsEvents.nextSong(jwt, userSeProfile!.id);
  }

  void removeSong(SeSong song) {
    if (userSeProfile == null) return;
    streamelementsEvents.removeSong(jwt, userSeProfile!.id, song.id);
  }

  void resetQueue() {
    if (userSeProfile == null) return;
    streamelementsEvents.resetQueue(jwt, userSeProfile!.id);
  }

  /// Connect to WebSocket
  Future<void> connectWebsocket() async {
    socket = io('https://realtime.streamelements.com',
        OptionBuilder().setTransports(['websocket'])
        // .disableAutoConnect()
        .build()
        );

    // socket!.connect();
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

    socket!.on(
      'songrequest:song:next',
      (data) => onNextSong(data),
    );

    socket!.on(
      'songrequest:song:previous',
      (data) => onPreviousSong(data),
    );

    socket!.on(
      'songrequest:queue:add',
      (data) => onAddSongQueue(data),
    );

    socket!.on(
      'songrequest:queue:remove',
      (data) => onRemoveSongQueue(data),
    );

    socket!.on(
      'songrequest:queue:clear',
      (data) => {
        songRequestQueue.clear(),
      },
    );

    socket!.on(
      'songrequest:play',
      (data) => {isPlaying.value = true},
    );

    socket!.on(
      'songrequest:pause',
      (data) => {isPlaying.value = false},
    );
  }

  Future<void> onConnect() async {
    socket?.emit('authenticate', {"method": 'oauth2', "token": jwt});
  }

  Future<void> onError() async {
    isSocketConnected.value = false;
    globals.talker?.error('Error on StreamElements websocket');
  }

  Future<void> onDisconnect() async {
    isSocketConnected.value = false;
    globals.talker?.warning('Disconnected from StreamElements websocket');
  }

  Future<void> onAuthenticated(data) async {
    isSocketConnected.value = true;
    globals.talker?.info('Connected to StreamElements websocket');
  }

  void onAddSongQueue(data) {
    dynamic songData = data[0]["song"];
    SeSong song = SeSong.fromJson(songData);
    songRequestQueue.add(song);
  }

  void onRemoveSongQueue(data) {
    dynamic songId = data[0]["songId"];
    songRequestQueue.removeWhere((element) => element.id == songId);
  }

  void onNextSong(data) {
    dynamic songData = data[0]["nextSong"];
    if (songData == {}) return;
    SeSong song = SeSong.fromJson(songData);
    currentSong.value = song;
    if (song.id != '') {
      songRequestQueue.removeAt(0);
    }
  }

  void onPreviousSong(data) {
    dynamic songData = data[0]["song"];
    SeSong song = SeSong.fromJson(songData);
    currentSong.value = song;
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
      case "follower":
        if (!homeViewController.settings.value.streamElementsSettings!
            .showFollowerActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["username"],
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
          username: event["data"]["username"],
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
          username: event["data"]["username"],
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
          username: event["data"]["username"],
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
          username: event["data"]["username"],
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
          username: event["data"]["username"],
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
