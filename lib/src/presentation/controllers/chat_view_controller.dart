import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/core/services/youtube_chat.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/domain/entities/chat/chat_emote.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/usecases/kick/ban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/unban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_hidden_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_hidden_users_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_hidden_user_usecase.dart';
import 'package:irllink/src/presentation/controllers/chats_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:twitch_chat/twitch_chat.dart' as twitch_chat;

class ChatViewController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  ChatViewController({
    required this.chatGroup,
    required this.homeViewController,
    required this.ttsService,
    required this.watchService,
    required this.settingsService,
    required this.talker,
    required this.banKickUserUseCase,
    required this.unbanKickUserUseCase,
    required this.addHiddenUserUseCase,
    required this.removeHiddenUserUseCase,
    required this.getHiddenUsersUseCase,
  });

  final ChatGroup chatGroup;
  final HomeViewController homeViewController;
  final TtsService ttsService;
  final WatchService watchService;
  final SettingsService settingsService;
  final Talker talker;

  final BanKickUserUseCase banKickUserUseCase;
  final UnbanKickUserUseCase unbanKickUserUseCase;
  final AddHiddenUserUseCase addHiddenUserUseCase;
  final RemoveHiddenUserUseCase removeHiddenUserUseCase;
  final GetHiddenUsersUseCase getHiddenUsersUseCase;
  //CHAT
  late ScrollController scrollController;
  RxBool isAutoScrolldown = true.obs;

  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxList<ChatEmote> cheerEmotes = <ChatEmote>[].obs;
  RxList<ChatEmote> thirdPartEmotes = <ChatEmote>[].obs;

  late TextEditingController banDurationInputController;

  List<twitch_chat.TwitchChat> twitchChats = [];
  List<KickChat> kickChats = [];
  List<YoutubeChat> youtubeChats = [];

  @override
  void onInit() async {
    scrollController = ScrollController();
    banDurationInputController = TextEditingController();
    Get.find<ChatsController>().selectedChatGroup.value = chatGroup;

    chatMessages.listen((value) {
      // Send to watchOS
      watchService.sendChatMessageToNative(value.last);
    });

    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    scrollController.addListener(scrollListener);
    Connectivity().onConnectivityChanged.listen((_) {
      reconnectAllChats();
    });

    super.onReady();
  }

  @override
  void onClose() {
    Get.find<TtsService>().flutterTts.stop();
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
    for (twitch_chat.TwitchChat twitchChat in twitchChats) {
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
      youtubeChat.close();
      youtubeChat.connect();
    }
  }

  Future<bool> isUserHidden(ChatMessage message) async {
    final hiddenUsers = await getHiddenUsersUseCase();
    return hiddenUsers.fold(
          (l) => false,
          (r) => r.any((user) => user.id == message.authorId),
        ) ??
        false;
  }

  void addMessage(ChatMessage message) {
    chatMessages.add(message);
    if (chatMessages.length > 500 && isAutoScrolldown.value) {
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
    double difference = 10;

    /// bottom position
    if (!isAutoScrolldown.value &&
        maxPosition - currentPosition <= difference) {
      isAutoScrolldown.value = true;
    }
  }

  /// Delete [message] by his id
  void deleteMessageInstruction(ChatMessage message) {
    if (homeViewController.twitchData.value == null ||
        message.platform != Platform.twitch) {
      message.isDeleted = true;
      Get.find<ChatsController>().selectedMessage.value = null;
      return;
    }

    twitch_chat.TwitchApi.deleteMessage(
      homeViewController.twitchData.value!.accessToken,
      message.channelId,
      message.id,
      kTwitchAuthClientId,
    );

    Get.find<ChatsController>().selectedMessage.value = null;
  }

  /// Ban user for specific [duration] based on the author name in the [message]
  void timeoutMessageInstruction(ChatMessage message, int duration) {
    if (homeViewController.twitchData.value != null &&
        message.platform == Platform.twitch) {
      twitch_chat.TwitchApi.banUser(
        homeViewController.twitchData.value!.accessToken,
        message.channelId,
        message.authorId,
        duration,
        kTwitchAuthClientId,
      );
    }

    if (homeViewController.kickData.value != null &&
        message.platform == Platform.kick) {
      banKickUserUseCase(
        params: BanKickUserParams(
          accessToken: homeViewController.kickData.value!.accessToken,
          broadcasterUserId: homeViewController.kickData.value!.kickUser.userId,
          userToBanId: int.parse(message.authorId),
          duration: duration,
        ),
      );
    }

    Get.back();
    Get.find<ChatsController>().selectedMessage.value = null;
  }

  /// Ban user based on the author name in the [message]
  void banMessageInstruction(ChatMessage message) {
    if (message.platform == Platform.twitch &&
        homeViewController.twitchData.value != null) {
      twitch_chat.TwitchApi.banUser(
        homeViewController.twitchData.value!.accessToken,
        message.channelId,
        message.authorId,
        null,
        kTwitchAuthClientId,
      );
    }

    if (message.platform == Platform.kick &&
        homeViewController.kickData.value != null) {
      banKickUserUseCase(
        params: BanKickUserParams(
          accessToken: homeViewController.kickData.value!.accessToken,
          broadcasterUserId: homeViewController.kickData.value!.kickUser.userId,
          userToBanId: int.parse(message.authorId),
        ),
      );
    }

    Get.find<ChatsController>().selectedMessage.value = null;
  }

  /// Hide every future messages from an user in IRL Link
  void hideUser(ChatMessage message) {
    addHiddenUserUseCase(
      params: HiddenUser(
        id: message.authorId,
        username: message.username,
        platform: message.platform,
      ),
    );

    Get.find<ChatsController>().selectedMessage.refresh();
  }

  void unhideUser(ChatMessage message) {
    removeHiddenUserUseCase(
      params: HiddenUser(
        id: message.authorId,
        username: message.username,
        platform: message.platform,
      ),
    );

    Get.find<ChatsController>().selectedMessage.refresh();
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

  void updateChannels(
    List<Channel> channels,
  ) {
    // check chatGroup channels not existings in channels and remove them
    List<Channel> channelsToRemove = [];
    for (var channel in chatGroup.channels) {
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

  Future<void> createChats() async {
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

    for (Channel yc in youtubeChannels) {
      bool alreadyCreated =
          youtubeChats.firstWhereOrNull((y) => y.channelHandle == yc.channel) !=
              null;
      if (!alreadyCreated) {
        await createYoutubeChat(yc.channel);
      }
    }

    // Remove
    List<twitch_chat.TwitchChat> twitchChatToRemove = twitchChats
        .where(
          (tc) =>
              twitchChannels
                  .firstWhereOrNull((tCa) => tCa.channel == tc.channel) ==
              null,
        )
        .toList();
    List<KickChat> kickChatToRemove = kickChats
        .where(
          (kc) =>
              kickChannels
                  .firstWhereOrNull((kCa) => kCa.channel == kc.username) ==
              null,
        )
        .toList();
    List<YoutubeChat> youtubeChatToRemove = youtubeChats
        .where(
          (yc) =>
              youtubeChannels
                  .firstWhereOrNull((yCa) => yCa.channel == yc.channelHandle) ==
              null,
        )
        .toList();

    for (twitch_chat.TwitchChat t in twitchChatToRemove) {
      talker.info('Removing chat: ${t.channel}');
      t.close();
      twitchChats.removeWhere((tc) => tc.channelId == t.channelId);
    }

    for (KickChat k in kickChatToRemove) {
      talker.info('Removing chat: ${k.username}');
      k.close();
      kickChats.removeWhere((kc) => kc.username == k.username);
    }

    for (YoutubeChat y in youtubeChatToRemove) {
      talker.info('Removing chat: ${y.channelHandle}');
      y.close();
      youtubeChats.removeWhere((yc) => yc.channelHandle == y.channelHandle);
    }
  }

  void createTwitchChat(Channel tc) {
    twitch_chat.TwitchChat twitchChat;
    if (homeViewController.twitchData.value == null) {
      twitchChat = twitch_chat.TwitchChat.anonymous(tc.channel);
    } else {
      twitchChat = twitch_chat.TwitchChat(
        tc.channel,
        homeViewController.twitchData.value!.twitchUser.login,
        homeViewController.twitchData.value!.accessToken,
        clientId: kTwitchAuthClientId,
        onConnected: () async {
          // final result = await getRecentMessagesUseCase(
          //   params: GetRecentMessagesUseCaseParams(
          //     channelName: tc.channel,
          //     limit: 20,
          //   ),
          // );
          // result.fold(
          //   (l) => talker.error(l.message),
          //   (r) {
          //     for (String message in r) {
          //       final parsedMessage = RFC2812Parser.parseMessage(message);
          //       if (parsedMessage?.command == 'PRIVMSG') {
          //         final message = parsedMessage?.trailing;
          //         if (message != null) {
          //           // TODO(LezdCS): Implement
          //         }
          //       }
          //     }
          //   },
          // );
        },
        onClearChat: () {
          chatMessages.clear();
        },
        onDeletedMessageByUserId: (String? userId) {
          for (ChatMessage message in chatMessages.where(
            (message) =>
                message.authorId == userId &&
                message.platform == Platform.twitch,
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
        params: const twitch_chat.TwitchChatParameters(addFirstMessages: true),
      );
    }
    twitchChat.connect();
    twitchChats.add(twitchChat);

    twitchChat.chatStream.listen((twitchMessage) async {
      final settings = settingsService.settings.value;

      if (cheerEmotes.isEmpty) {
        cheerEmotes.value =
            twitchChat.cheerEmotes.map((e) => ChatEmote.fromTwitch(e)).toList();
      }
      if (thirdPartEmotes.isEmpty) {
        thirdPartEmotes.value = twitchChat.thirdPartEmotes
            .map((e) => ChatEmote.fromTwitch(e))
            .toList();
      }
      ChatMessage message =
          ChatMessage.fromTwitch(twitchMessage, twitchChat.channelId ?? '');
      if (await isUserHidden(message)) {
        return;
      }
      if (settings.ttsSettings.ttsEnabled) {
        ttsService.readTts(message);
      }

      addMessage(message);
    });
  }

  Future<void> createYoutubeChat(String channelId) async {
    if (homeViewController.twitchData.value == null) {
      Get.snackbar(
        'Error',
        'Twitch authentication is required to use YouTube chat',
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
      return;
    }
    YoutubeChat youtubeChat = await YoutubeChat(
      talker: talker,
      twitchToken: homeViewController.twitchData.value!.accessToken,
    ).init(channel: channelId);
    await youtubeChat.connect();
    youtubeChat.chatStream.listen((ChatMessage message) {
      Settings settings = settingsService.settings.value;
      if (settings.ttsSettings.ttsEnabled) {
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
        talker.error('error on kick chat'),
      },
      onChatroomClear: (String channelId) {
        chatMessages.removeWhere((message) => message.channelId == channelId);
      },
      onDeletedMessageByMessageId: (String messageId) {
        chatMessages
            .firstWhereOrNull((message) => message.id == messageId)
            ?.isDeleted = true;
        chatMessages.refresh();
      },
      onDeletedMessageByUserId: (String userId) {
        for (ChatMessage message in chatMessages.where(
          (message) =>
              message.authorId == userId && message.platform == Platform.kick,
        )) {
          message.isDeleted = true;
        }
        chatMessages.refresh();
      },
      onMessagePinned: (KickPinnedMessageCreated pinnedMessage) {
        PinnedMessage message = PinnedMessage.fromKick(pinnedMessage);
        homeViewController.pinnedMessages.add(message);
      },
      onMessageUnpinned: (KickPinnedMessageDeleted unpinnedMessage) {
        homeViewController.pinnedMessages
            .removeWhere((message) => message.id == unpinnedMessage.channel);
      },
    );
    kickChats.add(kickChat);
    await kickChat.connect();
    for (var e in kickChat.seventvEmotes) {
      thirdPartEmotes.add(ChatEmote.fromKick(e));
    }
    kickChat.chatStream.listen((KickEvent event) {
      ChatMessage message = ChatMessage.fromKick(
        event,
        kickChat.userDetails!.userId.toString(),
        kickChat.userDetails!.subBadges,
      );
      // INFO: Temporary fix to prevent duplicate messages
      if (chatMessages.firstWhereOrNull((e) => e.id == message.id) != null) {
        return;
      }
      Settings settings = settingsService.settings.value;
      if (settings.ttsSettings.ttsEnabled) {
        ttsService.readTts(message);
      }
      // For some reason, the same message is sent multiple times, need to investigate further but for now, this is a workaround
      if (chatMessages.contains(message)) {
        return;
      }
      addMessage(message);
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
