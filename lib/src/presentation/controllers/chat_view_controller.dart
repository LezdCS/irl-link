import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/youtube_chat.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:twitch_chat/twitch_chat.dart' hide ChatMessage;

class ChatViewController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  ChatViewController({
    required this.homeEvents,
    required this.chatGroup,
  });

  final HomeEvents homeEvents;
  ChatGroup chatGroup;

  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;

  TwitchCredentials? twitchData;
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxList<ChatEmote> cheerEmotes = <ChatEmote>[].obs;
  RxList<ChatEmote> thirdPartEmotes = <ChatEmote>[].obs;

  late TextEditingController banDurationInputController;

  final HomeViewController homeViewController = Get.find<HomeViewController>();
  final TtsService ttsService = Get.find<TtsService>();

  List<TwitchChat> twitchChats = [];
  List<KickChat> kickChats = [];
  List<YoutubeChat> youtubeChats = [];

  @override
  void onInit() async {
    scrollController = ScrollController();
    banDurationInputController = TextEditingController();
    if (Get.arguments != null) {
      twitchData = Get.arguments[0];
      await applySettings();
      homeViewController.selectedChatGroup.value = chatGroup;
    }

    chatMessages.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendChatMessageToNative",
        "data": value.last.toJsonForWatch(),
      });
    });

    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      reconnectAllChats();
    });

    super.onReady();
  }

  @override
  void onClose() {
    Get.find<TtsService>().flutterTts.stop();
    super.onDelete;
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // The app is back to the foreground
      reconnectAllChats();
    } else if (state == AppLifecycleState.paused) {
      // The app is sent to the background
    }
  }

  void reconnectAllChats() {
    for (TwitchChat twitchChat in twitchChats) {
      if (!twitchChat.isConnected.value) {
        twitchChat.close();
        twitchChat.connect();
      }
    }
    for (KickChat kickChat in kickChats) {
      kickChat.close();
      kickChat.connect();
    }
    for (YoutubeChat youtubeChat in youtubeChats) {
      youtubeChat.startFetchingChat();
    }
  }

  void addMessage(ChatMessage message) {
    chatMessages.add(message);
    if(chatMessages.length > 500) {
      chatMessages.removeAt(0);
    }
    scrollChatToBottom();
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
  void deleteMessageInstruction(ChatMessage message) {
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
  void timeoutMessageInstruction(ChatMessage message, int duration) {
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
  void banMessageInstruction(ChatMessage message) {
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
  void hideUser(ChatMessage message) {
    if (twitchData == null) return;
    Settings settings = Get.find<SettingsService>().settings.value;

    List hiddenUsersIds =
        settings.hiddenUsersIds! != const [] ? settings.hiddenUsersIds! : [];
    if (hiddenUsersIds
            .firstWhereOrNull((userId) => userId == message.authorId) ==
        null) {
      //add user
      hiddenUsersIds.add(message.authorId);
      Get.find<SettingsService>().settings.value =
          settings.copyWith(hiddenUsersIds: hiddenUsersIds);
    } else {
      //remove user
      hiddenUsersIds.remove(message.authorId);
      Get.find<SettingsService>().settings.value =
          settings.copyWith(hiddenUsersIds: hiddenUsersIds);
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
      if (!alreadyCreated) {
        createKickChat(kc);
      }
    }

    for (Channel kc in youtubeChannels) {
      bool alreadyCreated =
          kickChats.firstWhereOrNull((k) => k.username == kc.channel) != null;
      if (!alreadyCreated) {
        createYoutubeChat(kc.channel);
      }
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
        for (ChatMessage message in chatMessages.where(
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
      onDone: () {},
      onError: () {},
      params: const TwitchChatParameters(addFirstMessages: true),
    );
    twitchChat.connect();
    twitchChats.add(twitchChat);

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
      ChatMessage twitchMessage =
          ChatMessage.fromTwitch(message, twitchChat.channelId ?? '');
      addMessage(twitchMessage);
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
    youtubeChat.chatStream.listen((ChatMessage message) {
      Settings settings = Get.find<SettingsService>().settings.value;
      if (settings.ttsSettings!.ttsEnabled) {
        ttsService.readTts(message);
      }
      addMessage(message);
    });
    youtubeChats.add(youtubeChat);
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
    kickChat.chatStream.listen((message) {
      final KickEvent? kickEvent = eventParser(message);
      switch (kickEvent?.event) {
        case TypeEvent.message:
          ChatMessage kickMessage = ChatMessage.fromKick(
            kickEvent as KickMessage,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          Settings settings = Get.find<SettingsService>().settings.value;
          if (settings.ttsSettings!.ttsEnabled) {
            ttsService.readTts(kickMessage);
          }
          addMessage(kickMessage);
          break;
        case TypeEvent.followersUpdated:
          // TODO: TBD
          break;
        case TypeEvent.streamHostEvent:
          ChatMessage kickMessage = ChatMessage.kickHost(
            kickEvent as KickStreamHost,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          addMessage(kickMessage);
          break;
        case TypeEvent.subscriptionEvent:
          ChatMessage kickMessage = ChatMessage.kickSub(
            kickEvent as KickSubscription,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          addMessage(kickMessage);
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
          ChatMessage kickMessage = ChatMessage.kickSubGift(
            kickEvent as KickGiftedSubscriptions,
            kickChat.userDetails!.userId.toString(),
            kickChat.userDetails!.subBadges,
          );
          addMessage(kickMessage);
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
