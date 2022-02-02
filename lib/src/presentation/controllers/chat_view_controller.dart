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

class ChatViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
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
  List<Emote> thirdPartEmotes = <Emote>[];
  List<Emote> cheerEmotes = <Emote>[];

  late TwitchUser otherUserInfosChatConnected;
  late String ircChannelJoined;
  List<String> usersIdsHided = [];
  RxBool isDisplayingMessageTime = false.obs;

  Rxn<TwitchChatMessage> selectedMessage = Rxn<TwitchChatMessage>();
  late TextEditingController banDurationInputController;

  @override
  void onInit() {
    scrollController = new ScrollController();
    banDurationInputController = new TextEditingController();

    twitchData = Get.arguments[0];
    ircChannelJoined = twitchData.twitchUser.login;

    ircChannelJoined = "robcdee"
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
          break;
        case ConnectivityResult.mobile:
          joinIrc();
          break;
        case ConnectivityResult.none:
          alertMessage.value = "Network connectivity lost";
          isChatConnected.value = false;
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

    streamSubscription = channel.stream.listen(
        (message) => chatListener(message),
        onDone: ircChatClosed,
        onError: ircChatError);

    channel.sink.add('CAP REQ :twitch.tv/membership');
    channel.sink.add('CAP REQ :twitch.tv/tags');
    channel.sink.add('CAP REQ :twitch.tv/commands');
    channel.sink.add('PASS oauth:' + token);
    channel.sink.add('NICK ' + nick);

    channel.sink.add('JOIN #$ircChannelJoined');
  }

  void ircChatClosed() {
    debugPrint("IRC Chat CLOSED");
    joinIrc();
  }

  void ircChatError(Object o, StackTrace s) {
    debugPrint("IRC Chat ERROR");
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
    // debugPrint(message);
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
                twitchBadges: twitchBadges,
                thirdPartEmotes: thirdPartEmotes,
                cheerEmotes: cheerEmotes,
                message: message,
              );
              if (!usersIdsHided.contains(chatMessage.authorId)) {
                chatMessages.add(chatMessage);

                if (scrollController.hasClients && isAutoScrolldown.value) {
                  Timer(Duration(milliseconds: 100), () {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  });
                }
              }
            }
            break;
          case "CLEARCHAT":
            {
              final Map<String, String> messageMapped = {};

              List messageSplited = message.split(';');
              messageSplited.forEach((element) {
                List elementSplited = element.split('=');
                messageMapped[elementSplited[0]] = elementSplited[1];
              });
              if (messageMapped['target-user-id'] != null) {
                // @ban-duration=43;room-id=169185650;target-user-id=107285371;tmi-sent-ts=1642601142470 :tmi.twitch.tv CLEARCHAT #robcdee :lezd_
                String userId = messageMapped['target-user-id']!;
                chatMessages.forEach((message) {
                  if (message.authorId == userId) {
                    message.isDeleted = true;
                  }
                });

                chatMessages.refresh();
              } else {
                //@room-id=107285371;tmi-sent-ts=1642256684032 :tmi.twitch.tv CLEARCHAT #lezd_
                chatMessages.clear();
              }
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
              //error and success messages are send by notice
              //https://dev.twitch.tv/docs/irc/msg-id
            }
            break;
          default:
            {}
            break;
        }
      }
    } else if (message.toString().contains("GLOBALUSERSTATE")) {
      alertMessage.value = "Connected";
      isChatConnected.value = true;

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

  Future<void> getTwitchEmotes() async {
    String nick = twitchData.twitchUser.login;

    twitchEmotes.clear();
    thirdPartEmotes.clear();

    homeEvents.getTwitchEmotes(twitchData.accessToken).then((value) => {
          if (value.error == null) {twitchEmotes.addAll(value.data!)}
        });

    homeEvents
        .getTwitchChannelEmotes(
          twitchData.accessToken,
          twitchData.twitchUser.id,
        )
        .then((value) => {
              if (value.error == null) {twitchEmotes.addAll(value.data!)}
            });

    homeEvents.getBttvGlobalEmotes().then((value) => {
          if (value.error == null) {thirdPartEmotes.addAll(value.data!)}
        });

    if (ircChannelJoined != nick) {
      String userId = '';
      await homeEvents
          .getTwitchUser(
            username: ircChannelJoined,
            accessToken: twitchData.accessToken,
          )
          .then((value) => userId = value.data!.id);

      homeEvents
          .getTwitchCheerEmotes(
            twitchData.accessToken,
            userId,
          )
          .then((value) => {
                if (value.error == null) {cheerEmotes.addAll(value.data!)}
              });

      homeEvents.getFrankerfacezEmotes(broadcasterId: userId).then((value) => {
            if (value.error == null) {thirdPartEmotes.addAll(value.data!)}
          });

      homeEvents.getBttvChannelEmotes(broadcasterId: userId).then((value) => {
            if (value.error == null) {thirdPartEmotes.addAll(value.data!)}
          });
    } else {
      homeEvents
          .getTwitchCheerEmotes(
            twitchData.accessToken,
            twitchData.twitchUser.id,
          )
          .then((value) => {
                if (value.error == null) {cheerEmotes.addAll(value.data!)}
              });

      await homeEvents
          .getFrankerfacezEmotes(broadcasterId: twitchData.twitchUser.id)
          .then((value) => {
                if (value.error == null) {thirdPartEmotes.addAll(value.data!)}
              });

      homeEvents
          .getBttvChannelEmotes(broadcasterId: twitchData.twitchUser.id)
          .then((value) => {
                if (value.error == null) {thirdPartEmotes.addAll(value.data!)}
              });
    }
  }

  void getTwitchBadges() {
    String nick = twitchData.twitchUser.login;
    twitchBadges.clear();

    homeEvents
        .getTwitchGlobalBadges(accessToken: twitchData.accessToken)
        .then((value) => {
              if (value.error == null) {twitchBadges.addAll(value.data!)}
            });

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
    // /timeout [username] [duration in seconds] [reason]
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

  void hideUser(TwitchChatMessage message) {
    usersIdsHided.add(message.authorId);
    selectedMessage.value = null;
  }

  void scrollToBottom() {
    isAutoScrolldown.value = true;
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }
}
