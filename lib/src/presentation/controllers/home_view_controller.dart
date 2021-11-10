import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/Model/WebPage.dart';
import 'package:irllink/src/domain/entities/twitch.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeViewController extends GetxController
    with SingleGetTickerProviderMixin {
  HomeViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  late TabController tabController;
  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  RxList<WebPage> internetPages = <WebPage>[].obs;

  late IOWebSocketChannel channel;
  late Twitch twitchData;

  @override
  void onInit() {
    tabController = new TabController(length: 3, vsync: this);

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    WebPage page1 = new WebPage("Twitch", "https://www.twitch.tv", true);
    WebPage page2 = new WebPage("Youtube", "https://www.youtube.com", true);
    WebPage page3 =
        new WebPage("Steam", "https://www.steamcommunity.com/id/Lezd/", true);

    internetPages.add(page1);
    internetPages.add(page2);
    internetPages.add(page3);

    homeEvents.getTwitchFromLocal().then((value) {
      twitchData = value.data!;

      //on met le super.onInit() dans le then pour
      // qu'on passe au onReady seulement quand on a bien récup toutes les datas
      super.onInit();
    });
  }

  @override
  void onReady() {
    var token = twitchData.accessToken;
    var nick = twitchData.preferredUsername;
    WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
      // create the stream channel
      channel = IOWebSocketChannel(ws);

      channel.sink.add('PASS oauth:' + token);
      channel.sink.add('NICK ' + nick);

      channel.sink.add('JOIN #lezd_');
      //channel.sink.add('PRIVMSG #lezd_ okay');
      channel.sink.add('PART #lezd_');
      channel.stream.listen((message) {
        debugPrint(message);
      });
    });

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.close(status.goingAway);
    super.onClose();
  }
}
