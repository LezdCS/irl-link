import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch_user.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatViewController extends FullLifeCycleController
    with GetSingleTickerProviderStateMixin, FullLifeCycleMixin {
  ChatViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;
  RxBool isChatConnected = false.obs;
  RxString alertMessage = "Connecting...".obs;
  late IOWebSocketChannel channel;
  late TwitchCredentials twitchData;
  StreamSubscription? streamSubscription;
  RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;

  List<TwitchBadge> twitchBadges = <TwitchBadge>[];
  List<Emote> twitchEmotes = <Emote>[];
  List<Emote> cheerEmotes = <Emote>[];

  late TwitchUser otherUserInfosChatConnected;
  late String ircChannelJoined;

  Rxn<TwitchChatMessage> selectedMessage = Rxn<TwitchChatMessage>();
  late TextEditingController banDurationInputController;

  // Mandatory
  @override
  void onDetached() {
    print('HomeController - onDetached called');
  }

  // Mandatory
  @override
  void onInactive() {
    print('HomeController - onInative called');
  }

  // Mandatory
  @override
  void onPaused() {
    print('HomeController - onPaused called');
  }

  // Mandatory
  @override
  void onResumed() {
    print('HomeController - onResumed called');
  }

  @override
  void onInit() {
    scrollController = new ScrollController();
    banDurationInputController = new TextEditingController();

    twitchData = Get.arguments[0];
    ircChannelJoined = twitchData.twitchUser.login;

    ircChannelJoined = "xqcow"
        .toLowerCase(); //if you want to join another twitch chat than yours

    getTwitchBadges();
    getTwitchEmotes();

    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);

    joinIrc();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (streamSubscription != null) {
        streamSubscription!.cancel();
        channel.sink.add('PART #$ircChannelJoined');
      }
      switch (result) {
        case ConnectivityResult.wifi:
          joinIrc();
          break;
        case ConnectivityResult.ethernet:
          //
          break;
        case ConnectivityResult.mobile:
          joinIrc();
          break;
        case ConnectivityResult.none:
          alertMessage.value = "Network connectivity lost";
          isChatConnected.value = false;
          debugPrint("none");
          break;
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    channel.sink.add('PART #$ircChannelJoined');
    channel.sink.close(status.goingAway);
    super.onClose();
  }

  Future<void> joinIrc() async {
    alertMessage.value = "Connecting...";
    isChatConnected.value = false;
    String token = twitchData.accessToken;
    String nick = twitchData.twitchUser.login;

    channel = IOWebSocketChannel.connect("wss://irc-ws.chat.twitch.tv:443");

    streamSubscription =
        channel.stream.listen((message) => chatListener(message));

    channel.sink.add('CAP REQ :twitch.tv/membership');
    channel.sink.add('CAP REQ :twitch.tv/tags');
    channel.sink.add('CAP REQ :twitch.tv/commands');
    channel.sink.add('PASS oauth:' + token);
    channel.sink.add('NICK ' + nick);

    channel.sink.add('JOIN #$ircChannelJoined');

    alertMessage.value = "Connected";
    isChatConnected.value = true;
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
              TwitchChatMessage chatMessage = TwitchChatMessage.fromString(
                  twitchBadges, cheerEmotes, message);
              chatMessages.add(chatMessage);
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
              // @login=lezd_;room-id=;target-msg-id=5ecb6458-198c-498c-b91b-16f1e12f58b4;tmi-sent-ts=1640717427981
              // :tmi.twitch.tv CLEARMSG #lezd_ :okokok
              final Map<String, String> messageMapped = {};

              List messageSplited = message.split(';');
              messageSplited.forEach((element) {
                List elementSplited = element.split('=');
                messageMapped[elementSplited[0]] = elementSplited[1];
              });

              chatMessages
                  .firstWhereOrNull((message) =>
                      message.messageId == messageMapped['target-msg-id'])!
                  .isDeleted = true;

              chatMessages.refresh();
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
    String nick = twitchData.twitchUser.login;

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

    if (ircChannelJoined != nick) {
      homeEvents
          .getTwitchUser(
            username: ircChannelJoined,
            accessToken: twitchData.accessToken,
          )
          .then(
            (value) => homeEvents
                .getTwitchCheerEmotes(
                  twitchData.accessToken,
                  value.data!.id,
                )
                .then((value) => cheerEmotes.addAll(value.data!)),
          );
    } else {
      homeEvents
          .getTwitchCheerEmotes(
            twitchData.accessToken,
            twitchData.twitchUser.id,
          )
          .then((value) => cheerEmotes.addAll(value.data!));
    }
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

    selectedMessage.value = null;
  }

  void timeoutMessageInstruction(TwitchChatMessage message, int duration) {
    // /timeout [username] [duration] [reason]
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/timeout ${message.authorName} $duration reason\r\n');

    Get.back();

    selectedMessage.value = null;
  }

  void banMessageInstruction(TwitchChatMessage message) {
    // /ban [username] [reason]
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/ban ${message.authorName} reason\r\n');

    selectedMessage.value = null;
  }

  void scrollToBottom() {
    isAutoScrolldown.value = true;
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }
}
