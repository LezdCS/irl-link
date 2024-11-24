import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';

import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_song.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_last_activities_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_me_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_overlays_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_song_playing_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_song_queue_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/next_song_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/remove_song_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/replay_activity_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/reset_queue_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/update_player_state_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class StreamelementsViewController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  StreamelementsViewController({
    required this.getOverlaysUseCase,
    required this.getMeUseCase,
    required this.getLocalCredentialsUseCase,
    required this.refreshTokenUseCase,
    required this.replayActivityUseCase,
    required this.nextSongUseCase,
    required this.removeSongUseCase,
    required this.resetQueueUseCase,
    required this.updatePlayerStateUseCase,
    required this.getLastActivitiesUseCase,
    required this.getSongPlayingUseCase,
    required this.getSongQueueUseCase,
    required this.settingsService,
    required this.watchService,
    required this.talkerService,
    required this.homeViewController,
  });

  final StreamElementsGetOverlaysUseCase getOverlaysUseCase;
  final StreamElementsGetMeUseCase getMeUseCase;
  final StreamElementsGetLocalCredentialsUseCase getLocalCredentialsUseCase;
  final StreamElementsRefreshTokenUseCase refreshTokenUseCase;
  final StreamElementsReplayActivityUseCase replayActivityUseCase;
  final StreamElementsNextSongUseCase nextSongUseCase;
  final StreamElementsRemoveSongUseCase removeSongUseCase;
  final StreamElementsResetQueueUseCase resetQueueUseCase;
  final StreamElementsUpdatePlayerStateUseCase updatePlayerStateUseCase;
  final StreamElementsGetLastActivitiesUseCase getLastActivitiesUseCase;
  final StreamElementsGetSongPlayingUseCase getSongPlayingUseCase;
  final StreamElementsGetSongQueueUseCase getSongQueueUseCase;

  final SettingsService settingsService;
  final WatchService watchService;
  final TalkerService talkerService;
  final HomeViewController homeViewController;

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

  @override
  Future<void> onInit() async {
    tabController = TabController(length: 3, vsync: this);
    activitiesScrollController = ScrollController();
    songRequestScrollController = ScrollController();

    await setStreamElementsCredentials();
    if (seCredentials.value != null) {
      final refreshResult = await refreshTokenUseCase(
        params: seCredentials.value!,
      );

      refreshResult.fold(
        (l) => {},
        (r) => seCredentials.value = r,
      );
    }

    settingsService.getSettings().then((value) => applySettings());

    isSocketConnected.listen((value) {
      // Send to watchOS
      watchService.sendSeConnectedToNative(
        isConnected: isSocketConnected.value,
      );
    });

    activities.listen((value) {
      // Send to watchOS
      watchService.sendSeActivityToNative(value.last);
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

  void reconnectSocket() {
    socket?.close();
    socket = null;
    isSocketConnected.value = false;
    connectWebsocket();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // The app is back to the foreground
      reconnectSocket(); // Reconnect to SE websocket
    } else if (state == AppLifecycleState.paused) {
      // The app is sent to the background
    }
  }

  Future<void> setStreamElementsCredentials() async {
    final seCredsResult = await getLocalCredentialsUseCase();
    seCredsResult.fold(
      (l) => {},
      (r) async {
        seCredentials.value = r;
        await setSeMe(seCredentials.value!);
      },
    );
  }

  Future<void> setSeMe(SeCredentials seCreds) async {
    final seMeResult = await getMeUseCase(
      params: StreamElementsGetMeParams(
        token: seCredentials.value!.accessToken,
      ),
    );
    seMeResult.fold(
      (l) => {},
      (r) => userSeProfile.value = r,
    );
  }

  void replayEvent(SeActivity activity) {
    String accessToken = seCredentials.value!.accessToken;
    replayActivityUseCase(
      params: StreamElementsReplayActivityParams(
        token: accessToken,
        activity: activity,
      ),
    );
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
    String? jwt = settingsService.settings.value.streamElementsSettings.jwt;
    SeMe? me = userSeProfile.value;
    if (me == null) {
      talkerService.talker.error('User profile was not found.');
      return;
    }
    String? accessToken = seCredentials.value?.accessToken;
    if (accessToken == null) {
      talkerService.talker
          .error('There is no accessToken to use for SE api calls.');
      return;
    }

    final overlaysResult = await getOverlaysUseCase(
      params: StreamElementsGetOverlaysParams(
        token: accessToken,
        channel: me.id,
      ),
    );
    overlaysResult.fold(
      (l) => {},
      (r) => overlays.value = r,
    );

    final lastActivitiesResult = await getLastActivitiesUseCase(
      params: StreamElementsGetLastActivitiesParams(
        token: accessToken,
        channel: me.id,
      ),
    );
    lastActivitiesResult.fold(
      (l) => debugPrint(l.message),
      (r) => activities.value = r,
    );

    final songPlayingResult = await getSongPlayingUseCase(
      params: StreamElementsGetSongPlayingParams(
        token: accessToken,
        channel: me.id,
      ),
    );
    songPlayingResult.fold(
      (l) => {},
      (r) => currentSong.value = r,
    );

    if (jwt != null) {
      final songQueueResult = await getSongQueueUseCase(
        params: StreamElementsGetSongQueueParams(
          token: accessToken,
          channel: me.id,
        ),
      );
      songQueueResult.fold(
        (l) => {},
        (r) => {
          songRequestQueue.value = r,
        },
      );
    }
  }

  void updatePlayerState(String state, String jwt) {
    if (userSeProfile.value == null) {
      return;
    }
    updatePlayerStateUseCase(
      params: StreamElementsUpdatePlayerStateParams(
        token: jwt,
        channel: userSeProfile.value!.id,
        state: state,
      ),
    );
  }

  void nextSong(String jwt) {
    if (userSeProfile.value == null) {
      return;
    }
    nextSongUseCase(
      params: StreamElementsNextSongParams(
        token: jwt,
        channel: userSeProfile.value!.id,
      ),
    );
  }

  void removeSong(SeSong song, String jwt) {
    if (userSeProfile.value == null) {
      return;
    }
    removeSongUseCase(
      params: StreamElementsRemoveSongParams(
        token: jwt,
        channel: userSeProfile.value!.id,
        songId: song.id,
      ),
    );
  }

  void resetQueue(String jwt) {
    if (userSeProfile.value == null) {
      return;
    }
    resetQueueUseCase(
      params: StreamElementsResetQueueParams(
        token: jwt,
        channel: userSeProfile.value!.id,
      ),
    );
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
            talkerService.talker.debug(data),
          },
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
      talkerService.talker
          .error('There is no accessToken to use for SE weboscket.');
    }
  }

  Future<void> onError() async {
    isSocketConnected.value = false;
    talkerService.talker.error('StreamElements WebSocket error.');
  }

  Future<void> onDisconnect() async {
    isSocketConnected.value = false;
    talkerService.talker.warning('StreamElements WebSocket disconnected.');
  }

  Future<void> onAuthenticated(data) async {
    isSocketConnected.value = true;
    talkerService.talker.logTyped(
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
    if (songData == null || songData == {}) {
      return;
    }
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
    Settings settings = settingsService.settings.value;

    dynamic widget = data[0];
    String listener = widget["listener"];
    dynamic event = widget["event"];
    switch (listener) {
      case "follower-latest":
        if (!settings.streamElementsSettings.showFollowerActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showSubscriberActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showDonationActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showCheerActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showHostActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showRaidActivity) {
          return;
        }
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
    Settings settings = settingsService.settings.value;

    dynamic event = data[0];
    String type = event["type"];
    switch (type) {
      case "follower":
        if (!settings.streamElementsSettings.showFollowerActivity) {
          return;
        }
        SeActivity activity = SeActivity(
          id: event["_id"],
          channel: event["channel"],
          username: event["data"]["username"],
          activityType: ActivityType.follow,
        );
        activities.add(activity);
        break;
      case "subscriber":
        if (!settings.streamElementsSettings.showSubscriberActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showDonationActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showCheerActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showHostActivity) {
          return;
        }
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
        if (!settings.streamElementsSettings.showRaidActivity) {
          return;
        }
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
