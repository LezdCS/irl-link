import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
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
    with GetSingleTickerProviderStateMixin {
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

  @override
  void onInit() {
    chatInputController = new TextEditingController();

    twitchData = Get.arguments[0];

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    TwitchTabView twitchPage = TwitchTabView();
    ObsTabView obsPage = ObsTabView();
    StreamelementsTabView streamelementsPage = StreamelementsTabView();
    WebPageView page1View = WebPageView("Youtube", "https://www.youtube.com");

    tabElements.add(twitchPage);
    tabElements.add(obsPage);
    tabElements.add(streamelementsPage);
    // tabElements.add(page1View);

    tabController = new TabController(length: tabElements.length, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    chatViewController = Get.find<ChatViewController>();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
}
