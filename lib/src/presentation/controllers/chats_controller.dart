import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/usecases/kick/ban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/unban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_hidden_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_chats_groups_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_hidden_users_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_hidden_user_usecase.dart';
import 'package:irllink/src/presentation/controllers/chat_view_controller.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:irllink/src/presentation/views/chat_view.dart';

class ChatsController extends GetxController with GetTickerProviderStateMixin {
  ChatsController({
    required this.talkerService,
    required this.banKickUserUseCase,
    required this.unbanKickUserUseCase,
    required this.addHiddenUserUseCase,
    required this.removeHiddenUserUseCase,
    required this.getHiddenUsersUseCase,
    required this.settingsService,
    required this.getChatGroupsUseCase,
  });

  final TalkerService talkerService;
  final BanKickUserUseCase banKickUserUseCase;
  final UnbanKickUserUseCase unbanKickUserUseCase;
  final AddHiddenUserUseCase addHiddenUserUseCase;
  final RemoveHiddenUserUseCase removeHiddenUserUseCase;
  final GetHiddenUsersUseCase getHiddenUsersUseCase;
  final SettingsService settingsService;
  final GetChatGroupsUsecase getChatGroupsUseCase;

  late Rx<TabController> chatTabsController;
  RxList<ChatView> chatsViews = <ChatView>[].obs;
  Rxn<ChatGroup> selectedChatGroup = Rxn<ChatGroup>();
  Rxn<entity.ChatMessage> selectedMessage = Rxn<entity.ChatMessage>();
  RxBool showPinnedMessages = false.obs;

  @override
  void onInit() {
    super.onInit();
    chatTabsController = TabController(length: 0, vsync: this).obs;

    // Listen to chatsViews changes and update chatTabsController accordingly
    chatsViews.listen((list) {
      _updateTabController();
    });

    generateChats();
  }

  void _updateTabController() {
    // Dispose old TabController to prevent memory leak
    chatTabsController.value.dispose();

    chatTabsController.value =
        TabController(length: chatsViews.length, vsync: this);
    if (chatTabsController.value.index > chatsViews.length - 1) {
      chatTabsController.value.animateTo(0);
    }
  }

  void setTabIndex(int index) {
    if (index >= 0 && index < chatsViews.length) {
      final newController =
          TabController(length: chatsViews.length, vsync: this);
      newController.animateTo(index);
      chatTabsController.value.dispose();
      chatTabsController.value = newController;

      if (Get.isRegistered<ChatViewController>(
        tag: chatsViews[index].chatGroup.id,
      )) {
        ChatViewController c = Get.find<ChatViewController>(
          tag: chatsViews[index].chatGroup.id,
        );
        c.scrollToBottom();
        selectedChatGroup.value = c.chatGroup;
      }
      selectedMessage.value = null;
    }
  }

  Future<void> generateChats() async {
    List<ChatView> groupsViews = List<ChatView>.from(chatsViews);

    // 1. Find the groups that are in the groupsViews but not in the settings to remove them
    final result = await getChatGroupsUseCase(params: null);
    List<ChatGroup> settingsGroups = result.fold(
      (l) => [],
      (r) => r,
    );

    List<ChatGroup> groupsToRemove = groupsViews
        .where(
          (groupView) =>
              !settingsGroups
                  .any((sGroup) => sGroup.id == groupView.chatGroup.id) ||
              groupView.chatGroup.channels.isEmpty,
        )
        .map((groupView) => groupView.chatGroup)
        .toList();

    // Remove groups that are no longer in settings
    chatsViews.removeWhere((groupView) {
      if (groupView.chatGroup.id == '-1') {
        return false;
      }

      if (groupsToRemove.any((g) => g.id == groupView.chatGroup.id)) {
        Get.delete<ChatViewController>(tag: groupView.chatGroup.id);
        return true;
      }
      return false;
    });

    // 2. Find the groups that are in the settings but not in the groupsViews to add them
    List<ChatGroup> groupsToAdd = settingsGroups
        .where(
          (sGroup) =>
              !groupsViews
                  .any((groupView) => groupView.chatGroup.id == sGroup.id) &&
              (sGroup.channels.isNotEmpty || sGroup.id == '-1'),
        )
        .toList();
    for (var group in groupsToAdd) {
      ChatView groupView = ChatView(
        chatGroup: group,
      );
      await putChat(group);
      chatsViews.add(groupView);
    }

    // Prepare user's channels if logged in
    if (Get.find<HomeViewController>().twitchData.value != null) {
      final userTwitchChannel = Channel(
        platform: Platform.twitch,
        channel:
            Get.find<HomeViewController>().twitchData.value!.twitchUser.login,
      );
      settingsGroups
          .firstWhere((c) => c.id == '-1')
          .channels
          .add(userTwitchChannel);
    }
    if (Get.find<HomeViewController>().kickData.value != null) {
      final userKickChannel = Channel(
        platform: Platform.kick,
        channel: Get.find<HomeViewController>().kickData.value!.kickUser.name,
      );
      settingsGroups
          .firstWhere((c) => c.id == '-1')
          .channels
          .add(userKickChannel);
    }

    // 4. Call the updateChannels and createChats function for each group controller
    for (ChatView c in chatsViews) {
      List<Channel> channelsToUpdate;

      ChatGroup? chatGroup = settingsGroups.firstWhereOrNull(
        (g) => g.id == c.chatGroup.id,
      );

      if (chatGroup == null) {
        continue;
      }

      channelsToUpdate = chatGroup.channels;

      c.controller.updateChannels(
        channelsToUpdate,
      );
      c.controller.createChats();
    }

    if (chatsViews.isEmpty) {
      selectedChatGroup.value = null;
    } else if (selectedChatGroup.value == null) {
      // Set selectedChatGroup to the first chat group if none is selected
      if (Get.isRegistered<ChatViewController>(
        tag: chatsViews.first.chatGroup.id,
      )) {
        ChatViewController c = Get.find<ChatViewController>(
          tag: chatsViews.first.chatGroup.id,
        );
        selectedChatGroup.value = c.chatGroup;
      }
    }
  }

  Future<void> putChat(ChatGroup chatGroup) async {
    await Get.putAsync<ChatViewController>(
      () async {
        final controller = ChatViewController(
          chatGroup: chatGroup,
          homeViewController: Get.find<HomeViewController>(),
          settingsService: Get.find<SettingsService>(),
          talker: talkerService.talker,
          ttsService: Get.find<TtsService>(),
          watchService: Get.find<WatchService>(),
          banKickUserUseCase: banKickUserUseCase,
          unbanKickUserUseCase: unbanKickUserUseCase,
          addHiddenUserUseCase: addHiddenUserUseCase,
          removeHiddenUserUseCase: removeHiddenUserUseCase,
          getHiddenUsersUseCase: getHiddenUsersUseCase,
        );
        return controller;
      },
      tag: chatGroup.id,
    );
  }

  @override
  void dispose() {
    chatTabsController.value.dispose();
    super.dispose();
  }
}
