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
  RxBool isAutoScrolldown = true.obs;
  RxBool isChatConnected = false.obs;
  late IOWebSocketChannel channel;
  late TwitchCredentials twitchData;
  late StreamController<dynamic> streamController;
  RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;

  List<TwitchBadge> twitchBadges = <TwitchBadge>[];
  List<Emote> twitchEmotes = <Emote>[];

  late TwitchUser otherUserInfosChatConnected;
  late String ircChannelJoined;

  Rxn<TwitchChatMessage> selectedMessage = Rxn<TwitchChatMessage>();

  @override
  void onInit() {
    streamController = new StreamController.broadcast();
    scrollController = new ScrollController();

    channel = IOWebSocketChannel.connect("wss://irc-ws.chat.twitch.tv:443");
    streamController.addStream(channel.stream);

    twitchData = Get.arguments[0];
    ircChannelJoined = twitchData.twitchUser.login;

    //ircChannelJoined =
    //    "kamet0"; //if you want to join another twitch chat than yours

    getTwitchBadges();
    getTwitchEmotes();

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

    channel.sink.add('JOIN #$ircChannelJoined');

    isChatConnected.value = true;

    streamController.stream.listen((message) => chatListener(message));

    scrollController.addListener(scrollListener);

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.add('PART #$ircChannelJoined');
    channel.sink.close(status.goingAway);
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isAutoScrolldown.value = true;
    } else {
      isAutoScrolldown.value = false;
    }
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
      List<String> keys = [
        "PRIVMSG",
        "CLEARCHAT",
        "CLEARCHAT",
        "CLEARMSG",
        "NOTICE"
      ];
      String? keyResult =
          keys.firstWhereOrNull((key) => messageSplited.last.contains(key));
      if (keyResult != null) {
        switch (keyResult) {
          case "PRIVMSG":
            {
              TwitchChatMessage chatMessage =
                  TwitchChatMessage.fromString(twitchBadges, message);
              chatMessages.add(chatMessage);
              if (chatMessages.length > 100) {
                chatMessages.removeAt(0);
              }
              if (scrollController.hasClients && isAutoScrolldown.value) {
                Timer(Duration(milliseconds: 100), () {
                  //we need a timer or it wont scroll to the real bottom of the ListView
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                });
              }
            }
            break;
          case "CLEARCHAT":
            {
              //check if they is a nickname at the end, if yes -> delete messages from this user
              //else -> clear all chat
            }
            break;
          case "CLEARMSG":
            {
              //clear a specific msg by the id
            }
            break;
          case "NOTICE":
            {
              //some error and success messages are send by notice like when you don't have perm for an action or when a ban is successfull
              //https://dev.twitch.tv/docs/irc/msg-id
            }
            break;
          default:
            {}
            break;
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
    String nick = twitchData.twitchUser.login;

    twitchBadges.clear();

    homeEvents
        .getTwitchGlobalBadges(accessToken: twitchData.accessToken)
        .then((value) => twitchBadges.addAll(value.data!));

    if (ircChannelJoined != nick) {
      homeEvents
          .getTwitchUser(
            username: ircChannelJoined,
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

  void deleteMessageInstruction(TwitchChatMessage message) {
    channel.sink
        .add('PRIVMSG #$ircChannelJoined :/delete ${message.messageId}\r\n');
  }

  void timeoutMessageInstruction(TwitchChatMessage message) {
    // /timeout [username] [duration] [reason]
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/timeout ${message.authorName} 10 reason\r\n');
  }

  void banMessageInstruction(TwitchChatMessage message) {
    // /ban [username] [reason]
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/ban ${message.authorName} reason\r\n');
  }

  void scrollToBottom() {
    isAutoScrolldown.value = true;
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }
}
