import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/tabbar/tab_element.dart';
import 'package:irllink/src/domain/entities/tabbar/web_page.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
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

  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  //TABS
  late TabController tabController;
  RxList<TabElement> tabElements = <TabElement>[].obs;

  //CHAT
  late IOWebSocketChannel channel;
  late TwitchCredentials twitchData;
  late StreamController<dynamic> streamController;
  RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;
  late ScrollController scrollController;
  late TextEditingController chatInputController;
  List<TwitchBadge> twitchBadges = <TwitchBadge>[];
  List<Emote> twitchEmotes = <Emote>[];

  @override
  void onInit() {
    streamController = new StreamController.broadcast();
    scrollController = new ScrollController();
    chatInputController = new TextEditingController();

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
    homeEvents
        .getTwitchBadges(twitchData.accessToken, twitchData.twitchUser.id)
        .then((value) => twitchBadges = value.data!);

    homeEvents
        .getTwitchEmotes(twitchData.accessToken)
        .then((value) => twitchEmotes = value.data!);

    super.onInit();
  }

  @override
  void onReady() {
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;

    channel.sink.add('PASS oauth:' + token);
    channel.sink.add('NICK ' + nick);
    channel.sink.add('CAP REQ :twitch.tv/tags');

    channel.sink.add('JOIN #$nick');
    //use the one under for testing, lot of messages so you will see if something break the code
    // channel.sink.add('JOIN #xqcow');

    streamController.stream.listen((message) {
      debugPrint(message);
      if (message.startsWith('PING ')) {
        channel.sink.add("PONG :tmi.twitch.tv\r\n");
      }

      if (message.startsWith('@')) {
        List messageSplited = message.split(';');
        if (messageSplited.last.contains('PRIVMSG')) {
          TwitchChatMessage chatMessage =
              TwitchChatMessage.fromString(twitchBadges, message);
          chatMessages.add(chatMessage);
          if (chatMessages.length > 100) {
            chatMessages.removeAt(0);
          }

          Timer(Duration(milliseconds: 100), () {
            //we need a timer or it wont scroll to the real bottom of the ListView
            scrollController.jumpTo(
              scrollController.position.maxScrollExtent,
            );
          });
        }
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.add('PART #lezd_');
    channel.sink.close(status.goingAway);
    super.onClose();
  }

  void sendChatMessage(String message) {
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;
    WebSocket.connect("wss://irc-ws.chat.twitch.tv:443").then((ws) {
      IOWebSocketChannel channel = IOWebSocketChannel(ws);

      channel.sink.add('PASS oauth:' + token);
      channel.sink.add('NICK ' + nick);
      channel.sink.add('JOIN #$nick');
      channel.sink.add('PRIVMSG #$nick :$message\r\n');
      channel.sink.close(status.goingAway);
    });
  }
}
