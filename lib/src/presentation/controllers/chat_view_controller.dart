import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/emote.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/twitch_badge.dart';
import 'package:irllink/src/domain/entities/twitch_chat_message.dart';
import 'package:irllink/src/domain/entities/twitch_credentials.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:web_socket_channel/io.dart';

class ChatViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ChatViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;
  RxBool isChatConnected = false.obs;
  RxBool isAlertProgress = true.obs;
  Rx<Color> alertColor = Color(0xFFEC7508).obs;

  RxString alertMessage = "Connecting...".obs;
  IOWebSocketChannel? channel;
  TwitchCredentials? twitchData;
  StreamSubscription? streamSubscription;
  RxList<TwitchChatMessage> chatMessages = <TwitchChatMessage>[].obs;

  List<TwitchBadge> twitchBadges = <TwitchBadge>[];
  List<Emote> twitchEmotes = <Emote>[];
  List<Emote> thirdPartEmotes = <Emote>[];
  List<Emote> cheerEmotes = <Emote>[];

  String ircChannelJoined = '';
  String ircChannelJoinedChannelId = '';

  Rxn<TwitchChatMessage> selectedMessage = Rxn<TwitchChatMessage>();
  late TextEditingController banDurationInputController;

  late Rx<Settings> settings = Settings.defaultSettings().obs;
  Timer? chatDemoTimer;

  late FlutterTts flutterTts;

  @override
  void onInit() async {
    flutterTts = FlutterTts();
    flutterTts.setEngine(flutterTts.getDefaultEngine.toString());

    scrollController = ScrollController();
    banDurationInputController = TextEditingController();
    if (Get.arguments != null) {
      twitchData = Get.arguments[0];
      await getSettings();
    } else {
      chatDemoTimer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => {
          chatMessages.add(TwitchChatMessage.randomGeneration()),
          if (scrollController.hasClients && isAutoScrolldown.value)
            {
              Timer(Duration(milliseconds: 100), () {
                if (isAutoScrolldown.value) {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                }
              }),
            }
        },
      );
      alertMessage.value = "DEMO";
      alertColor.value = Color(0xFF196DEE);
      isChatConnected.value = false;
      isAlertProgress.value = false;
    }
    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);
    if (twitchData != null) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
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
            alertColor.value = Color(0xFFEC7508);
            isAlertProgress.value = true;
            break;
          case ConnectivityResult.ethernet:
            break;
          case ConnectivityResult.bluetooth:
            break;
          case ConnectivityResult.vpn:
            // TODO: Handle this case.
            break;
          case ConnectivityResult.other:
            joinIrc();
            break;
        }
      });
    }

    super.onReady();
  }

  @override
  void onClose() {
    chatDemoTimer?.cancel();
    streamSubscription?.cancel();
    channel?.sink.close();
    super.onClose();
  }

  /// Join the Twitch IRC
  Future<void> joinIrc() async {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
      channel!.sink.close();
      chatMessages.clear();
    }
    alertMessage.value = "Connecting...";
    isChatConnected.value = false;
    alertColor.value = Color(0xFFEC7508);
    isAlertProgress.value = true;

    String token = twitchData!.accessToken;
    String nick = twitchData!.twitchUser.login;

    channel = IOWebSocketChannel.connect("wss://irc-ws.chat.twitch.tv:443");

    streamSubscription = channel!.stream.listen(
        (message) => chatListener(message),
        onDone: ircChatClosed,
        onError: ircChatError);

    channel!.sink.add('CAP REQ :twitch.tv/membership');
    channel!.sink.add('CAP REQ :twitch.tv/tags');
    channel!.sink.add('CAP REQ :twitch.tv/commands');
    channel!.sink.add('PASS oauth:' + token);
    channel!.sink.add('NICK ' + nick);

    channel!.sink.add('JOIN #$ircChannelJoined');
  }

  void ircChatClosed() {
    debugPrint("IRC Chat CLOSED");
    joinIrc();
  }

  void ircChatError(Object o, StackTrace s) {
    debugPrint("IRC Chat ERROR");
  }

  void scrollListener() {
    // if user scroll up -> disable auto scrolldown
    if (isAutoScrolldown.value &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      isAutoScrolldown.value = false;
    }

    double maxPosition = scrollController.position.maxScrollExtent;
    double currentPosition = scrollController.position.pixels;
    double difference = 10.0;

    /// bottom position
    if (!isAutoScrolldown.value &&
        maxPosition - currentPosition <= difference) {
      isAutoScrolldown.value = true;
    }
  }

  /// Receive all the Twitch Websocket data
  void chatListener(String message) {
    //debugPrint(message);
    if (message.startsWith('PING ')) {
      channel!.sink.add("PONG :tmi.twitch.tv\r\n");
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
                if(settings.value.ttsEnabled!){
                  readTts(chatMessage);
                }

                if (scrollController.hasClients && isAutoScrolldown.value) {
                  Timer(Duration(milliseconds: 100), () {
                    if (isAutoScrolldown.value) {
                      scrollController.jumpTo(
                        scrollController.position.maxScrollExtent,
                      );
                    }
                  });
                }
              }
            }
            break;
          case 'ROOMSTATE':
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
      alertColor.value = Color(0xFF33A031);
      isAlertProgress.value = false;

      final Map<String, String> messageMapped = {};
      List messageSplited = message.split(';');
      messageSplited.forEach((element) {
        List elementSplited = element.split('=');
        messageMapped[elementSplited[0]] = elementSplited[1];
      });
      List<String> emoteSetsIds = messageMapped["emote-sets"]!.split(',');
      homeEvents
          .getTwitchSetsEmotes(twitchData!.accessToken, emoteSetsIds)
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
    List<Emote> emotes = [];

    await homeEvents.getTwitchEmotes(twitchData!.accessToken).then(
          (value) => {
            if (value.error == null)
              {
                emotes.addAll(value.data!),
              }
          },
        );

    await homeEvents
        .getTwitchChannelEmotes(
          twitchData!.accessToken,
          twitchData!.twitchUser.id,
        )
        .then(
          (value) => {
            if (value.error == null) {emotes.addAll(value.data!)}
          },
        );

    return emotes;
  }

  /// Returns a List of Twitch official emotes
  Future<List<Emote>> getTwitchCheerEmotes() async {
    List<Emote> emotes = [];

    await homeEvents
        .getTwitchCheerEmotes(
          twitchData!.accessToken,
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
    List<Emote> emotes = [];

    await homeEvents.getBttvGlobalEmotes().then((value) => {
          if (value.error == null) {emotes.addAll(value.data!)}
        });

    await homeEvents
        .getBttvChannelEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    await homeEvents
        .getFrankerfacezEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    await homeEvents
        .get7TvChannelEmotes(broadcasterId: ircChannelJoinedChannelId)
        .then((value) => {
              if (value.error == null) {emotes.addAll(value.data!)}
            });

    await homeEvents.get7TvGlobalEmotes().then((value) => {
          if (value.error == null) {emotes.addAll(value.data!)}
        });

    return emotes;
  }

  /// Returns a List of Twitch official badges
  Future<List<TwitchBadge>> getTwitchBadges() async {
    List<TwitchBadge> badges = [];

    await homeEvents
        .getTwitchGlobalBadges(accessToken: twitchData!.accessToken)
        .then((value) => {
              if (value.error == null) {badges.addAll(value.data!)}
            });

    await homeEvents
        .getTwitchChannelBadges(
          accessToken: twitchData!.accessToken,
          broadcasterId: ircChannelJoinedChannelId,
        )
        .then(
          (channelBadges) => {addChannelBadges(badges, channelBadges)},
        );

    return badges;
  }

  /// Replace Twitch default [badges] with Channel badges
  Future<List<TwitchBadge>> addChannelBadges(
      List<TwitchBadge> badges, channelBadges) async {
    channelBadges.data!.forEach((badge) {
      if (badges.firstWhereOrNull((badgeFromList) =>
              badge.setId == badgeFromList.setId &&
              badge.versionId == badgeFromList.versionId) !=
          null) {
        badges.remove(badges.firstWhere((badgeFromList) =>
            badge.setId == badgeFromList.setId &&
            badge.versionId == badgeFromList.versionId));
      }
      badges.addAll(channelBadges.data!);
    });

    return badges;
  }

  /// Delete [message] by his id
  void deleteMessageInstruction(TwitchChatMessage message) {
    channel?.sink
        .add('PRIVMSG #$ircChannelJoined :/delete ${message.messageId}\r\n');
    selectedMessage.value = null;

    if (twitchData == null) message.isDeleted = true;
  }

  /// Ban user for specific [duration] based on the author name in the [message]
  void timeoutMessageInstruction(TwitchChatMessage message, int duration) {
    channel?.sink.add(
        'PRIVMSG #$ircChannelJoined :/timeout ${message.authorName} $duration reason\r\n');

    Get.back();
    selectedMessage.value = null;
  }

  /// Ban user based on the author name in the [message]
  void banMessageInstruction(TwitchChatMessage message) {
    channel?.sink.add(
        'PRIVMSG #$ircChannelJoined :/ban ${message.authorName} reason\r\n');
    selectedMessage.value = null;
  }

  /// Hide every future messages from an user (only on this application, not on Twitch)
  void hideUser(TwitchChatMessage message) {
    if (twitchData == null) return;

    List hiddenUsersIds = settings.value.hiddenUsersIds! != const []
        ? settings.value.hiddenUsersIds!
        : [];
    if (hiddenUsersIds
            .firstWhereOrNull((userId) => userId == message.authorId) ==
        null) {
      //add user
      hiddenUsersIds.add(message.authorId);
      settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
    } else {
      //remove user
      hiddenUsersIds.remove(message.authorId);
      settings.value = settings.value.copyWith(hiddenUsersIds: hiddenUsersIds);
    }
    saveSettings();
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
            },
          await this.applySettings(),
        });
  }

  Future applySettings() async {
    String tempIrcChannelJoined = ircChannelJoined;
    if (settings.value.alternateChannel! &&
        settings.value.alternateChannelName! != '') {
      ircChannelJoined = settings.value.alternateChannelName!;
      await homeEvents
          .getTwitchUser(
            username: ircChannelJoined,
            accessToken: twitchData!.accessToken,
          )
          .then((value) => ircChannelJoinedChannelId = value.data!.id);
    } else {
      ircChannelJoined = twitchData!.twitchUser.login;
      ircChannelJoinedChannelId = twitchData!.twitchUser.id;
    }

    isAutoScrolldown.value = true;

    if (tempIrcChannelJoined != ircChannelJoined) {
      getTwitchBadges().then((value) => twitchBadges = value);
      getTwitchEmotes().then((value) => twitchEmotes = value);
      getThirdPartEmotes().then((value) => thirdPartEmotes = value);
      getTwitchCheerEmotes().then((value) => cheerEmotes = value);
      joinIrc();
    }

    initTts(settings.value);
  }

  void initTts(Settings settings) async {
    //  The following setup allows background music and in-app audio session to continue simultaneously:
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage(settings.language!);
    await flutterTts.setSpeechRate(settings.rate!);
    await flutterTts.setVolume(settings.volume!);
    await flutterTts.setPitch(settings.pitch!);
    await flutterTts.setVoice(settings.voice!);

    if (Platform.isAndroid) {
      await flutterTts.setQueueMode(1);
    }
  }

  void readTts(TwitchChatMessage message) {
    flutterTts.speak("${message.authorName} said ${message.message}");
  }
}
