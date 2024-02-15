import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/dashboard_controller.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/store_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/controllers/tts_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/twitch_tab_view.dart';
import 'package:split_view/split_view.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../routes/app_routes.dart';
import '../../core/utils/constants.dart';
import '../widgets/twitch_chat_view.dart';
import '../widgets/tabs/streamelements_tab_view.dart';
import '../widgets/web_page_view.dart';

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  SplitViewController? splitViewController =
      SplitViewController(limits: [null, WeightLimit(min: 0.12, max: 0.92)]);

  late Rx<Settings> settings = const Settings.defaultSettings().obs;

  TwitchCredentials? twitchData;

  //////////// TABS ////////////
  late TabController tabController;
  Rx<int> tabIndex = 0.obs;
  RxList<Widget> tabElements = <Widget>[].obs;
  RxList<WebPageView> iOSAudioSources = <WebPageView>[].obs;

  //////////// EMOTE PICKER ////////////
  RxBool isPickingEmote = false.obs;
  ObsTabViewController? obsTabViewController;
  StreamelementsViewController? streamelementsViewController;

  //////////// KEEP SPEAKER ON ////////////
  Timer? timerRefreshToken;
  Timer? timerKeepSpeakerOn;
  AudioPlayer audioPlayer = AudioPlayer();
  
  //////////// DASHBOARD ////////////
  RxBool displayDashboard = false.obs;

  //////////// CHATS ////////////
  RxList<TwitchChatView> channels = <TwitchChatView>[].obs;
  TwitchChat? selectedChat;
  int? selectedChatTab;
  late TextEditingController chatInputController;
  RxList<Emote> twitchEmotes = <Emote>[].obs;
  late TabController chatTabsController;
  Rxn<ChatMessage> selectedMessage = Rxn<ChatMessage>();

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    chatTabsController = TabController(length: 0, vsync: this);

    if (Get.arguments != null) {
      TwitchTabView twitchPage = const TwitchTabView();
      tabElements.add(twitchPage);

      tabController = TabController(length: tabElements.length, vsync: this);

      twitchData = Get.arguments[0];

      timerRefreshToken = Timer.periodic(
        const Duration(seconds: 13000),
        (Timer t) => homeEvents
            .refreshAccessToken(twitchData: twitchData!)
            .then((value) => {
                  if (value.error == null) {twitchData = value.data!}
                }),
      );
    }
    await getSettings();

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    super.onInit();
  }

  @override
  void onClose() {
    timerRefreshToken?.cancel();
    timerKeepSpeakerOn?.cancel();
    super.onClose();
  }

  Future generateTabs() async {
    tabElements.clear();

    TwitchTabView twitchPage = const TwitchTabView();
    tabElements.add(twitchPage);

    bool isSubscribed = Get.find<StoreController>().isSubscribed();
    if ((twitchData == null && isSubscribed) ||
        isSubscribed &&
            settings.value.streamElementsAccessToken != null &&
            settings.value.streamElementsAccessToken!.isNotEmpty) {
      streamelementsViewController = Get.find<StreamelementsViewController>();
      StreamelementsTabView streamelementsPage = const StreamelementsTabView();
      tabElements.add(streamelementsPage);
    }

    if (settings.value.isObsConnected! || twitchData == null) {
      obsTabViewController = Get.find<ObsTabViewController>();
      ObsTabView obsPage = const ObsTabView();
      tabElements.add(obsPage);
    }

    for (var element in settings.value.browserTabs!.where(
        (tab) => tab['iOSAudioSource'] == null || !tab['iOSAudioSource'])) {
      if (element['toggled'] == null || element['toggled']) {
        WebPageView page = WebPageView(element['title'], element['url']);
        tabElements.add(page);
      }
    }

    for (var element in settings.value.browserTabs!.where(
        (tab) => tab['iOSAudioSource'] != null && tab['iOSAudioSource'])) {
      if (element['toggled'] == null || element['toggled']) {
        WebPageView page = WebPageView(element['title'], element['url']);
        iOSAudioSources.add(page);
      }
    }

    tabController = TabController(length: tabElements.length, vsync: this);
    if (tabIndex.value > tabElements.length - 1) {
      tabIndex.value = 0;
    }
    tabController.animateTo(tabIndex.value);
  }

  void generateChatsTabs() {
    // get the chat groups saved in settings

    // compare current tabs and chats existing in the tabs with the settings
    // WARN: check if in the settings we should show our own twitch chat
    // if need to delete the complete tab, delete from the chatTabView RxList
    // and call Get.delete<anyController>(tag: anyTag) to remove the controller, either a chat controller or a chatTabViewController

    // if need to add, invoke a lazyPut for chatTabViewController
    // then add a new chatTabView in a RxList
  }

  void sendChatMessage(String message) {
    if (twitchData == null) return;

    TwitchChat twitchChat = TwitchChat(
      selectedChat?.channel,
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
    List<Emote> emotes = List.from(selectedChat?.emotes)
      ..addAll(selectedChat?.emotesFromSets)
      ..addAll(selectedChat?.thirdPartEmotes);
    twitchEmotes
      ..clear()
      ..addAll(emotes);
    isPickingEmote.toggle();
  }

  void searchEmote(String input) {
    List<Emote> emotes = List.from(selectedChat?.emotes)
      ..addAll(selectedChat?.emotesFromSets)
      ..addAll(selectedChat?.thirdPartEmotes);
    emotes = emotes
        .where(
          (emote) => emote.name.toLowerCase().contains(input.toLowerCase()),
        )
        .toList();
    twitchEmotes
      ..clear()
      ..addAll(emotes);
  }

  void login() {
    Get.offAllNamed(Routes.login);
  }

  void saveSettings() {
    homeEvents.setSettings(settings: settings.value);
  }

  Future getSettings() async {
    await homeEvents
        .getSettings()
        .then((value) async => await applySettings(value));
  }

  Future applySettings(value) async {
    {
      if (value.error != null) return;
      settings.value = value.data!;
      await generateTabs();
      Get.find<DashboardController>();
      generateChatsTabs();
      Get.find<TtsController>().initTts(settings.value);
      if (!settings.value.generalSettings!.isDarkMode) {
        Get.changeThemeMode(ThemeMode.light);
      }
      if (settings.value.generalSettings!.keepSpeakerOn) {
        const path = "../lib/assets/blank.mp3";
        timerKeepSpeakerOn = Timer.periodic(
          const Duration(minutes: 5),
          (Timer t) async => await audioPlayer.play(AssetSource(path)),
        );
      } else {
        timerKeepSpeakerOn?.cancel();
      }
      Locale locale = Locale(
          settings.value.generalSettings!.appLanguage["languageCode"],
          settings.value.generalSettings!.appLanguage["countryCode"]);
      Get.updateLocale(locale);
      splitViewController?.weights =
          settings.value.generalSettings!.splitViewWeights;
    }
  }
}
