import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;
import 'package:irllink/src/domain/entities/chat/chat_message.dart' as entity;
import 'package:irllink/src/domain/entities/settings.dart';
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
    Settings settings = settingsService.settings.value;

    List<ChatView> groupsViews = List<ChatView>.from(chatsViews);

    // 1. Find the groups that are in the groupsViews but not in the settings to remove them
    List<ChatGroup> settingsGroups =
        settings.chatSettings.copyWith().chatGroups;
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
      if (groupView.chatGroup.id == 'permanentFirstGroup') {
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
              sGroup.channels.isNotEmpty, // Only add groups with channels
        )
        .toList();
    for (var group in groupsToAdd) {
      ChatView groupView = ChatView(
        chatGroup: group,
      );
      await putChat(group);
      chatsViews.add(groupView);
    }

    // 3. We add the 'Permanent First Group' from the settings to the first position if it does not exist yet in the channels
    ChatGroup? permanentFirstGroupFromSettings =
        settings.chatSettings.permanentFirstGroup.copyWith();
    List<Channel> targetPermanentChannels =
        List.from(permanentFirstGroupFromSettings.channels);

    // Prepare user's channels if logged in
    Channel? userTwitchChannel;
    if (Get.find<HomeViewController>().twitchData.value != null) {
      userTwitchChannel = Channel(
        platform: Platform.twitch,
        channel:
            Get.find<HomeViewController>().twitchData.value!.twitchUser.login,
      );
    }
    Channel? userKickChannel;
    if (Get.find<HomeViewController>().kickData.value != null) {
      userKickChannel = Channel(
        platform: Platform.kick,
        channel: Get.find<HomeViewController>().kickData.value!.kickUser.name,
      );
    }

    // Add user's channels to the target list if they don't exist
    if (userKickChannel != null &&
        !targetPermanentChannels.any(
          (c) =>
              c.platform == Platform.kick &&
              c.channel == userKickChannel!.channel,
        )) {
      targetPermanentChannels.insert(0, userKickChannel);
    }
    if (userTwitchChannel != null &&
        !targetPermanentChannels.any(
          (c) =>
              c.platform == Platform.twitch &&
              c.channel == userTwitchChannel!.channel,
        )) {
      targetPermanentChannels.insert(0, userTwitchChannel);
    }

    // Find the existing permanent group view
    int permanentGroupIndex = chatsViews.indexWhere(
      (groupView) =>
          groupView.chatGroup.id == permanentFirstGroupFromSettings.id,
    );

    // If the permanent group view doesn't exist, create and add it
    if (permanentGroupIndex == -1) {
      ChatGroup permanentGroup = permanentFirstGroupFromSettings.copyWith(
        channels: targetPermanentChannels,
      );
      ChatView groupView = ChatView(
        chatGroup: permanentGroup,
      );
      await putChat(permanentGroup);
      chatsViews.insert(0, groupView);
      // Update the index as we just inserted it
      permanentGroupIndex = 0;
    }
    // No else needed here, the update happens in the loop below

    // 4. Call the updateChannels and createChats function for each group controller
    for (ChatView c in chatsViews) {
      List<Channel> channelsToUpdate;
      if (c.chatGroup.id == permanentFirstGroupFromSettings.id) {
        // Use the definitive target list for the permanent group
        channelsToUpdate = targetPermanentChannels;
      } else {
        // Use the channels from settings for other groups
        channelsToUpdate = settingsGroups
            .firstWhere(
              (g) => g.id == c.chatGroup.id,
              orElse: () => const ChatGroup(id: 'fallback', channels: []),
            )
            .channels;
      }

      c.controller.updateChannels(
        channelsToUpdate,
        Get.find<HomeViewController>().twitchData.value?.twitchUser.login,
        Get.find<HomeViewController>().kickData.value?.kickUser.name,
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
