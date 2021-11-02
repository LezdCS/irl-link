import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/Model/WebPage.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeViewController extends GetxController
    with SingleGetTickerProviderMixin {
  final box = GetStorage();

  late TabController tabController;
  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  RxList<WebPage> internetPages = <WebPage>[].obs;

  late var channel;

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

    super.onInit();
  }

  @override
  void onReady() {
    var token = box.read('TwitchAccessToken');
    var nick = box.read('username');
    WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
      // create the stream channel
      channel = IOWebSocketChannel(ws);

      channel.sink.add('PASS oauth:' + token);
      channel.sink.add('NICK ' + nick);

      //channel.sink.add('JOIN ');

      channel.stream.listen((message) {
        debugPrint(message);
      });
    });

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.close(status.goingAway);
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }
}
