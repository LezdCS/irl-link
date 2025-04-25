import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/twitch_event_sub_service.dart';
import 'package:irllink/src/core/services/twitch_pub_sub_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/core/utils/list_move.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/kick/kick_credentials.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/kick/kick_refresh_token_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/post_kick_chat_nessage_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/create_poll_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/end_poll_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/end_prediction_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/rtmp_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/twitch_tab_view_controller.dart';
import 'package:irllink/src/presentation/views/chat_view.dart';
import 'package:irllink/src/presentation/views/home_view.dart';
import 'package:irllink/src/presentation/views/tabs/kick_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/realtime_irl_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/rtmp_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
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
  });

  final RefreshTwitchTokenUseCase refreshAccessTokenUseCase;
  final KickRefreshTokenUseCase refreshKickAccessTokenUseCase;
  final SettingsService settingsService;
  final TalkerService talkerService;
  final PostKickChatMessageUseCase postKickChatMessageUseCase;
  SplitViewController? splitViewController = SplitViewController(
    limits: [null, WeightLimit(min: 0.12, max: 0.92)],
  );
  Timer? debounceSplitResize;

  // Tabs
  late TabController tabController;
  Rx<int> tabIndex = 0.obs;
  RxList<Widget> tabElements = <Widget>[].obs;
  RxList<WebPageView> iOSAudioSources = <WebPageView>[].obs;

  Rxn<TwitchCredentials> twitchData = Rxn<TwitchCredentials>();
  Rxn<KickCredentials> kickData = Rxn<KickCredentials>();

  // StreamElements
  Rxn<StreamelementsViewController> streamelementsViewController =
      Rxn<StreamelementsViewController>();

  // Chat input
  late TextEditingController chatInputController;

  // RealtimeIRL
  RealtimeIrlViewController? realtimeIrlViewController;

  // Emote picker
  RxBool isPickingEmote = false.obs;
  late TabController emotesTabController;
  RxInt emotesTabIndex = 0.obs;

  ObsTabViewController? obsTabViewController;

  Timer? timerRefreshToken;
  Timer? timerKeepSpeakerOn;
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool displayDashboard = false.obs;
  RtmpTabViewController? rtmpTabViewController;
  TwitchTabViewController? twitchTabViewController;
  KickTabViewController? kickTabViewController;

  // Chats
  RxList<ChatView> chatsViews = <ChatView>[].obs;
  Rxn<ChatGroup> selectedChatGroup = Rxn<ChatGroup>();
  int? selectedChatIndex;

  late TabController chatTabsController;
  Rxn<entity.ChatMessage> selectedMessage = Rxn<entity.ChatMessage>();

  RxList<PinnedMessage> pinnedMessages = <PinnedMessage>[].obs;
  RxBool showPinnedMessages = false.obs;

  RxString minimumVersion = ''.obs;

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    chatTabsController = TabController(length: 0, vsync: this);
    emotesTabController = TabController(length: 0, vsync: this);

    if (Get.arguments != null) {
      final twitchCreds = Get.arguments[0];
      final kickCreds = Get.arguments[1];
      if (twitchCreds is TwitchCredentials) {
        twitchData.value = twitchCreds;
        await _initializeTwitchServices();
        await _setupCrashlytics();
      }
      if (kickCreds is KickCredentials) {
        kickData.value = kickCreds;
        await _initializeKickServices();
      }
    }

    // Initialize RTMP Controller
    rtmpTabViewController = await Get.putAsync<RtmpTabViewController>(
      () async => RtmpTabViewController(
        settingsService: settingsService,
        talkerService: talkerService,
      ),
      permanent: true,
    );

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    minimumVersion.value = io.Platform.isAndroid
        ? remoteConfig.getString('minimum_version_android')
        : remoteConfig.getString('minimum_version_ios');

    await applySettings();

    super.onInit();
  }

  Future<void> _initializeKickServices() async {
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
  }

  Future<void> _initializeTwitchServices() async {
    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);
    final twitchRepositoryImpl = TwitchRepositoryImpl(
      remoteDataSource: TwitchRemoteDataSourceImpl(
        dioClient: dioTwitchClient,
        talker: talkerService.talker,
      ),
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );

    await _initializeEventSubService(twitchRepositoryImpl, dioTwitchClient);
    await _initializePubSubService(dioTwitchClient);

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
        },
      );
    });
  }

  Future<void> _initializeEventSubService(
    TwitchRepositoryImpl twitchRepositoryImpl,
    Dio dioTwitchClient,
  ) async {
    TwitchEventSubService subService = await Get.putAsync(
      () => TwitchEventSubService(
        createPollUseCase:
            CreatePollUseCase(twitchRepository: twitchRepositoryImpl),
        endPollUseCase: EndPollUseCase(twitchRepository: twitchRepositoryImpl),
        endPredictionUseCase:
            EndPredictionUseCase(twitchRepository: twitchRepositoryImpl),
        homeViewController: this,
        talker: talkerService.talker,
        dioClient: dioTwitchClient,
      ).init(
        token: twitchData.value!.accessToken,
        channel: twitchData.value!.twitchUser.login,
      ),
      permanent: true,
    );
    subService.connect();
  }

  Future<void> _initializePubSubService(Dio dioTwitchClient) async {
    TwitchPubSubService pubSubService = await Get.putAsync(
      () => TwitchPubSubService().init(
        accessToken: twitchData.value!.accessToken,
        channelName: twitchData.value!.twitchUser.login,
      ),
      permanent: true,
    );
    pubSubService.connect();
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
    timerKeepSpeakerOn?.cancel();
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

  Future<void> putChat(ChatGroup chatGroup) async {
    await Get.putAsync<ChatViewController>(
      () async {
        final controller = ChatViewController(
          chatGroup: chatGroup,
          homeViewController: this,
          settingsService: Get.find<SettingsService>(),
          talker: talkerService.talker,
          ttsService: Get.find<TtsService>(),
          watchService: Get.find<WatchService>(),
        );
        return controller;
      },
      tag: chatGroup.id,
    );
  }

  void reorderTabs() {
    Settings settings = Get.find<SettingsService>().settings.value;

    List<BrowserTab> tabs = settings.browserTabs.tabs
        .where((t) => t.toggled && !t.iOSAudioSource)
        .toList();
    int diff = tabElements.length - tabs.length;
    tabs.forEachIndexed((index, tab) {
      // Find the index of the tab in the tabElements list
      int indexInTabs = tabElements.indexWhere(
        (element) => element is WebPageView && element.tab.id == tab.id,
      );
      if (indexInTabs == -1) {
        return;
      }
      // Move the tab to the correct index
      tabElements.move(indexInTabs, index + diff);
    });
    tabElements.refresh();
  }

  void removeTabs() async {
    Settings settings = settingsService.settings.value;

    // Check if WebTabs have to be removed
    tabElements.removeWhere((tabElement) {
      if (tabElement is WebPageView) {
        BrowserTab? tabExist = settings.browserTabs.tabs.firstWhereOrNull(
          (settingsTab) => settingsTab.id == tabElement.tab.id,
        );
        return tabExist == null || !tabExist.toggled || tabExist.iOSAudioSource;
      }
      return false; // Keep other types of tabs
    });

    // Now we remove the audio sources that do no longer exist in the settings
    iOSAudioSources.removeWhere((tabElement) {
      BrowserTab? tabExist = settings.browserTabs.tabs.firstWhereOrNull(
        (settingsTab) => settingsTab.id == tabElement.tab.id,
      );
      return tabExist == null || !tabExist.toggled || !tabExist.iOSAudioSource;
    });

    // Check if OBS have to be removed
    if (Get.isRegistered<ObsTabViewController>() && !settings.isObsConnected) {
      tabElements.removeWhere((t) => t is ObsTabView);
      obsTabViewController = null;
      await Get.delete<ObsTabViewController>();
    }

    // Check if StreamElements have to be removed
    if (streamelementsViewController.value != null) {
      final box = GetStorage();
      var seCredentialsString = box.read('seCredentials');
      if (seCredentialsString == null) {
        tabElements.removeWhere((t) => t is StreamelementsTabView);
        streamelementsViewController.value = null;
        await Get.delete<StreamelementsViewController>();
      }
    }

    // Check if Twitch have to be removed
    if (twitchTabViewController != null && twitchData.value == null) {
      tabElements.removeWhere((t) => t is TwitchTabView);
      twitchTabViewController = null;
      await Get.delete<TwitchTabViewController>();
    }

    // Check if Kick have to be removed
    if (kickTabViewController != null && kickData.value == null) {
      tabElements.removeWhere((t) => t is KickTabView);
      kickTabViewController = null;
      await Get.delete<KickTabViewController>();
    }

    // Check if Realtime IRL have to be removed
    if (Get.isRegistered<RealtimeIrlViewController>() &&
        settings.rtIrlPushKey.isEmpty) {
      tabElements.removeWhere((t) => t is RealtimeIrlTabView);
      realtimeIrlViewController = null;
      await Get.delete<RealtimeIrlViewController>();
    }

    // Check if RTMP tab has to be removed (e.g., based on settings in the future)
    // For now, we assume it stays if initialized
    // if (rtmpTabViewController != null && !shouldShowRtmpTab) { // Example condition
    //   tabElements.removeWhere((t) => t is RtmpTabView);
    //   rtmpTabViewController = null;
    //   await Get.delete<RtmpTabViewController>();
    // }
  }

  void addTabs() {
    bool isSubscribed = Get.find<StoreService>().isSubscribed();
    Settings settings = settingsService.settings.value;

    // Check if OBS have to be added
    if (obsTabViewController == null && settings.isObsConnected) {
      obsTabViewController = Get.find<ObsTabViewController>();
      tabElements.insert(0, const ObsTabView());
    }

    // Check if Twitch have to be added
    if (twitchTabViewController == null && twitchData.value != null) {
      twitchTabViewController = Get.find<TwitchTabViewController>();
      tabElements.insert(0, const TwitchTabView());
    }

    // Check if Kick have to be added
    if (kickTabViewController == null && kickData.value != null) {
      kickTabViewController = Get.find<KickTabViewController>();
      tabElements.insert(0, const KickTabView());
    }

    // Check if StreamElements have to be added
    if (isSubscribed && streamelementsViewController.value == null) {
      final box = GetStorage();
      var seCredentialsString = box.read('seCredentials');
      if (seCredentialsString != null) {
        streamelementsViewController.value =
            Get.find<StreamelementsViewController>();
        tabElements.insert(0, const StreamelementsTabView());
      }
    }

    // Check if Realtime IRL have to be added
    if (settings.rtIrlPushKey.isNotEmpty && realtimeIrlViewController == null) {
      realtimeIrlViewController = Get.find<RealtimeIrlViewController>();
      tabElements.add(const RealtimeIrlTabView());
    }

    // Check if RTMP tab has to be added
    if (rtmpTabViewController != null &&
        !tabElements.any((t) => t is RtmpTabView)) {
      tabElements.add(const RtmpTabView());
    }

    // Only add the tabs that are toggled
    for (BrowserTab tab in settings.browserTabs.tabs.where((t) => t.toggled)) {
      // Check if the tab already exists
      bool tabExists = tabElements
              .whereType<WebPageView>()
              .any((element) => element.tab.id == tab.id) ||
          iOSAudioSources.any((element) => element.tab.id == tab.id);
      if (tabExists) {
        continue;
      }

      WebPageView page = WebPageView(tab, key: GlobalKey());
      if (!tab.iOSAudioSource) {
        tabElements.add(page);
      } else {
        iOSAudioSources.add(page);
      }
    }
  }

  Future generateTabs() async {
    removeTabs();
    addTabs();
    reorderTabs();

    tabController = TabController(length: tabElements.length, vsync: this);
    if (tabIndex.value > tabElements.length - 1) {
      tabIndex.value = 0;
    }
    tabController.animateTo(tabIndex.value);
  }

  Future<void> generateChats() async {
    Settings settings = settingsService.settings.value;

    List<ChatView> groupsViews = List<ChatView>.from(chatsViews);

    // 1. Find the groups that are in the groupsViews but not in the settings to remove them
    List<ChatGroup> settingsGroups =
        settings.chatSettings.copyWith().chatGroups;
    List<ChatGroup> groupsToRemove = groupsViews
        .where(
          (groupView) =>
              !settingsGroups
                  .any((sGroup) => sGroup.id == groupView.chatGroup.id) ||
              groupView.chatGroup.channels.isEmpty,
        )
        .map((groupView) => groupView.chatGroup)
        .toList();

    // Remove groups that are no longer in settings
    chatsViews.removeWhere((groupView) {
      if (groupView.chatGroup.id == 'permanentFirstGroup') {
        return false;
      }
      if (groupsToRemove.any((g) => g.id == groupView.chatGroup.id)) {
        Get.delete<ChatViewController>(tag: groupView.chatGroup.id);
        return true;
      }
      return false;
    });

    // 2. Find the groups that are in the settings but not in the groupsViews to add them
    List<ChatGroup> groupsToAdd = settingsGroups
        .where(
          (sGroup) =>
              !groupsViews
                  .any((groupView) => groupView.chatGroup.id == sGroup.id) &&
              sGroup.channels.isNotEmpty, // Only add groups with channels
        )
        .toList();
    for (var group in groupsToAdd) {
      ChatView groupView = ChatView(
        chatGroup: group,
      );
      await putChat(group);
      chatsViews.add(groupView);
    }

    // 3. We add the 'Permanent First Group' from the settings to the first position if it does not exist yet in the channels
    ChatGroup? permanentFirstGroupFromSettings =
        settings.chatSettings.permanentFirstGroup.copyWith();
    List<Channel> targetPermanentChannels =
        List.from(permanentFirstGroupFromSettings.channels);

    // Prepare user's channels if logged in
    Channel? userTwitchChannel;
    if (twitchData.value != null) {
      userTwitchChannel = Channel(
        platform: Platform.twitch,
        channel: twitchData.value!.twitchUser.login,
        enabled: true,
      );
    }
    Channel? userKickChannel;
    if (kickData.value != null) {
      userKickChannel = Channel(
        platform: Platform.kick,
        channel: kickData.value!.kickUser.name,
        enabled: true,
      );
    }

    // Add user's channels to the target list if they don't exist
    if (userKickChannel != null &&
        !targetPermanentChannels.any(
          (c) =>
              c.platform == Platform.kick &&
              c.channel == userKickChannel!.channel,
        )) {
      targetPermanentChannels.insert(0, userKickChannel);
    }
    if (userTwitchChannel != null &&
        !targetPermanentChannels.any(
          (c) =>
              c.platform == Platform.twitch &&
              c.channel == userTwitchChannel!.channel,
        )) {
      targetPermanentChannels.insert(0, userTwitchChannel);
    }

    // Find the existing permanent group view
    int permanentGroupIndex = chatsViews.indexWhere(
      (groupView) =>
          groupView.chatGroup.id == permanentFirstGroupFromSettings.id,
    );

    // If the permanent group view doesn't exist, create and add it
    if (permanentGroupIndex == -1) {
      ChatGroup permanentGroup = permanentFirstGroupFromSettings.copyWith(
        channels: targetPermanentChannels,
      );
      ChatView groupView = ChatView(
        chatGroup: permanentGroup,
      );
      await putChat(permanentGroup);
      chatsViews.insert(0, groupView);
      // Update the index as we just inserted it
      permanentGroupIndex = 0;
    }
    // No else needed here, the update happens in the loop below

    // 4. Call the updateChannels and createChats function for each group controller
    for (ChatView c in chatsViews) {
      List<Channel> channelsToUpdate;
      if (c.chatGroup.id == permanentFirstGroupFromSettings.id) {
        // Use the definitive target list for the permanent group
        channelsToUpdate = targetPermanentChannels;
      } else {
        // Use the channels from settings for other groups
        channelsToUpdate = settingsGroups
            .firstWhere(
              (g) => g.id == c.chatGroup.id,
              orElse: () => const ChatGroup(id: 'fallback', channels: []),
            )
            .channels;
      }

      c.controller.updateChannels(
        channelsToUpdate,
        twitchData.value?.twitchUser.login,
        kickData.value?.kickUser.name,
      );
      c.controller.createChats();
    }

    chatTabsController = TabController(length: chatsViews.length, vsync: this);
    if (chatsViews.isEmpty) {
      selectedChatIndex = null;
      selectedChatGroup.value = null;
    } else if (selectedChatIndex != null) {
      if (selectedChatIndex! >= chatsViews.length) {
        selectedChatIndex = 0;
      }
      chatTabsController.animateTo(selectedChatIndex!);
    }
  }

  void sendChatMessage(String message, [String? channel]) {
    if (selectedChatGroup.value == null) {
      return;
    }

    ChatViewController chatViewController = Get.find<ChatViewController>(
      tag: selectedChatGroup.value?.id,
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
    selectedMessage.value = null;
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

  void login() {
    Get.offAllNamed(Routes.login);
  }

  Future applySettings() async {
    {
      Settings settings = settingsService.settings.value;

      generateTabs();
      generateChats();

      // SPEAKER SETTING
      if (settings.generalSettings.keepSpeakerOn) {
        const path = "../lib/assets/blank.mp3";
        timerKeepSpeakerOn = Timer.periodic(
          const Duration(minutes: 5),
          (Timer t) async => audioPlayer.play(AssetSource(path)),
        );
      } else {
        timerKeepSpeakerOn?.cancel();
      }

      // SPLIT VIEW
      splitViewController?.weights = settings.generalSettings.splitViewWeights;
    }
  }
}
