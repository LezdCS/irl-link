import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/list_move.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/realtime_irl_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/twitch_tab_view.dart';
import 'package:split_view/split_view.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../routes/app_routes.dart';
import '../../core/utils/constants.dart';
import '../../data/repositories/twitch_repository_impl.dart';
import '../../domain/usecases/twitch_usecase.dart';
import '../widgets/chats/chat_view.dart';
import '../widgets/tabs/streamelements_tab_view.dart';
import '../widgets/web_page_view.dart';
import 'chat_view_controller.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

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

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    chatTabsController = TabController(length: 0, vsync: this);
    emotesTabController = TabController(length: 0, vsync: this);
    if (Get.arguments != null) {
      TwitchTabView twitchPage = const TwitchTabView();
      tabElements.add(twitchPage);

      tabController = TabController(length: tabElements.length, vsync: this);

      twitchData = Get.arguments[0];

      timerRefreshToken =
          Timer.periodic(const Duration(seconds: 13000), (Timer t) {
        homeEvents.refreshAccessToken(twitchData: twitchData!).then(
              (value) => {
                if (value is DataSuccess) {twitchData = value.data}
              },
            );
      });
    }
    await applySettings();

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    super.onInit();
  }

  @override
  void onClose() {
    debounceSplitResize?.cancel();
    timerRefreshToken?.cancel();
    timerKeepSpeakerOn?.cancel();
    super.onClose();
  }

  void onSplitResized(UnmodifiableListView<double?> weight) {
    Settings settings = Get.find<SettingsService>().settings.value;

    if (debounceSplitResize?.isActive ?? false) debounceSplitResize?.cancel();
    debounceSplitResize = Timer(const Duration(milliseconds: 500), () {
      Get.find<SettingsService>().settings.value = settings.copyWith(
        generalSettings: settings.generalSettings?.copyWith(
          splitViewWeights: [weight[0]!, weight[1]!],
        ),
      );
      Get.find<SettingsService>().saveSettings();
    });
  }

  void lazyPutChat(ChatGroup chatGroup) {
    Get.lazyPut<ChatViewController>(
      () => ChatViewController(
        homeEvents: HomeEvents(
          twitchUseCase: TwitchUseCase(
            twitchRepository: TwitchRepositoryImpl(),
          ),
          streamelementsUseCase: StreamelementsUseCase(
            streamelementsRepository: StreamelementsRepositoryImpl(),
          ),
        ),
        chatGroup: chatGroup,
      ),
      tag: chatGroup.id,
    );
  }

  void reorderTabs() {
    Settings settings = Get.find<SettingsService>().settings.value;

    List<BrowserTab> tabs = settings.browserTabs!.tabs
        .where((t) => t.toggled && !t.iOSAudioSource)
        .toList();
    int diff = tabElements.length - tabs.length;
    tabs.forEachIndexed((index, tab) {
      // Find the index of the tab in the tabElements list
      int indexInTabs = tabElements.indexWhere(
        (element) => element is WebPageView && element.tab.id == tab.id,
      );
      if (indexInTabs == -1) return;
      // Move the tab to the correct index
      tabElements.move(indexInTabs, index + diff);
    });
    tabElements.refresh();
  }

  Future<void> removeTabs() async {
    Settings settings = Get.find<SettingsService>().settings.value;

    // Check if WebTabs have to be removed
    List webTabsToRemove = [];
    tabElements.whereType<WebPageView>().forEach((tabElement) {
      BrowserTab? tabExist = settings.browserTabs!.tabs.firstWhereOrNull(
        (settingsTab) => settingsTab.id == tabElement.tab.id,
      );
      if (tabExist == null) {
        // if the tab does not exist in the settings anymore, we remove it
        webTabsToRemove.add(tabElement);
      } else {
        // if the tab exist in the tabElements but is not toggled anymore, we remove it
        if (!tabExist.toggled) {
          webTabsToRemove.add(tabElement);
        }
      }
    });
    tabElements.removeWhere((t) => webTabsToRemove.contains(t));

    for (var tabElement in iOSAudioSources) {
      bool tabExist = settings.browserTabs!.tabs
          .any((settingsTab) => settingsTab.id == tabElement.tab.id);
      if (!tabExist) {
        iOSAudioSources.remove(tabElement);
      }
    }

    // Check if OBS have to be removed
    if (Get.isRegistered<ObsTabViewController>() && !settings.isObsConnected!) {
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
        (settings.rtIrlPushKey == null || settings.rtIrlPushKey!.isEmpty)) {
      tabElements.removeWhere((t) => t is RealtimeIrlTabView);
      realtimeIrlViewController = null;
      await Get.delete<RealtimeIrlViewController>();
    }
  }

  void addTabs() {
    bool isSubscribed = Get.find<StoreService>().isSubscribed();
    Settings settings = Get.find<SettingsService>().settings.value;

    // Check if OBS have to be added
    if (obsTabViewController == null && settings.isObsConnected!) {
      obsTabViewController = Get.find<ObsTabViewController>();
      ObsTabView obsPage = const ObsTabView();
      tabElements.insert(1, obsPage);
    }

    // Check if StreamElements have to be added
    if (isSubscribed && streamelementsViewController.value == null) {
      final box = GetStorage();
      var seCredentialsString = box.read('seCredentials');
      if (seCredentialsString != null) {
        streamelementsViewController.value =
            Get.find<StreamelementsViewController>();
        StreamelementsTabView streamelementsPage =
            const StreamelementsTabView();
        tabElements.insert(1, streamelementsPage);
      }
    }

    // Check if Realtime IRL have to be added
    if (settings.rtIrlPushKey != null &&
        settings.rtIrlPushKey!.isNotEmpty &&
        realtimeIrlViewController == null) {
      realtimeIrlViewController = Get.find<RealtimeIrlViewController>();
      RealtimeIrlTabView realtimeIrlTabView = const RealtimeIrlTabView();
      tabElements.insert(1, realtimeIrlTabView);
    }

    // Check if WebTabs have to be added
    for (BrowserTab tab in settings.browserTabs!.tabs) {
      if (!tab.toggled) continue;
      // first we check if the tab already exist
      bool tabExist = tabElements
          .whereType<WebPageView>()
          .any((element) => element.tab.id == tab.id);
      bool tabExistIniOSAudioSources =
          iOSAudioSources.any((element) => element.tab.id == tab.id);
      if (tabExist || tabExistIniOSAudioSources) {
        continue;
      }

      WebPageView page = WebPageView(tab);
      if (!tab.iOSAudioSource) {
        tabElements.add(page);
      } else {
        iOSAudioSources.add(page);
      }
    }
  }

  Future generateTabs() async {
    await removeTabs();
    addTabs();
    reorderTabs();

    tabController = TabController(length: tabElements.length, vsync: this);
    if (tabIndex.value > tabElements.length - 1) {
      tabIndex.value = 0;
    }
    tabController.animateTo(tabIndex.value);
  }

  void generateChats() {
    if (twitchData == null) {
      return;
    }
    Settings settings = Get.find<SettingsService>().settings.value;

    RxList<ChatView> groupsViews = RxList<ChatView>.from(chatsViews);

    // 1. Find the groups that are in the groupsViews but not in the settings to remove them
    List<ChatGroup> settingsGroups =
        settings.chatSettings!.copyWith().chatGroups;
    List<ChatGroup> groupsToRemove = groupsViews
        .where((groupView) => !settingsGroups
            .any((sGroup) => sGroup.id == groupView.chatGroup.id))
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
        .where((sGroup) => !groupsViews
            .any((groupView) => groupView.chatGroup.id == sGroup.id))
        .toList();
    for (var group in groupsToAdd) {
      ChatView groupView = ChatView(
        chatGroup: group,
      );
      lazyPutChat(group);
      chatsViews.add(groupView);
    }

    // 3. We add the 'Permanent First Group' from the settings to the first position if it does not exist yet in the channels
    ChatGroup? permanentFirstGroup =
        settings.chatSettings!.permanentFirstGroup.copyWith();
    // if the permanentFirstGroup is not in the channels, we add it
    if (!chatsViews.any(
        (groupView) => groupView.chatGroup.id == permanentFirstGroup?.id)) {
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

      ChatView groupView = ChatView(
        chatGroup: permanentFirstGroup,
      );
      lazyPutChat(permanentFirstGroup);
      chatsViews.insert(0, groupView);
    }

    // 4. Call the createChats function for each group to update the chats inside
    // for (ChatView c in chatsViews) {
    //   ChatViewController? chatController =
    //       Get.find<ChatViewController>(tag: c.chatGroup.id);
    //   if (c.chatGroup.id == permanentFirstGroup.id) {
    //     chatController.updateChannels(
    //       permanentFirstGroup.channels,
    //       twitchData!.twitchUser.login,
    //     );
    //   } else {
    //     ChatGroup group =
    //         settingsGroups.firstWhere((g) => g.id == c.chatGroup.id);
    //     chatController.updateChannels(
    //       group.channels,
    //       twitchData!.twitchUser.login,
    //     );
    //   }
    //   chatController.createChats();
    // }

    chatTabsController = TabController(length: chatsViews.length, vsync: this);
    if (chatsViews.isEmpty) {
      selectedChatIndex = null;
      selectedChatGroup.value = null;
    }
  }

  void sendChatMessage(String message, String channel) {
    if (twitchData == null) return;

    TwitchChat twitchChat = TwitchChat(
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

    chatInputController.text = '';
    selectedMessage.value = null;
    isPickingEmote.value = false;
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
      Settings settings = Get.find<SettingsService>().settings.value;

      generateTabs();
      generateChats();

      Get.find<TtsService>().initTts(settings);

      // DARK MODE
      if (!settings.generalSettings!.isDarkMode) {
        Get.changeThemeMode(ThemeMode.light);
      }

      // SPEAKER SETTING
      if (settings.generalSettings!.keepSpeakerOn) {
        const path = "../lib/assets/blank.mp3";
        timerKeepSpeakerOn = Timer.periodic(
          const Duration(minutes: 5),
          (Timer t) async => await audioPlayer.play(AssetSource(path)),
        );
      } else {
        timerKeepSpeakerOn?.cancel();
      }

      // SPLIT VIEW
      splitViewController?.weights = settings.generalSettings!.splitViewWeights;
    }
  }
}
