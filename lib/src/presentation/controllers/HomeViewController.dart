import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/Model/WebPage.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeViewController extends GetxController
    with SingleGetTickerProviderMixin {
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
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    channel = IOWebSocketChannel.connect(
      Uri.parse('wss://irc-ws.chat.twitch.tv:443'),
    );

    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }
}
