import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/streamelements_usecase.dart';
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
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/twitch_repository_impl.dart';
import '../../domain/usecases/settings_usecase.dart';
import '../../domain/usecases/twitch_usecase.dart';
import '../widgets/chats/chat_view.dart';
import '../widgets/tabs/streamelements_tab_view.dart';
import '../widgets/web_page_view.dart';
import 'chat_view_controller.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/core/utils/globals.dart' as globals;

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  SplitViewController? splitViewController =
      SplitViewController(limits: [null, WeightLimit(min: 0.12, max: 0.92)]);

  //TABS
  late TabController tabController;
  Rx<int> tabIndex = 0.obs;
  RxList<Widget> tabElements = <Widget>[].obs;
  RxList<WebPageView> iOSAudioSources = <WebPageView>[].obs;

  TwitchCredentials? twitchData;

  // StreamElements
  SeCredentials? seCredentials;
  SeMe? seMe;

  //chat input
  late TextEditingController chatInputController;
  RxList<Emote> twitchEmotes = <Emote>[].obs;

  //emote picker
  RxBool isPickingEmote = false.obs;
  ObsTabViewController? obsTabViewController;
  StreamelementsViewController? streamelementsViewController;

  late Rx<Settings> settings = const Settings.defaultSettings().obs;

  Timer? timerRefreshToken;
  Timer? timerKeepSpeakerOn;
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool displayDashboard = false.obs;

  RxList<ChatView> channels = <ChatView>[].obs;
  ChatGroup? selectedChatGroup;
  int? selectedChatIndex;

  late TabController chatTabsController;
  Rxn<entity.ChatMessage> selectedMessage = Rxn<entity.ChatMessage>();

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    chatTabsController = TabController(length: 0, vsync: this);

    if (Get.arguments != null) {
      TwitchTabView twitchPage = const TwitchTabView();
      tabElements.add(twitchPage);

      tabController = TabController(length: tabElements.length, vsync: this);

      twitchData = Get.arguments[0];

      homeEvents.getSeCredentialsFromLocal().then((value) => {
            if (value.error == null)
              {
                seCredentials = value.data!,
                homeEvents.getSeMe(seCredentials!.accessToken).then((value) => {
                      globals.talker?.debug('seMe value: ', value.data),
                      if (value.error == null) {seMe = value.data!}
                    }),
              },
          });

      timerRefreshToken =
          Timer.periodic(const Duration(seconds: 13000), (Timer t) {
        homeEvents.refreshAccessToken(twitchData: twitchData!).then((value) => {
              if (value.error == null) {twitchData = value.data!}
            });

        if (seCredentials != null) {
          homeEvents
              .refreshSeAccessToken(seCredentials: seCredentials!)
              .then((value) => {
                    if (value.error == null) {seCredentials = value.data!}
                  });
        }
      });
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

  void lazyPutChat(ChatGroup chatGroup) {
    Get.lazyPut(
      () => ChatViewController(
        homeEvents: HomeEvents(
          twitchUseCase: TwitchUseCase(
            twitchRepository: TwitchRepositoryImpl(),
          ),
          settingsUseCase: SettingsUseCase(
            settingsRepository: SettingsRepositoryImpl(),
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

  Future generateTabs() async {
    tabElements.clear();

    TwitchTabView twitchPage = const TwitchTabView();
    tabElements.add(twitchPage);

    bool isSubscribed = Get.find<StoreController>().isSubscribed();
    if ((twitchData == null && isSubscribed) ||
        isSubscribed && seCredentials != null) {
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

  void generateChats() {
    if (twitchData == null) {
      return;
    }

    RxList<ChatView> chatViews = RxList<ChatView>.from(channels);
    if (channels.firstWhereOrNull((element) => element.chatGroup.id == '1') ==
        null) {
      ChatGroup chatGroupSelf = ChatGroup(id: '1', channels: [
        Channel(
          platform: Platform.twitch,
          channel: twitchData?.twitchUser.login ?? '',
          enabled: true,
        )
      ]);
      lazyPutChat(chatGroupSelf);
      channels.add(
        ChatView(
          chatGroup: chatGroupSelf,
        ),
      );
    }

    for (var temp in chatViews) {
      if (temp.chatGroup.id == '1') {
        continue;
      }
      ChatView view = channels
          .firstWhere((element) => element.chatGroup.id == temp.chatGroup.id);

      ChatGroup group = view.chatGroup;
      if (settings.value.chatSettings!.chatGroups
          .map((e) => e.id)
          .contains(group.id)) {
        continue;
      }

      if (selectedChatGroup == group) {
        selectedChatGroup = channels.isNotEmpty
            ? Get.find<ChatViewController>(tag: channels[0].chatGroup.id)
                .chatGroup
            : null;
        selectedChatIndex = channels.isNotEmpty ? 0 : null;
      }

      channels.remove(view);
      Get.delete<ChatViewController>(tag: group.id);
    }

    for (ChatGroup chatGroup in settings.value.chatSettings!.chatGroups) {
      if (channels.firstWhereOrNull(
              (channel) => channel.chatGroup.id == chatGroup.id) ==
          null) {
        lazyPutChat(chatGroup);
        channels.add(
          ChatView(
            chatGroup: chatGroup,
          ),
        );
      }
    }

    chatTabsController = TabController(length: channels.length, vsync: this);

    if (channels.isEmpty) {
      selectedChatIndex = null;
      selectedChatGroup = null;
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
    ChatViewController? chatController =
        Get.find<ChatViewController>(tag: selectedChatGroup!.id);
    for (TwitchChat twitchChat in chatController.twitchChats) {
      List<Emote> emotes = List.from(twitchChat.emotes)
        ..addAll(twitchChat.emotesFromSets)
        ..addAll(twitchChat.thirdPartEmotes);
      twitchEmotes
        ..clear()
        ..addAll(emotes);
    }

    isPickingEmote.toggle();
  }

  void searchEmote(String input) {
    ChatViewController? chatController =
        Get.find<ChatViewController>(tag: selectedChatGroup!.id);

    for (TwitchChat twitchChat in chatController.twitchChats) {
      List<Emote> emotes = List.from(twitchChat.emotes)
        ..addAll(twitchChat.emotesFromSets)
        ..addAll(twitchChat.thirdPartEmotes);
      emotes = emotes
          .where(
            (emote) => emote.name.toLowerCase().contains(input.toLowerCase()),
          )
          .toList();
      twitchEmotes
        ..clear()
        ..addAll(emotes);
    }
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
      generateChats();
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
