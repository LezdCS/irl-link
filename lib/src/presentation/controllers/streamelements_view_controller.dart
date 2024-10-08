import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/events/streamelements_events.dart';
import 'package:socket_io_client/socket_io_client.dart';

class StreamelementsViewController extends GetxController
    with GetTickerProviderStateMixin {
  StreamelementsViewController({required this.streamelementsEvents});

  final StreamelementsEvents streamelementsEvents;

  late TabController tabController;

  RxList<SeActivity> activities = <SeActivity>[].obs;
  late ScrollController activitiesScrollController;

  Rxn<SeCredentials> seCredentials = Rxn<SeCredentials>();
  Rxn<SeMe> userSeProfile = Rxn<SeMe>();

  // Song Requests
  RxList<SeSong> songRequestQueue = <SeSong>[].obs;
  Rxn<SeSong> currentSong = Rxn<SeSong>();
  late ScrollController songRequestScrollController;
  RxBool isPlaying = false.obs;

  RxList<SeOverlay> overlays = <SeOverlay>[].obs;

  Socket? socket;

  RxBool isSocketConnected = false.obs;

  final HomeViewController homeViewController = Get.find<HomeViewController>();

  @override
  Future<void> onInit() async {
    if(!Platform.isIOS) {
      tabController = TabController(length: 3, vsync: this);
    } else {
      tabController = TabController(length: 2, vsync: this);
    } 
    activitiesScrollController = ScrollController();
    songRequestScrollController = ScrollController();

    await setStreamElementsCredentials();
    if (seCredentials.value != null) {
      DataState<SeCredentials> tokenResult = await streamelementsEvents
          .refreshSeAccessToken(seCredentials: seCredentials.value!);

      if (tokenResult.data != null) {
        seCredentials.value = tokenResult.data;
      }
    }

    streamelementsEvents.getSettings().then((value) => applySettings());

    isSocketConnected.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendSeConnectedToNative",
        "data": isSocketConnected.value,
      });
    });

    activities.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendSeActivityToNative",
        "data": value.last.toJsonForWatch(),
      });
    });

    super.onInit();
  }

  @override
  void onClose() {
    socket?.close();
    isSocketConnected.value = false;
    socket = null;
    super.onClose();
  }

  Future<void> setStreamElementsCredentials() async {
    DataState<SeCredentials> seCreds =
        await streamelementsEvents.getSeCredentialsFromLocal();
    if (seCreds is DataSuccess) {
      seCredentials.value = seCreds.data;
      await setSeMe(seCredentials.value!);
    }
  }

  Future<void> setSeMe(SeCredentials seCreds) async {
    DataState<SeMe> seMeResult =
        await streamelementsEvents.getSeMe(seCredentials.value!.accessToken);
    if (seMeResult is DataSuccess) {
      userSeProfile.value = seMeResult.data;
    }
  }

  void replayEvent(SeActivity activity) {
    String accessToken = seCredentials.value!.accessToken;
    streamelementsEvents.replayActivity(accessToken, activity);
  }

  Future<void> applySettings() async {
    if (userSeProfile.value != null) {
      handleGetMe();
    }
    if (!isSocketConnected.value && socket == null) {
      connectWebsocket();
    }
  }

  Future<void> handleGetMe() async {
    String? jwt =
        Get.find<SettingsService>().settings.value.streamElementsSettings?.jwt;
    SeMe? me = userSeProfile.value;
    if (me == null) {
      globals.talker?.error('User profile was not found.');
      return;
    }
    String? accessToken = seCredentials.value?.accessToken;
    if (accessToken == null) {
      globals.talker?.error('There is no accessToken to use for SE api calls.');
      return;
    }

    streamelementsEvents
        .getOverlays(accessToken, me.id)
        .then((value) => overlays.value = value.data ?? []);
    streamelementsEvents
        .getLastActivities(accessToken, me.id)
        .then((value) => activities.value = value.data ?? []);
    streamelementsEvents
        .getSongPlaying(accessToken, me.id)
        .then((value) => currentSong.value = value.data);

    if (jwt != null) {
      DataState<List<SeSong>> songQueue =
          await streamelementsEvents.getSongQueue(jwt, me.id);
      if (songQueue is DataSuccess) {
        songRequestQueue.value = songQueue.data ?? [];
      }
    }
  }

  void updatePlayerState(String state, String jwt) {
    if (userSeProfile.value == null) return;
    streamelementsEvents.updatePlayerState(
      jwt,
      userSeProfile.value!.id,
      state,
    );
  }

  void nextSong(String jwt) {
    if (userSeProfile.value == null) return;
    streamelementsEvents.nextSong(jwt, userSeProfile.value!.id);
  }

  void removeSong(SeSong song, String jwt) {
    if (userSeProfile.value == null) return;
    streamelementsEvents.removeSong(jwt, userSeProfile.value!.id, song.id);
  }

  void resetQueue(String jwt) {
    if (userSeProfile.value == null) return;
    streamelementsEvents.resetQueue(jwt, userSeProfile.value!.id);
  }

  /// Connect to WebSocket
  Future<void> connectWebsocket() async {
    socket = io(
      'https://realtime.streamelements.com',
      OptionBuilder().setTransports(['websocket']).build(),
    ).connect();

    socket?.on('connect_error', (data) => onError());
    socket?.on('connect', (data) => onConnect());
    socket?.on('disconnect', (data) => onDisconnect());
    socket?.on('authenticated', (data) => onAuthenticated(data));
    socket?.on(
      'event:test',
      (data) => {
        parseTestEvent(data),
      },
    );
    socket?.on('event', (data) {
      // Structure as on https://dev.streamelements.com/docs/widgets/6707a030af0b9-custom-widget-events
      parseEvent(data);
    });
    socket?.on(
      'event:update',
      (data) => {
        // debugPrint(data.toString())
      },
    );
    socket?.on(
      'event:reset',
      (data) => {
        // debugPrint(data.toString())
      },
    );

    socket?.onAny(
      (event, data) => {
        if (data != null)
          {
            globals.talker?.debug(data),
          }
      },
    );

    socket?.on(
      'songrequest:song:next',
      (data) => onNextSong(data),
    );

    socket?.on(
      'songrequest:song:previous',
      (data) => onPreviousSong(data),
    );

    socket?.on(
      'songrequest:queue:add',
      (data) => onAddSongQueue(data),
    );

    socket?.on(
      'songrequest:queue:remove',
      (data) => onRemoveSongQueue(data),
    );

    socket?.on(
      'songrequest:queue:clear',
      (data) => {
        songRequestQueue.clear(),
      },
    );

    socket?.on(
      'songrequest:play',
      (data) => {isPlaying.value = true},
    );

    socket?.on(
      'songrequest:pause',
      (data) => {isPlaying.value = false},
    );
  }

  Future<void> onConnect() async {
    String? accessToken = seCredentials.value?.accessToken;
    if (accessToken != null) {
      socket?.emit('authenticate', {"method": 'oauth2', "token": accessToken});
    } else {
      globals.talker?.error('There is no accessToken to use for SE weboscket.');
    }
  }

  Future<void> onError() async {
    isSocketConnected.value = false;
    globals.talker?.error('StreamElements WebSocket error.');
  }

  Future<void> onDisconnect() async {
    isSocketConnected.value = false;
    globals.talker?.warning('StreamElements WebSocket disconnected.');
  }

  Future<void> onAuthenticated(data) async {
    isSocketConnected.value = true;
    globals.talker?.logTyped(
      StreamElementsLog('StreamElements WebSocket authenticated.'),
    );
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
    if (songData == null || songData == {}) return;
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
    Settings settings = Get.find<SettingsService>().settings.value;

    dynamic widget = data[0];
    String listener = widget["listener"];
    dynamic event = widget["event"];
    switch (listener) {
      case "follower-latest":
        if (!settings.streamElementsSettings!.showFollowerActivity) return;
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
        if (!settings.streamElementsSettings!.showSubscriberActivity) return;
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
        if (!settings.streamElementsSettings!.showDonationActivity) return;
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
        if (!settings.streamElementsSettings!.showCheerActivity) return;
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
        if (!settings.streamElementsSettings!.showHostActivity) return;
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
        if (!settings.streamElementsSettings!.showRaidActivity) return;
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
    Settings settings = Get.find<SettingsService>().settings.value;

    dynamic event = data[0];
    String type = event["type"];
    switch (type) {
      case "follower":
        if (!settings.streamElementsSettings!.showFollowerActivity) return;
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["username"],
          activityType: ActivityType.follow,
        );
        activities.add(activity);
        break;
      case "subscriber":
        if (!settings.streamElementsSettings!.showSubscriberActivity) return;
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
        if (!settings.streamElementsSettings!.showDonationActivity) return;
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
        if (!settings.streamElementsSettings!.showCheerActivity) return;
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
        if (!settings.streamElementsSettings!.showHostActivity) return;
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
        if (!settings.streamElementsSettings!.showRaidActivity) return;
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
