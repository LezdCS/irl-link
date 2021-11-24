import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/tabbar/tab_element.dart';
import 'package:irllink/src/domain/entities/tabbar/web_page.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
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

  late TabController tabController;
  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  RxList<TabElement> tabElements = <TabElement>[].obs;

  late IOWebSocketChannel channel;
  late TwitchCredentials twitchData;
  late StreamController<dynamic> streamController;
  late RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    streamController = new StreamController.broadcast();
    scrollController = new ScrollController();

    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    WebPage page1 = new WebPage("Youtube", "https://www.youtube.com", true);
    TabElement twitchPage = new TabElement("Twitch");
    TabElement obsPage = new TabElement("OBS");

    tabElements.add(page1);
    tabElements.add(twitchPage);
    tabElements.add(obsPage);

    tabController = new TabController(length: tabElements.length, vsync: this);

    channel = IOWebSocketChannel.connect("wss://irc-ws.chat.twitch.tv:443");

    streamController.addStream(channel.stream);

    twitchData = Get.arguments[0];
    super.onInit();
  }

  @override
  void onReady() {
    var token = twitchData.accessToken;
    var nick = twitchData.decodedIdToken.preferredUsername;
    // WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
    //channel = IOWebSocketChannel.connect(ws);
    // create the stream channel

    channel.sink.add('PASS oauth:' + token);
    channel.sink.add('NICK ' + nick);
    channel.sink.add('CAP REQ :twitch.tv/tags');

    channel.sink.add('JOIN #lezd_');
    //channel.sink.add('PRIVMSG #lezd_ okay');

    streamController.stream.listen((message) {
      debugPrint(message);
      if (message == "PING :tmi.twitch.tv") {
        channel.sink.add("PONG :tmi.twitch.tv\r\n");
        debugPrint("Pong sent");
      }
      if (message.toString().startsWith('@')) {
        var messageSplited = message.toString().split(';');
        var badges = messageSplited[1].split('=')[1];
        var color = messageSplited[3].split('=')[1];
        var displayName = messageSplited[4].split('=')[1];
        var emotes = messageSplited[5].split('=')[1];
        var messageId = messageSplited[8].split('=')[1];
        var timestamp = int.parse(messageSplited[12].split('=')[1]);
        var userId = messageSplited[14].split('=')[1];
        var messageList = messageSplited[15].split(':').sublist(2);
        var messageString = messageList.join(':');

        TwitchChatMessage chatMessage = new TwitchChatMessage(
          badges: badges,
          color: color,
          authorName: displayName,
          authorId: userId,
          emotes: emotes,
          messageId: messageId,
          timestamp: timestamp,
          deleted: false,
          thirdPartiesEmotes: '',
          message: messageString,
        );
        chatMessages.add(chatMessage);

        Timer(Duration(milliseconds: 100), () {
          //we need a timer or it wont scroll to the real bottom of the ListView
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        });
      }
    });
    // });

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.add('PART #lezd_');
    channel.sink.close(status.goingAway);
    super.onClose();
  }
}
