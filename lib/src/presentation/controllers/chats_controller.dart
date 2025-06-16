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

  RxList<ChatView> chatsViews = <ChatView>[].obs;
  late TabController chatTabsController;
  Rxn<ChatGroup> selectedChatGroup = Rxn<ChatGroup>();

  Rxn<entity.ChatMessage> selectedMessage = Rxn<entity.ChatMessage>();
  RxBool showPinnedMessages = false.obs;

  @override
  void onInit() {
    super.onInit();
    chatTabsController = TabController(length: chatsViews.length, vsync: this);
    generateChats();
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

    chatTabsController = TabController(length: chatsViews.length, vsync: this);
    if (chatsViews.isEmpty) {
      selectedChatGroup.value = null;
    } else if (chatTabsController.index >= chatsViews.length) {
      chatTabsController.animateTo(0);
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
}
