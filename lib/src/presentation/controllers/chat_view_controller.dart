import 'dart:async';
import 'dart:io';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatViewController extends GetxController
    with SingleGetTickerProviderMixin {
  ChatViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  //CHAT
  late ScrollController scrollController;
  late TextEditingController chatInputController;
  bool isAutoScrolldown = true;
  RxBool isChatConnected = false.obs;
  late IOWebSocketChannel channel;
  late TwitchCredentials twitchData;
  late StreamController<dynamic> streamController;
  RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;

  List<TwitchBadge> twitchBadges = <TwitchBadge>[];
  List<Emote> twitchEmotes = <Emote>[];

  late TwitchUser otherUserInfosChatConnected;
  String? otherUserNicknameChatConnected = "xqcow";

  @override
  void onInit() {
    streamController = new StreamController.broadcast();
    scrollController = new ScrollController();

    channel = IOWebSocketChannel.connect("wss://irc-ws.chat.twitch.tv:443");
    streamController.addStream(channel.stream);

    twitchData = Get.arguments[0];

    getTwitchBadges();
    getTwitchEmotes();

    _scrollListener() {
      if (scrollController.offset <=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange &&
          isAutoScrolldown) {
        isAutoScrolldown = false;
      }
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange &&
          !isAutoScrolldown) {
        isAutoScrolldown = true;
      }
    }

    scrollController.addListener(_scrollListener);

    super.onInit();
  }

  @override
  void onReady() {
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;

    isChatConnected.value = false;

    channel.sink.add('CAP REQ :twitch.tv/membership');
    channel.sink.add('CAP REQ :twitch.tv/tags');
    channel.sink.add('CAP REQ :twitch.tv/commands');
    channel.sink.add('PASS oauth:' + token);
    channel.sink.add('NICK ' + nick);

    if (otherUserNicknameChatConnected != null) {
      channel.sink.add('JOIN #$otherUserNicknameChatConnected');
    } else {
      channel.sink.add('JOIN #$nick');
    }

    isChatConnected.value = true;

    streamController.stream.listen((message) => chatListener(message));

    super.onReady();
  }

  @override
  void onClose() {
    String nick = twitchData.twitchUser.login;
    if (otherUserNicknameChatConnected != null) {
      channel.sink.add('PART #$otherUserNicknameChatConnected');
    } else {
      channel.sink.add('PART #$nick');
    }
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
      channel.sink.add('PART #lezd_');
      channel.sink.close(status.goingAway);
      ws.close();
    });
  }

  void chatListener(message) {
    if (streamController.isClosed) {
      return;
    }
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
        if (scrollController.hasClients && isAutoScrolldown) {
          Timer(Duration(milliseconds: 100), () {
            //we need a timer or it wont scroll to the real bottom of the ListView
            scrollController.jumpTo(
              scrollController.position.maxScrollExtent,
            );
          });
        }
      }
    } else if (message.toString().contains("GLOBALUSERSTATE")) {
      final Map<String, String> messageMapped = {};
      List messageSplited = message.split(';');
      messageSplited.forEach((element) {
        List elementSplited = element.split('=');
        messageMapped[elementSplited[0]] = elementSplited[1];
      });
      List<String> emoteSetsIds = messageMapped["emote-sets"]!.split(',');
      homeEvents
          .getTwitchSetsEmotes(twitchData.accessToken, emoteSetsIds)
          .then((value) {
        for (var emote in value.data!) {
          if (twitchEmotes
                  .firstWhereOrNull((element) => element.id == emote.id) ==
              null) {
            twitchEmotes.add(emote);
          }
        }
      });
    }
  }

  void getTwitchEmotes() {
    twitchEmotes.clear();

    homeEvents
        .getTwitchEmotes(twitchData.accessToken)
        .then((value) => twitchEmotes.addAll(value.data!));

    homeEvents
        .getTwitchChannelEmotes(
          twitchData.accessToken,
          twitchData.twitchUser.id,
        )
        .then((value) => twitchEmotes.addAll(value.data!));
  }

  void getTwitchBadges() {
    twitchBadges.clear();

    homeEvents
        .getTwitchGlobalBadges(accessToken: twitchData.accessToken)
        .then((value) => twitchBadges.addAll(value.data!));

    if (otherUserNicknameChatConnected != null) {
      homeEvents
          .getTwitchUser(
            username: otherUserNicknameChatConnected,
            accessToken: twitchData.accessToken,
          )
          .then(
            (value) => homeEvents
                .getTwitchChannelBadges(
                  accessToken: twitchData.accessToken,
                  broadcasterId: value.data!.id,
                )
                .then((value) => addChannelBadges(value)),
          );
    } else {
      homeEvents
          .getTwitchChannelBadges(
            accessToken: twitchData.accessToken,
            broadcasterId: twitchData.twitchUser.id,
          )
          .then((value) => addChannelBadges(value));
    }
  }

  void addChannelBadges(value) {
    value.data!.forEach((badge) {
      if (twitchBadges.firstWhereOrNull((badgeFromList) =>
              badge.setId == badgeFromList.setId &&
              badge.versionId == badgeFromList.versionId) !=
          null) {
        twitchBadges.remove(twitchBadges.firstWhere((badgeFromList) =>
            badge.setId == badgeFromList.setId &&
            badge.versionId == badgeFromList.versionId));
      }
      twitchBadges.addAll(value.data!);
    });
  }
}
