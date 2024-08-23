import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/services/youtube_chat.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

import 'home_view_controller.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;

class ChatViewController extends GetxController
    with GetTickerProviderStateMixin {
  ChatViewController({
    required this.homeEvents,
    required this.chatGroup,
  });

  final HomeEvents homeEvents;
  ChatGroup chatGroup;

  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;
  RxBool isChatConnected = false.obs;
  RxBool isAlertProgress = true.obs;
  Rx<Color> alertColor = const Color(0xFFEC7508).obs;

  RxString alertMessage = "Connecting...".obs;
  TwitchCredentials? twitchData;
  RxList<entity.ChatMessage> chatMessages = <entity.ChatMessage>[].obs;
  RxList<ChatEmote> cheerEmotes = <ChatEmote>[].obs;
  RxList<ChatEmote> thirdPartEmotes = <ChatEmote>[].obs;

  late TextEditingController banDurationInputController;

  Timer? chatDemoTimer;

  late HomeViewController homeViewController;
  late TtsService ttsService;

  List<TwitchChat> twitchChats = [];
  List<KickChat> kickChats = [];
  List<YoutubeChat> youtubeChats = [];

  @override
  void onInit() async {
    homeViewController = Get.find<HomeViewController>();
    ttsService = Get.find<TtsService>();

    scrollController = ScrollController();
    banDurationInputController = TextEditingController();
    if (Get.arguments != null) {
      twitchData = Get.arguments[0];
      await applySettings();
      homeViewController.selectedChatGroup.value = chatGroup;
    } else {
      chatDemoTimer = Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) {
          // chatMessages.add(ChatMessage.randomGeneration(null, null, null));
          scrollChatToBottom();
        },
      );
      alertMessage.value = "DEMO";
      alertColor.value = const Color(0xFF196DEE);
      isChatConnected.value = false;
      isAlertProgress.value = false;
    }

    createChats();
    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);
    if (twitchData != null) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            for (TwitchChat twitchChat in twitchChats) {
              if (!twitchChat.isConnected.value) {
                twitchChat.close();
                twitchChat.connect();
              }
            }
            break;
          case ConnectivityResult.mobile:
            for (TwitchChat twitchChat in twitchChats) {
              if (!twitchChat.isConnected.value) {
                twitchChat.close();
                twitchChat.connect();
              }
            }
            break;
          case ConnectivityResult.none:
            alertMessage.value = "Network connectivity lost";
            isChatConnected.value = false;
            alertColor.value = const Color(0xFFEC7508);
            isAlertProgress.value = true;
            break;
          case ConnectivityResult.ethernet:
            break;
          case ConnectivityResult.bluetooth:
            break;
          case ConnectivityResult.vpn:
            break;
          case ConnectivityResult.other:
            for (TwitchChat twitchChat in twitchChats) {
              if (!twitchChat.isConnected.value) {
                twitchChat.close();
                twitchChat.connect();
              }
            }
            break;
        }
      });
    }

    super.onReady();
  }

  @override
  void onClose() {
    Get.find<TtsService>().flutterTts.stop();
    chatDemoTimer?.cancel();
    super.onDelete;
    super.onClose();
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

  /// Delete [message] by his id
  void deleteMessageInstruction(entity.ChatMessage message) {
    TwitchApi.deleteMessage(
      twitchData!.accessToken,
      message.channelId,
      message.id,
      kTwitchAuthClientId,
    );

    if (twitchData == null) message.isDeleted = true;
    homeViewController.selectedMessage.value = null;
  }

  /// Ban user for specific [duration] based on the author name in the [message]
  void timeoutMessageInstruction(entity.ChatMessage message, int duration) {
    TwitchApi.banUser(
      twitchData!.accessToken,
      message.channelId,
      message.authorId,
      duration,
      kTwitchAuthClientId,
    );
    Get.back();
    homeViewController.selectedMessage.value = null;
  }

  /// Ban user based on the author name in the [message]
  void banMessageInstruction(entity.ChatMessage message) {
    TwitchApi.banUser(
      twitchData!.accessToken,
      message.channelId,
      message.authorId,
      null,
      kTwitchAuthClientId,
    );
    homeViewController.selectedMessage.value = null;
  }

  /// Hide every future messages from an user (only on this application, not on Twitch)
  void hideUser(entity.ChatMessage message) {
    if (twitchData == null) return;
    Settings settings = Get.find<SettingsService>().settings.value;

    List hiddenUsersIds =
        settings.hiddenUsersIds! != const [] ? settings.hiddenUsersIds! : [];
    if (hiddenUsersIds
            .firstWhereOrNull((userId) => userId == message.authorId) ==
        null) {
      //add user
      hiddenUsersIds.add(message.authorId);
      Get.find<SettingsService>().settings.value = settings.copyWith(hiddenUsersIds: hiddenUsersIds);
    } else {
      //remove user
      hiddenUsersIds.remove(message.authorId);
      Get.find<SettingsService>().settings.value = settings.copyWith(hiddenUsersIds: hiddenUsersIds);
    }
    Get.find<SettingsService>().saveSettings();
    homeViewController.selectedMessage.refresh();
  }

  /// Scroll to bottom of the chat
  void scrollToBottom() {
    isAutoScrolldown.value = true;
    if (scrollController.hasClients) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

  Future applySettings() async {
    isAutoScrolldown.value = true;
  }

  void updateChannels(List<Channel> channels, twitchUsername) {
    // check chatGroup channels not existings in channels and remove them
    List<Channel> channelsToRemove = [];
    for (var channel in chatGroup.channels) {
      if (channel.channel == twitchUsername) {
        continue;
      }
      if (channels.firstWhereOrNull((e) => e.channel == channel.channel) ==
          null) {
        channelsToRemove.add(channel);
      }
    }
    for (var channel in channelsToRemove) {
      chatGroup.channels.removeWhere((e) => e.channel == channel.channel);
    }

    // check channels not existing in chatGroup channels and add them
    for (var channel in channels) {
      if (chatGroup.channels
              .firstWhereOrNull((e) => e.channel == channel.channel) ==
          null) {
        chatGroup.channels.add(channel);
      }
    }
  }

  void createChats() {
    List<Channel> twitchChannels =
        chatGroup.channels.where((e) => e.platform == Platform.twitch).toList();
    List<Channel> kickChannels =
        chatGroup.channels.where((e) => e.platform == Platform.kick).toList();
    List<Channel> youtubeChannels = chatGroup.channels
        .where((e) => e.platform == Platform.youtube)
        .toList();

    for (Channel tc in twitchChannels) {
      bool alreadyCreated =
          twitchChats.firstWhereOrNull((t) => t.channel == tc.channel) != null;
      if (!alreadyCreated) {
        createTwitchChat(tc);
      }
    }

    for (Channel kc in kickChannels) {
      bool alreadyCreated =
          kickChats.firstWhereOrNull((k) => k.username == kc.channel) != null;
      if (alreadyCreated) {
        return;
      }

      createKickChat(kc);
    }

    for (Channel kc in youtubeChannels) {
      bool alreadyCreated =
          kickChats.firstWhereOrNull((k) => k.username == kc.channel) != null;
      if (alreadyCreated) {
        return;
      }
      createYoutubeChat(kc.channel);
    }

    // Remove
    List<TwitchChat> twitchChatToRemove = twitchChats
        .where((tc) =>
            twitchChannels
                .firstWhereOrNull((tCa) => tCa.channel == tc.channel) ==
            null)
        .toList();
    List<KickChat> kickChatToRemove = kickChats
        .where((kc) =>
            kickChannels
                .firstWhereOrNull((kCa) => kCa.channel == kc.username) ==
            null)
        .toList();
    List<YoutubeChat> youtubeChatToRemove = youtubeChats
        .where((yc) =>
            youtubeChannels
                .firstWhereOrNull((yCa) => yCa.channel == yc.videoId) ==
            null)
        .toList();

    for (TwitchChat t in twitchChatToRemove) {
      globals.talker?.info('Removing chat: ${t.channel}');
      t.close();
      twitchChats.removeWhere((tc) => tc.channelId == t.channelId);
    }

    for (KickChat k in kickChatToRemove) {
      globals.talker?.info('Removing chat: ${k.username}');
      k.close();
      kickChats.removeWhere((kc) => kc.username == k.username);
    }

    for (YoutubeChat y in youtubeChatToRemove) {
      globals.talker?.info('Removing chat: ${y.videoId}');
      y.closeStream();
      youtubeChats.removeWhere((yc) => yc.videoId == y.videoId);
    }
  }

  void createTwitchChat(Channel tc) {
    TwitchChat twitchChat = TwitchChat(
      tc.channel,
      twitchData!.twitchUser.login,
      twitchData!.accessToken,
      clientId: kTwitchAuthClientId,
      onConnected: () {},
      onClearChat: () {
        chatMessages.clear();
      },
      onDeletedMessageByUserId: (String? userId) {
        for (var message in chatMessages) {
          if (message.authorId == userId) {
            message.isDeleted = true;
          }
        }

        for (var message in chatMessages.where(
          (message) =>
              message.authorId == userId && message.platform == Platform.twitch,
        )) {
          message.isDeleted = true;
        }
        chatMessages.refresh();
      },
      onDeletedMessageByMessageId: (String? messageId) {
        chatMessages
            .firstWhereOrNull((message) => message.id == messageId)!
            .isDeleted = true;
        chatMessages.refresh();
      },
      onDone: () {
        TwitchChat? chat =
            twitchChats.firstWhereOrNull((t) => t.channel == tc.channel);
        chat?.connect();
      },
      onError: () {},
      params: const TwitchChatParameters(addFirstMessages: true),
    );
    twitchChat.connect();
    twitchChats.add(twitchChat);
    twitchChat.isConnected.addListener(() {
      if (twitchChat.isConnected.value) {
        isChatConnected.value = true;
        isAlertProgress.value = false;
        alertMessage.value = "CONNECTED";
        alertColor.value = const Color(0xFF1DBF1D);
      }
    });

    Settings settings = Get.find<SettingsService>().settings.value;

    twitchChat.chatStream.listen((message) {
      if (cheerEmotes.isEmpty) {
        cheerEmotes.value =
            twitchChat.cheerEmotes.map((e) => ChatEmote.fromTwitch(e)).toList();
      }
      if (thirdPartEmotes.isEmpty) {
        thirdPartEmotes.value = twitchChat.thirdPartEmotes
            .map((e) => ChatEmote.fromTwitch(e))
            .toList();
      }
      if (settings.hiddenUsersIds!.contains(message.authorId)) {
        return;
      }
      if (settings.ttsSettings!.ttsEnabled) {
        ttsService.readTts(message);
      }
      entity.ChatMessage twitchMessage =
          entity.ChatMessage.fromTwitch(message, twitchChat.channelId ?? '');
      chatMessages.add(twitchMessage);
      scrollChatToBottom();
    });
  }

  Future<void> createYoutubeChat(String channelId) async {
    String? videoId = await getLiveVideoId(channelId);
    if (videoId == null) {
      globals.talker?.error('VideoID not found for the channel: $channelId');
      return;
    }

    YoutubeChat youtubeChat = YoutubeChat(
      videoId,
    );
    youtubeChat.startFetchingChat();
    youtubeChat.chatStream.listen((message) {
      chatMessages.add(message);
      scrollChatToBottom();
    });
    youtubeChats.add(youtubeChat);
    isChatConnected.value = true;
  }

  Future<void> createKickChat(Channel kc) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String pushKey = remoteConfig.getString('kick_chat_push_key');
    KickChat kickChat = KickChat(
      kc.channel,
      pushKey,
      onDone: () => {},
      onError: () => {
        globals.talker?.error('error on kick chat'),
      },
    );
    kickChats.add(kickChat);
    await kickChat.connect();
    for (var e in kickChat.seventvEmotes) {
      thirdPartEmotes.add(ChatEmote.fromKick(e));
    }
    isChatConnected.value = true;
    kickChat.chatStream.listen((message) {
      final KickEvent? kickEvent = eventParser(message);
      switch (kickEvent?.event) {
        case TypeEvent.message:
          entity.ChatMessage kickMessage = entity.ChatMessage.fromKick(
            kickEvent as KickMessage,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          chatMessages.add(kickMessage);
          break;
        case TypeEvent.followersUpdated:
          // TODO: TBD
          break;
        case TypeEvent.streamHostEvent:
          entity.ChatMessage kickMessage = entity.ChatMessage.kickHost(
            kickEvent as KickStreamHost,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          chatMessages.add(kickMessage);
          break;
        case TypeEvent.subscriptionEvent:
          entity.ChatMessage kickMessage = entity.ChatMessage.kickSub(
            kickEvent as KickSubscription,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          chatMessages.add(kickMessage);
          break;
        case TypeEvent.chatroomUpdatedEvent:
          // TODO: TBD
          break;
        case TypeEvent.userBannedEvent:
          KickUserBanned event = kickEvent as KickUserBanned;
          for (var message in chatMessages.where(
            (message) =>
                message.authorId == event.data.user.id.toString() &&
                message.platform == Platform.kick,
          )) {
            message.isDeleted = true;
          }
          break;
        case TypeEvent.chatroomClearEvent:
          KickChatroomClear event = kickEvent as KickChatroomClear;
          chatMessages
              .removeWhere((message) => message.channelId == event.channel);
          break;
        case TypeEvent.giftedSubscriptionsEvent:
          entity.ChatMessage kickMessage = entity.ChatMessage.kickSubGift(
            kickEvent as KickGiftedSubscriptions,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          chatMessages.add(kickMessage);
          break;
        case TypeEvent.pinnedMessageCreatedEvent:
          // TODO: event in chat (NOT CURRENTLY CODED IN THE APP, SAME FOR TWITCH)
          break;
        case TypeEvent.pollUpdateEvent:
          // TODO: rework poll view to integrate kick polls
          break;
        case TypeEvent.messageDeletedEvent:
          KickMessageDeleted event = kickEvent as KickMessageDeleted;
          chatMessages
              .firstWhereOrNull(
                  (message) => message.id == event.data.message.id)
              ?.isDeleted = true;
          break;
        case null:
          break;
      }

      scrollChatToBottom();
    });
  }

  void scrollChatToBottom() {
    if (scrollController.hasClients && isAutoScrolldown.value) {
      Timer(const Duration(milliseconds: 100), () {
        if (isAutoScrolldown.value) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });
    }
  }
}
