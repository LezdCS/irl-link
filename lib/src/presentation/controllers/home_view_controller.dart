import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
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
import '../widgets/chat_view.dart';
import '../widgets/tabs/streamelements_tab_view.dart';
import '../widgets/web_page_view.dart';
import 'chat_view_controller.dart';

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

  TwitchCredentials? twitchData;

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

  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<ProductDetails> products = [];
  RxBool purchasePending = false.obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  RxBool displayDashboard = false.obs;

  RxList<ChatView> channels = <ChatView>[].obs;
  TwitchChat? selectedChat;
  int? selectedChatIndex;

  late TabController chatTabsController;
  Rxn<ChatMessage> selectedMessage = Rxn<ChatMessage>();

  late FlutterTts flutterTts;

  @override
  void onInit() async {
    chatInputController = TextEditingController();
    chatTabsController = TabController(length: 0, vsync: this);

    flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      flutterTts.setEngine(flutterTts.getDefaultEngine.toString());
    }

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
    await getStoreProducts();

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    initListeningStorePurchase();
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

    bool isSubscribed = purchases.firstWhereOrNull(
          (element) => element.productID == "irl_premium_subscription",
        ) !=
        null;
    if (isSubscribed &&
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

    for (var element in settings.value.browserTabs!) {
      if (element['toggled'] == null || element['toggled']) {
        WebPageView page = WebPageView(element['title'], element['url']);
        tabElements.add(page);
      }
    }

    tabController = TabController(length: tabElements.length, vsync: this);
    if (tabIndex.value > tabElements.length - 1) {
      tabIndex.value = 0;
      tabController.animateTo(tabIndex.value);
    }
  }

  void generateChats() {
    String self = twitchData!.twitchUser.login;

    RxList<ChatView> tempChannels = RxList<ChatView>.from(channels);
    for (var temp in tempChannels) {
      ChatView view =
          channels.firstWhere((element) => element.channel == temp.channel);
      String channel = view.channel;
      if (channel == self) continue;
      if (settings.value.chatSettings!.chatsJoined.contains(channel)) {
        continue;
      }

      if (selectedChat?.channel == channel) {
        selectedChat = channels.isNotEmpty
            ? Get.find<ChatViewController>(tag: channels[0].channel).twitchChat
            : null;
        selectedChatIndex = channels.isNotEmpty ? 0 : null;
      }

      channels.remove(view);
      Get.delete<ChatViewController>(tag: channel);
    }

    for (String chat in settings.value.chatSettings!.chatsJoined) {
      if (channels.firstWhereOrNull((channel) => channel.channel == chat) ==
          null) {
        Get.lazyPut(
          () => ChatViewController(
            homeEvents: HomeEvents(
              twitchUseCase: TwitchUseCase(
                twitchRepository: TwitchRepositoryImpl(),
              ),
              settingsUseCase: SettingsUseCase(
                settingsRepository: SettingsRepositoryImpl(),
              ),
            ),
            channel: chat,
          ),
          tag: chat,
        );
        channels.add(
          ChatView(
            channel: chat,
          ),
        );
      }
    }

    bool joinSelfChannel = settings.value.chatSettings!.joinMyself;

    if (joinSelfChannel) {
      if (channels.firstWhereOrNull((channel) => channel.channel == self) ==
          null) {
        Get.lazyPut(
          () => ChatViewController(
            homeEvents: HomeEvents(
              twitchUseCase: TwitchUseCase(
                twitchRepository: TwitchRepositoryImpl(),
              ),
              settingsUseCase: SettingsUseCase(
                settingsRepository: SettingsRepositoryImpl(),
              ),
            ),
            channel: self,
          ),
          tag: self,
        );
        channels.insert(0, ChatView(channel: self));
      }
    } else {
      channels.remove(channels.firstWhereOrNull((c) => c.channel == self));
      Get.delete<ChatViewController>(tag: self);
      if (selectedChat?.channel == self) {
        selectedChat = channels.isNotEmpty
            ? Get.find<ChatViewController>(tag: channels[0].channel).twitchChat
            : null;
        selectedChatIndex = channels.isNotEmpty ? 0 : null;
      }
    }

    chatTabsController = TabController(length: channels.length, vsync: this);

    if (channels.isEmpty) {
      selectedChatIndex = null;
      selectedChat = null;
    }
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
    twitchChat.sendMessage(message);

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
      generateChats();
      initTts(settings.value);
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

  void initTts(Settings settings) async {
    //  The following setup allows background music and in-app audio session to continue simultaneously:
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage(settings.ttsSettings!.language);
    await flutterTts.setSpeechRate(settings.ttsSettings!.rate);
    await flutterTts.setVolume(settings.ttsSettings!.volume);
    await flutterTts.setPitch(settings.ttsSettings!.pitch);
    await flutterTts.setVoice(settings.ttsSettings!.voice);

    if (Platform.isAndroid) {
      await flutterTts.setQueueMode(1);
    }

    if (!settings.ttsSettings!.ttsEnabled) {
      //prevent the queue to continue if we come back from settings and turn off TTS
      flutterTts.stop();
    }
  }

  void getStore() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      // The store cannot be reached or accessed. Update the UI accordingly.
    }
  }

  void initListeningStorePurchase() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>;

    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (error) {
      debugPrint('not logged to any store');
    }
  }

  void listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        purchasePending.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          purchasePending.value = false;
          Get.snackbar(
            "Error",
            purchaseDetails.error!.message,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.error_outline, color: Colors.red),
            borderWidth: 1,
            borderColor: Colors.red,
          );
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            Get.snackbar(
              "Error",
              "Invalid purchase",
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.error_outline, color: Colors.red),
              borderWidth: 1,
              borderColor: Colors.red,
            );
            purchasePending.value = false;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    purchases.add(purchaseDetails);
    getSettings();
    purchasePending.value = false;

    if (purchaseDetails.status == PurchaseStatus.purchased) {
      Get.back();
      Get.snackbar(
        "Success",
        "Thanks for your purchase, enjoy your premium subscription!",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.check, color: Colors.green),
        borderWidth: 1,
        borderColor: Colors.green,
      );
    }
  }

  Future<void> getStoreProducts() async {
    const Set<String> kIds = <String>{'irl_premium_subscription'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    products = response.productDetails;
  }
}
