import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/tabbar/tab_element.dart';
import 'package:irllink/src/domain/entities/tabbar/web_page.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeViewController extends GetxController
    with SingleGetTickerProviderMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  //TABS
  late TabController tabController;
  RxList<TabElement> tabElements = <TabElement>[].obs;

  late TwitchCredentials twitchData;
  late TextEditingController chatInputController;

  @override
  void onInit() {
    chatInputController = new TextEditingController();

    twitchData = Get.arguments[0];

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    WebPage page1 = new WebPage("Youtube", "https://www.youtube.com", true);
    TabElement twitchPage = new TabElement("Twitch");
    TabElement obsPage = new TabElement("OBS");

    tabElements.add(twitchPage);
    tabElements.add(obsPage);
    tabElements.add(page1);

    tabController = new TabController(length: tabElements.length, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendChatMessage(String message) {
    //TODO : change the JOIN if we are in another chat, same for PART
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;
    WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
      IOWebSocketChannel channel = IOWebSocketChannel(ws);
      channel.sink.add('PASS oauth:' + token);
      channel.sink.add('NICK ' + nick);
      channel.sink.add('JOIN #$nick');
      channel.sink.add('PRIVMSG #$nick :$message\r\n');
      channel.sink.add('PART #$nick');
      channel.sink.close(status.goingAway);
      ws.close();
    });
  }
}
