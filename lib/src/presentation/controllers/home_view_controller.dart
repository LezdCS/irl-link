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
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/views/chat_view.dart';
import 'package:irllink/src/presentation/views/home_view.dart';
import 'package:irllink/src/presentation/views/tabs/kick_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/views/tabs/realtime_irl_tab_view.dart';
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

  TwitchCredentials? twitchData;
  KickCredentials? kickData;

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
      if (Get.arguments.length == 1) {
        final credentials = Get.arguments[0];
        if (credentials is TwitchCredentials) {
          twitchData = credentials;
          await _initializeTwitchServices();
          await _setupCrashlytics();
        } else if (credentials is KickCredentials) {
          kickData = credentials;
          await _initializeKickServices();
        }
      } else if (Get.arguments.length == 2) {
        final twitchCreds = Get.arguments[0];
        final kickCreds = Get.arguments[1];
        if (twitchCreds is TwitchCredentials && kickCreds is KickCredentials) {
          twitchData = twitchCreds;
          kickData = kickCreds;
          await _initializeTwitchServices();
          await _initializeKickServices();
          await _setupCrashlytics();
        }
      }
    }

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    minimumVersion.value = io.Platform.isAndroid
        ? remoteConfig.getString('minimum_version_android')
        : remoteConfig.getString('minimum_version_ios');

    await applySettings();

    super.onInit();
  }

  Future<void> _initializeKickServices() async {
    KickTabView kickPage = const KickTabView();
    tabElements.add(kickPage);
    tabController = TabController(length: tabElements.length, vsync: this);
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

    TwitchTabView twitchPage = const TwitchTabView();
    tabElements.add(twitchPage);

    tabController = TabController(length: tabElements.length, vsync: this);

    timerRefreshToken =
        Timer.periodic(const Duration(seconds: 13000), (Timer t) async {
      final refreshTokenResult =
          await refreshAccessTokenUseCase(params: twitchData!);
      refreshTokenResult.fold((l) => {}, (r) => twitchData = r);

      final refreshTokenResultKick =
          await refreshKickAccessTokenUseCase(params: kickData!);
      refreshTokenResultKick.fold((l) => {}, (r) => kickData = r);
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
        token: twitchData!.accessToken,
        channel: twitchData!.twitchUser.login,
      ),
      permanent: true,
    );
    subService.connect();
  }

  Future<void> _initializePubSubService(Dio dioTwitchClient) async {
    TwitchPubSubService pubSubService = await Get.putAsync(
      () => TwitchPubSubService().init(
        accessToken: twitchData!.accessToken,
        channelName: twitchData!.twitchUser.login,
      ),
      permanent: true,
    );
    pubSubService.connect();
  }

  Future<void> _setupCrashlytics() async {
    await FirebaseCrashlytics.instance.setUserIdentifier(
      twitchData!.twitchUser.id,
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

    // Check if Realtime IRL have to be removed
    if (Get.isRegistered<RealtimeIrlViewController>() &&
        settings.rtIrlPushKey.isEmpty) {
      tabElements.removeWhere((t) => t is RealtimeIrlTabView);
      realtimeIrlViewController = null;
      await Get.delete<RealtimeIrlViewController>();
    }
  }

  void addTabs() {
    bool isSubscribed = Get.find<StoreService>().isSubscribed();
    Settings settings = settingsService.settings.value;

    // Check if OBS have to be added
    if (obsTabViewController == null && settings.isObsConnected) {
      obsTabViewController = Get.find<ObsTabViewController>();
      tabElements.insert(1, const ObsTabView());
    }

    // Check if StreamElements have to be added
    if (isSubscribed && streamelementsViewController.value == null) {
      final box = GetStorage();
      var seCredentialsString = box.read('seCredentials');
      if (seCredentialsString != null) {
        streamelementsViewController.value =
            Get.find<StreamelementsViewController>();
        tabElements.insert(1, const StreamelementsTabView());
      }
    }

    // Check if Realtime IRL have to be added
    if (settings.rtIrlPushKey.isNotEmpty && realtimeIrlViewController == null) {
      realtimeIrlViewController = Get.find<RealtimeIrlViewController>();
      tabElements.add(const RealtimeIrlTabView());
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

    RxList<ChatView> groupsViews = RxList<ChatView>.from(chatsViews);

    // 1. Find the groups that are in the groupsViews but not in the settings to remove them
    List<ChatGroup> settingsGroups =
        settings.chatSettings.copyWith().chatGroups;
    List<ChatGroup> groupsToRemove = groupsViews
        .where(
          (groupView) => !settingsGroups
              .any((sGroup) => sGroup.id == groupView.chatGroup.id),
        )
        .map((groupView) => groupView.chatGroup)
        .toList();
    for (var group in groupsToRemove) {
      // We do not remove the 'Permanent First Group'
      if (group.id == 'permanentFirstGroup') {
        continue;
      }
      ChatView groupView =
          groupsViews.firstWhere((g) => g.chatGroup.id == group.id);
      chatsViews.remove(groupView);
      Get.delete<ChatViewController>(tag: group.id);
    }

    // 2. Find the groups that are in the settings but not in the groupsViews to add them
    List<ChatGroup> groupsToAdd = settingsGroups
        .where(
          (sGroup) => !groupsViews
              .any((groupView) => groupView.chatGroup.id == sGroup.id),
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
    ChatGroup? permanentFirstGroup =
        settings.chatSettings.permanentFirstGroup.copyWith();
    // if the permanentFirstGroup is not in the channels, we add it
    if (!chatsViews.any(
      (groupView) => groupView.chatGroup.id == permanentFirstGroup?.id,
    )) {
      if (twitchData != null) {
        // We add the Twitch Chat of the user to the first position of the channels of this group
        List<Channel> updatedChannels = List.from(permanentFirstGroup.channels);
        updatedChannels.insert(
          0,
          Channel(
            platform: Platform.twitch,
            channel: twitchData!.twitchUser.login,
            enabled: true,
          ),
        );
        permanentFirstGroup = permanentFirstGroup.copyWith(
          channels: updatedChannels,
        );
      }
      ChatView groupView = ChatView(
        chatGroup: permanentFirstGroup,
      );
      await putChat(permanentFirstGroup);
      chatsViews.insert(0, groupView);
    }

    // 4. Call the createChats function for each group to update the chats inside
    for (ChatView c in chatsViews) {
      if (c.chatGroup.id == permanentFirstGroup.id) {
        c.controller.updateChannels(
          permanentFirstGroup.channels,
          twitchData?.twitchUser.login,
        );
      } else {
        ChatGroup group =
            settingsGroups.firstWhere((g) => g.id == c.chatGroup.id);
        c.controller.updateChannels(
          group.channels,
          twitchData?.twitchUser.login,
        );
      }
      c.controller.createChats();
    }

    chatTabsController = TabController(length: chatsViews.length, vsync: this);
    if (chatsViews.isEmpty) {
      selectedChatIndex = null;
      selectedChatGroup.value = null;
    }

    if (selectedChatIndex != null) {
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

    _clearChatInput();
  }

  void _clearChatInput() {
    chatInputController.text = '';
    selectedMessage.value = null;
    isPickingEmote.value = false;
  }

  void sendKickMessageToChat(String username, String message) {
    if (kickData == null) {
      return;
    }

    postKickChatMessageUseCase(
      params: PostKickChatMessageParams(
        accessToken: kickData!.accessToken,
        message: message,
        broadcasterUserId: kickData!.kickUser.userId,
      ),
    );
  }

  void sendTwitchMessageToChat(String channel, String message) {
    if (twitchData == null) {
      return;
    }

    final twitchChat = TwitchChat(
      channel,
      twitchData!.twitchUser.login,
      twitchData!.accessToken,
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
