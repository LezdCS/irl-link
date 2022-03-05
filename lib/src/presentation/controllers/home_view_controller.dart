import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/obs_tab_view.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:irllink/src/presentation/widgets/streamelements_tab_view.dart';
import 'package:irllink/src/presentation/widgets/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'chat_view_controller.dart';

class HomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

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

  @override
  void onInit() {
    chatInputController = new TextEditingController();

    twitchData = Get.arguments[0];

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    TwitchTabView twitchPage = TwitchTabView();
    tabElements.add(twitchPage);

    StreamelementsTabView streamelementsPage = StreamelementsTabView();
    tabElements.add(streamelementsPage);

    // WebPageView page1View = WebPageView("Youtube", "https://www.youtube.com");
    // tabElements.add(page1View);

    tabController = TabController(length: tabElements.length, vsync: this);

    this.getSettings();

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
    super.onClose();
  }

  void createObsTab(){
    if (tabElements.firstWhereOrNull((tab) => tab is ObsTabView) == null) {
      ObsTabView obsPage = ObsTabView();
      int newSize = tabController.length + 1;
      tabController = new TabController(length: newSize, vsync: this);
      tabElements.add(obsPage);
    }
  }

  void removeObsTab(){
    if (tabElements.firstWhereOrNull((tab) => tab is ObsTabView) != null) {
      int newSize = tabController.length - 1;
      tabController = new TabController(length: newSize, vsync: this);
      tabElements.remove(tabElements.firstWhere((tab) => tab is ObsTabView));
    }
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
    List<Emote> emotes = chatViewController.twitchEmotes;
    twitchEmotes
      ..clear()
      ..addAll(emotes);
    isPickingEmote.toggle();
  }

  void searchEmote(String input) {
    List<Emote> emotes = chatViewController.twitchEmotes;
    twitchEmotes
      ..clear()
      ..addAll(emotes
          .where((emote) => emote.name.toLowerCase().contains(input))
          .toList());
  }

  Future getSettings() async {
    await homeEvents.getSettings().then((value) async => {
      if (value.error == null)
        {
          settings.value = value.data!,
          debugPrint("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"),
          if(settings.value.isObsConnected!){
            this.createObsTab(),
            debugPrint("ADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"),
          }else{
            this.removeObsTab(),
          }
        },
    });
  }
}
