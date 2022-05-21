import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:irllink/src/presentation/widgets/twitch_tab_view.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../widgets/web_page_view.dart';
import 'chat_view_controller.dart';

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  SplitViewController splitViewController =
      SplitViewController(limits: [null, WeightLimit(min: 0.12, max: 0.92)]);

  //TABS
  late TabController tabController;
  RxList<Widget> tabElements = <Widget>[].obs;

  late TwitchCredentials twitchData;

  //chat input
  late TextEditingController chatInputController;
  RxList<Emote> twitchEmotes = <Emote>[].obs;

  //emote picker
  RxBool isPickingEmote = false.obs;
  late ChatViewController chatViewController;
  late ObsTabViewController obsTabViewController;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  late Timer timerRefreshToken;
  late Timer timerKeepSpeakerOn;
  // final player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void onInit() async {
    chatInputController = TextEditingController();

    TwitchTabView twitchPage = TwitchTabView();
    tabElements.add(twitchPage);

    // StreamelementsTabView streamelementsPage = StreamelementsTabView();
    // tabElements.add(streamelementsPage);

    tabController = TabController(length: tabElements.length, vsync: this);

    twitchData = Get.arguments[0];

    timerRefreshToken = Timer.periodic(
      Duration(seconds: 13000),
      (Timer t) => {
        homeEvents.refreshAccessToken(twitchData: twitchData).then((value) => {
              if (value.error == null) {twitchData = value.data!}
            }),
      },
    );

    await this.getSettings();

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    super.onInit();
  }

  @override
  void onReady() {
    chatViewController = Get.find<ChatViewController>();
    obsTabViewController = Get.find<ObsTabViewController>();
    super.onReady();
  }

  @override
  void onClose() {
    timerRefreshToken.cancel();
    timerRefreshToken.cancel();
    super.onClose();
  }

  Future generateTabs() async {
    tabElements.clear();
    TwitchTabView twitchPage = TwitchTabView();
    tabElements.add(twitchPage);

    // StreamelementsTabView streamelementsPage = StreamelementsTabView();
    // tabElements.add(streamelementsPage);

    if (settings.value.isObsConnected!) {
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
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;
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

  Future getSettings() async {
    AudioCache cache = AudioCache(prefix: '');
    const path = "lib/assets/blank.mp3";
    AudioPlayer player;
    await homeEvents.getSettings().then((value) async => {
          if (value.error == null)
            {
              settings.value = value.data!,
              await this.generateTabs(),
              if(!settings.value.isDarkMode!){
                Get.changeThemeMode(ThemeMode.light)
              },
              if(settings.value.keepSpeakerOn!){
                timerRefreshToken = Timer.periodic(
                  Duration(minutes: 5),
                    (Timer t) async => {
                    player = await cache.play(path),
                  },
                ),
              }else{
                timerRefreshToken.cancel(),
              }
            },
        });
  }
}
