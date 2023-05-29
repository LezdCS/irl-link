import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/tabs/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/tabs/twitch_tab_view.dart';
import 'package:split_view/split_view.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../routes/app_routes.dart';
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
  RxList<Widget> tabElements = <Widget>[].obs;

  TwitchCredentials? twitchData;

  //chat input
  late TextEditingController chatInputController;
  RxList<Emote> twitchEmotes = <Emote>[].obs;

  //emote picker
  RxBool isPickingEmote = false.obs;
  late ChatViewController chatViewController;
  ObsTabViewController? obsTabViewController;
  StreamelementsViewController? streamelementsViewController;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  Timer? timerRefreshToken;
  Timer? timerKeepSpeakerOn;
  AudioPlayer audioPlayer = AudioPlayer();

  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<ProductDetails> products = [];
  RxBool purchasePending = false.obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  RxBool displayDashboard = false.obs;

  @override
  void onInit() async {
    chatInputController = TextEditingController();

    if (Get.arguments != null) {
      TwitchTabView twitchPage = TwitchTabView();
      tabElements.add(twitchPage);

      tabController = TabController(length: tabElements.length, vsync: this);

      twitchData = Get.arguments[0];

      timerRefreshToken = Timer.periodic(
        Duration(seconds: 13000),
        (Timer t) => homeEvents
            .refreshAccessToken(twitchData: twitchData!)
            .then((value) => {
                  if (value.error == null) {twitchData = value.data!}
                }),
      );
    }
    await this.getSettings();
    await this.getStoreProducts();

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    initListeningStorePurchase();
    super.onInit();
  }

  @override
  void onReady() {
    chatViewController = Get.find<ChatViewController>();
    super.onReady();
  }

  @override
  void onClose() {
    timerRefreshToken?.cancel();
    timerKeepSpeakerOn?.cancel();
    super.onClose();
  }

  Future generateTabs() async {
    tabElements.clear();

    TwitchTabView twitchPage = TwitchTabView();
    tabElements.add(twitchPage);

    bool isSubscribed = purchases.firstWhereOrNull(
          (element) => element.productID == "irl_premium_subscription",
        ) !=
        null;
    if (isSubscribed &&
        settings.value.streamElementsAccessToken != null &&
        settings.value.streamElementsAccessToken!.isNotEmpty) {
      streamelementsViewController = Get.find<StreamelementsViewController>();
      StreamelementsTabView streamelementsPage = StreamelementsTabView();
      tabElements.add(streamelementsPage);
    }

    if (settings.value.isObsConnected! || twitchData == null) {
      obsTabViewController = Get.find<ObsTabViewController>();
      ObsTabView obsPage = ObsTabView();
      tabElements.add(obsPage);
    }

    settings.value.browserTabs!.forEach((element) {
      WebPageView page = WebPageView(element['title'], element['url']);
      tabElements.add(page);
    });

    tabController = TabController(length: tabElements.length, vsync: this);
  }

  void sendChatMessage(String message) {
    if (twitchData == null) return;

    String token = twitchData!.accessToken;
    String nick = twitchData!.twitchUser.login;
    WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
      IOWebSocketChannel channel = IOWebSocketChannel(ws);
      channel.sink.add('PASS oauth:' + token);
      channel.sink.add('NICK ' + nick);
      channel.sink.add('JOIN #${chatViewController.ircChannelJoined}');
      channel.sink
          .add('PRIVMSG #${chatViewController.ircChannelJoined} :$message\r\n');
      channel.sink.add('PART #${chatViewController.ircChannelJoined}');
      channel.sink.close(status.goingAway);
      ws.close();
    });
    chatInputController.text = '';
    chatViewController.selectedMessage.value = null;
    isPickingEmote.value = false;
  }

  void getEmotes() {
    List<Emote> emotes = List.from(chatViewController.twitchEmotes)
      ..addAll(chatViewController.thirdPartEmotes);
    twitchEmotes
      ..clear()
      ..addAll(emotes);
    isPickingEmote.toggle();
  }

  void searchEmote(String input) {
    List<Emote> emotes = List.from(chatViewController.twitchEmotes)
      ..addAll(chatViewController.thirdPartEmotes);
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
    Get.offAllNamed(Routes.LOGIN);
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
      if (!settings.value.isDarkMode!) {
        Get.changeThemeMode(ThemeMode.light);
      }
      if (settings.value.keepSpeakerOn!) {
        const path = "../lib/assets/blank.mp3";
        timerKeepSpeakerOn = Timer.periodic(
          Duration(minutes: 5),
          (Timer t) async => await audioPlayer.play(AssetSource(path)),
        );
      } else {
        timerKeepSpeakerOn?.cancel();
      }
      Locale locale = new Locale(settings.value.appLanguage!["languageCode"],
          settings.value.appLanguage!["countryCode"]);
      Get.updateLocale(locale);
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

    await InAppPurchase.instance.restorePurchases();
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        purchasePending.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          purchasePending.value = false;
          Get.snackbar(
            "Error",
            purchaseDetails.error!.message,
            snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.error_outline, color: Colors.red),
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
              icon: Icon(Icons.error_outline, color: Colors.red),
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
    });
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
        icon: Icon(Icons.check, color: Colors.green),
        borderWidth: 1,
        borderColor: Colors.green,
      );
    }
  }

  Future<void> getStoreProducts() async {
    const Set<String> _kIds = <String>{'irl_premium_subscription'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    products = response.productDetails;
  }
}
