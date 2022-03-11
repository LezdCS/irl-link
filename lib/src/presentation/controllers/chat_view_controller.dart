import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
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

  late String ircChannelJoined;
  late String ircChannelJoinedChannelId;

  Rxn<TwitchChatMessage> selectedMessage = Rxn<TwitchChatMessage>();
  late TextEditingController banDurationInputController;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  @override
  void onInit() async {
    scrollController = ScrollController();
    banDurationInputController = TextEditingController();

    twitchData = Get.arguments[0];
    ircChannelJoined = twitchData.twitchUser.login;
    ircChannelJoinedChannelId = twitchData.twitchUser.id;

    await getSettings();

    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (streamSubscription != null) {
        streamSubscription!.cancel();
        channel.sink.add('PART #$ircChannelJoined');
      }
      switch (result) {
        case ConnectivityResult.wifi:
          joinIrc();
          break;
        case ConnectivityResult.mobile:
          joinIrc();
          break;
        case ConnectivityResult.none:
          alertMessage.value = "Network connectivity lost";
          isChatConnected.value = false;
          break;
        case ConnectivityResult.ethernet:
          break;
        case ConnectivityResult.bluetooth:
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

  /// Join the Twitch IRC
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

  /// Receive all the Twitch Websocket data
  void chatListener(String message) {
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
        "NOTICE",
        "ROOMSTATE"
      ];
      String? keyResult =
          keys.firstWhereOrNull((key) => messageSplited.last.contains(key));

      final Map<String, String> messageMapped = {};
      messageSplited.forEach((element) {
        List elementSplited = element.split('=');
        messageMapped[elementSplited[0]] = elementSplited[1];
      });

      if (keyResult != null) {
        switch (keyResult) {
          case "PRIVMSG":
            {
              TwitchChatMessage chatMessage = TwitchChatMessage.fromString(
                twitchBadges: twitchBadges,
                thirdPartEmotes: thirdPartEmotes,
                cheerEmotes: cheerEmotes,
                message: message,
                settings: settings.value,
              );
              if (!settings.value.hiddenUsersIds!
                  .contains(chatMessage.authorId)) {
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
          case 'ROOMSTATE':
            List<String> keys = ["@followers-only", "@emote-only"];

            String? keyResult =
                keys.firstWhereOrNull((key) => messageMapped.containsKey(key));

            if (keyResult != null) {
              switch (keyResult) {
                case '@followers-only':
                  if (messageMapped['@followers-only'] == "0") {
                    debugPrint("FOLLOWER ONLY ON");
                  } else {
                    debugPrint("FOLLOWER ONLY OFF");
                  }
                  break;
                case '@emote-only':
                  if (messageMapped['@emote-only'] == "1") {
                    debugPrint("EMOTE ONLY ON");
                  } else {
                    debugPrint("EMOTE ONLY OFF");
                  }
                  break;
              }
            }
            break;
          case "CLEARCHAT":
            {
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

  /// Returns a List of Twitch official emotes
  Future<List<Emote>> getTwitchEmotes() async {
    twitchEmotes.clear();
    List<Emote> emotes = [];

    homeEvents.getTwitchEmotes(twitchData.accessToken).then(
          (value) => {
            if (value.error == null)
              {
                emotes.addAll(value.data!),
              }
          },
        );

    homeEvents
        .getTwitchChannelEmotes(
          twitchData.accessToken,
          twitchData.twitchUser.id,
        )
        .then(
          (value) => {
            if (value.error == null) {emotes.addAll(value.data!)}
          },
        );

    homeEvents
        .getTwitchCheerEmotes(
          twitchData.accessToken,
          ircChannelJoinedChannelId,
        )
        .then(
          (value) => {
            if (value.error == null) {emotes.addAll(value.data!)}
          },
        );

    return emotes;
  }

  /// Returns a List of third parties emotes (FFZ, BTTV, 7TV)
  Future<List<Emote>> getThirdPartEmotes() async {
    thirdPartEmotes.clear();
    List<Emote> emotes = [];

    homeEvents.getBttvGlobalEmotes().then((value) => {
          if (value.error == null) {emotes.addAll(value.data!)}
        });

    homeEvents
        .getBttvChannelEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    homeEvents
        .getFrankerfacezEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    homeEvents
        .get7TvChannelEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    return emotes;
  }

  /// Returns a List of Twitch official badges
  Future<List<TwitchBadge>> getTwitchBadges() async {
    twitchBadges.clear();
    List<TwitchBadge> badges = [];

    homeEvents
        .getTwitchGlobalBadges(accessToken: twitchData.accessToken)
        .then((value) => {
              if (value.error == null) {badges.addAll(value.data!)}
            });

    homeEvents
        .getTwitchChannelBadges(
          accessToken: twitchData.accessToken,
          broadcasterId: ircChannelJoinedChannelId,
        )
        .then(
          (value) => {
            addChannelBadges(badges, value).then(
              (value) => badges.addAll(value),
            ),
          },
        );

    return badges;
  }

  /// Replace Twitch default [badges] with Channel badges
  Future<List<TwitchBadge>> addChannelBadges(
      List<TwitchBadge> badges, value) async {
    value.data!.forEach((badge) {
      if (badges.firstWhereOrNull((badgeFromList) =>
              badge.setId == badgeFromList.setId &&
              badge.versionId == badgeFromList.versionId) !=
          null) {
        badges.remove(badges.firstWhere((badgeFromList) =>
            badge.setId == badgeFromList.setId &&
            badge.versionId == badgeFromList.versionId));
      }
      badges.addAll(value.data!);
    });

    return badges;
  }

  /// Delete [message] by his id
  void deleteMessageInstruction(TwitchChatMessage message) {
    channel.sink
        .add('PRIVMSG #$ircChannelJoined :/delete ${message.messageId}\r\n');
    selectedMessage.value = null;
  }

  /// Ban user for specific [duration] based on the author name in the [message]
  void timeoutMessageInstruction(TwitchChatMessage message, int duration) {
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/timeout ${message.authorName} $duration reason\r\n');

    Get.back();
    selectedMessage.value = null;
  }

  /// Ban user based on the author name in the [message]
  void banMessageInstruction(TwitchChatMessage message) {
    channel.sink.add(
        'PRIVMSG #$ircChannelJoined :/ban ${message.authorName} reason\r\n');
    selectedMessage.value = null;
  }

  /// Hide every future messages from an user (only on this application, not on Twitch)
  void hideUser(TwitchChatMessage message) {
    List hiddenUsersIds = settings.value.hiddenUsersIds! != const []
        ? settings.value.hiddenUsersIds!
        : [];
    if (hiddenUsersIds
            .firstWhereOrNull((userId) => userId == message.authorId) ==
        null) {
      //add user
      hiddenUsersIds.add(message.authorId);
      settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
      saveSettings();
    } else {
      //remove user
      hiddenUsersIds.remove(message.authorId);
      settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
      saveSettings();
    }
    selectedMessage.refresh();
  }

  /// Scroll to bottom of the chat
  void scrollToBottom() {
    isAutoScrolldown.value = true;
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }

  void saveSettings() {
    homeEvents.setSettings(settings: settings.value);
  }

  Future getSettings() async {
    await homeEvents.getSettings().then((value) async => {
          if (value.error == null)
            {
              settings.value = value.data!,
              this.applySettings(),
            },
        });
  }

  Future applySettings() async {
    if (settings.value.alternateChannel!) {
      ircChannelJoined = settings.value.alternateChannelName!;
      await homeEvents
          .getTwitchUser(
            username: ircChannelJoined,
            accessToken: twitchData.accessToken,
          )
          .then((value) => ircChannelJoinedChannelId = value.data!.id);
    } else {
      ircChannelJoined = twitchData.twitchUser.login;
      ircChannelJoinedChannelId = twitchData.twitchUser.id;
    }

    if (streamSubscription != null) {
      streamSubscription!.cancel();
      channel.sink.add('PART #$ircChannelJoined');
      chatMessages.clear();
    }

    joinIrc();
    twitchBadges = await getTwitchBadges();
    twitchEmotes = await getTwitchEmotes();
    thirdPartEmotes = await getThirdPartEmotes();
  }
}
