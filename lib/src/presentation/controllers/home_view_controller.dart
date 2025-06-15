import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/twitch_event_sub_service.dart';
import 'package:irllink/src/core/services/twitch_pub_sub_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/kick/kick_refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/post_kick_chat_nessage_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_recent_messages.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/chats_controller.dart';
import 'package:irllink/src/presentation/controllers/tabs/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/views/home_view.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:split_view/split_view.dart';
import 'package:twitch_chat/twitch_chat.dart';

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({
    required this.refreshAccessTokenUseCase,
    required this.refreshKickAccessTokenUseCase,
    required this.settingsService,
    required this.talkerService,
    required this.postKickChatMessageUseCase,
    required this.getRecentMessagesUseCase,
  });

  final RefreshTwitchTokenUseCase refreshAccessTokenUseCase;
  final KickRefreshTokenUseCase refreshKickAccessTokenUseCase;
  final SettingsService settingsService;
  final TalkerService talkerService;
  final PostKickChatMessageUseCase postKickChatMessageUseCase;
  final GetRecentMessagesUseCase getRecentMessagesUseCase;
  SplitViewController? splitViewController = SplitViewController(
    limits: [null, WeightLimit(min: 0.12, max: 0.92)],
  );
  Timer? debounceSplitResize;

  Rxn<TwitchCredentials> twitchData = Rxn<TwitchCredentials>();
  Rxn<KickCredentials> kickData = Rxn<KickCredentials>();

  // Chat input
  late TextEditingController chatInputController;

  // Emote picker
  RxBool isPickingEmote = false.obs;
  late TabController emotesTabController;
  RxInt emotesTabIndex = 0.obs;

  Timer? timerRefreshToken;
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool displayDashboard = false.obs;

  TwitchPubSubService? twitchPubSubService;
  TwitchEventSubService? twitchEventSubService;

  RxList<PinnedMessage> pinnedMessages = <PinnedMessage>[].obs;
  RxBool showPinnedMessages = false.obs;

  RxnString minimumVersion = RxnString();

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    emotesTabController = TabController(length: 0, vsync: this);

    if (Get.arguments != null) {
      final twitchCreds = Get.arguments[0];
      final kickCreds = Get.arguments[1];
      if (twitchCreds is TwitchCredentials) {
        twitchData.value = twitchCreds;
        _initializeTwitchServices();
        _setupCrashlytics();
      }
      if (kickCreds is KickCredentials) {
        kickData.value = kickCreds;
        _initializeKickServices();
      }
    }

    splitViewController?.weights =
        settingsService.settings.value.generalSettings.splitViewWeights;

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    minimumVersion.value = io.Platform.isAndroid
        ? remoteConfig.getString('minimum_version_android')
        : remoteConfig.getString('minimum_version_ios');

    super.onInit();
  }

  Future<void> _initializeKickServices() async {
    // Add periodic token refresh for Kick
    Timer.periodic(const Duration(seconds: 13000), (Timer t) async {
      final refreshTokenResultKick =
          await refreshKickAccessTokenUseCase(params: kickData.value!);
      refreshTokenResultKick.fold(
        (l) {
          talkerService.talker.error('Failed to refresh Kick access token');
        },
        (r) {
          kickData.value = r;
        },
      );
    });
  }

  Future<void> _initializeTwitchServices() async {
    _initializePubSubService();
    _initializeEventSubService();

    timerRefreshToken =
        Timer.periodic(const Duration(seconds: 13000), (Timer t) async {
      final refreshTokenResult =
          await refreshAccessTokenUseCase(params: twitchData.value!);
      refreshTokenResult.fold(
        (l) {
          talkerService.talker.error('Failed to refresh Twitch access token');
        },
        (r) {
          twitchData.value = r;
          // Update TwitchTabViewController with new token
          if (Get.isRegistered<TwitchTabViewController>()) {
            final twitchTabController = Get.find<TwitchTabViewController>();
            twitchTabController.setup(
              token: r.accessToken,
              broadcasterId: r.twitchUser.id,
            );
          }
        },
      );
    });
  }

  Future<void> _initializePubSubService() async {
    twitchPubSubService = Get.find<TwitchPubSubService>();
    if (twitchData.value != null) {
      twitchPubSubService?.setup(
        accessToken: twitchData.value!.accessToken,
        channelName: twitchData.value!.twitchUser.login,
      );
      twitchPubSubService?.connect();
    }
  }

  Future<void> _initializeEventSubService() async {
    twitchEventSubService = Get.find<TwitchEventSubService>();
    if (twitchData.value != null) {
      twitchEventSubService?.setup(
        token: twitchData.value!.accessToken,
        channel: twitchData.value!.twitchUser.login,
      );
      twitchEventSubService?.connect();
    }
  }

  Future<void> _setupCrashlytics() async {
    await FirebaseCrashlytics.instance.setUserIdentifier(
      twitchData.value!.twitchUser.id,
    );
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  @override
  void onClose() {
    debounceSplitResize?.cancel();
    timerRefreshToken?.cancel();
    super.onClose();
  }

  // This is a debounce function to avoid spamming save settings when resizing the split view
  void onSplitResized(UnmodifiableListView<double?> weight) {
    Settings settings = settingsService.settings.value;

    if (debounceSplitResize?.isActive ?? false) {
      debounceSplitResize?.cancel();
    }
    debounceSplitResize = Timer(const Duration(milliseconds: 500), () {
      settingsService.settings.value = settings.copyWith(
        generalSettings: settings.generalSettings.copyWith(
          splitViewWeights: [weight[0]!, weight[1]!],
        ),
      );
      settingsService.saveSettings();
    });
  }

  void sendChatMessage(String message, [String? channel]) {
    if (Get.find<ChatsController>().selectedChatGroup.value == null) {
      return;
    }

    ChatViewController chatViewController = Get.find<ChatViewController>(
      tag: Get.find<ChatsController>().selectedChatGroup.value?.id,
    );
    List<TwitchChat> twitchChats = chatViewController.twitchChats.toList();
    List<KickChat> kickChats = chatViewController.kickChats.toList();

    if (kickChats.isNotEmpty && twitchChats.isNotEmpty ||
        kickChats.length > 1 ||
        twitchChats.length > 1) {
      selectChatToSend(
        Get.context!,
        this,
        twitchChats,
        kickChats,
        message,
      );
      return;
    }

    if (kickChats.isNotEmpty && twitchChats.isEmpty) {
      sendKickMessageToChat(kickChats.first.username, message);
    }

    if (kickChats.isEmpty && twitchChats.isNotEmpty) {
      sendTwitchMessageToChat(twitchChats.first.channel, message);
    }

    clearChatInput();
  }

  void clearChatInput() {
    chatInputController.text = '';
    Get.find<ChatsController>().selectedMessage.value = null;
    isPickingEmote.value = false;
  }

  void sendKickMessageToChat(String username, String message) {
    postKickChatMessageUseCase(
      params: PostKickChatMessageParams(
        accessToken: kickData.value!.accessToken,
        message: message,
        broadcasterUserId: kickData.value!.kickUser.userId,
      ),
    );
  }

  void sendTwitchMessageToChat(String channel, String message) {
    if (twitchData.value == null) {
      return;
    }

    final twitchChat = TwitchChat(
      channel,
      twitchData.value!.twitchUser.login,
      twitchData.value!.accessToken,
      clientId: kTwitchAuthClientId,
    );
    twitchChat.connect();

    twitchChat.isConnected.addListener(() {
      if (twitchChat.isConnected.value) {
        twitchChat.sendMessage(message);
        twitchChat.close();
      }
    });
  }

  void getEmotes() {
    emotesTabIndex.value = 0;
    isPickingEmote.toggle();
  }
}
