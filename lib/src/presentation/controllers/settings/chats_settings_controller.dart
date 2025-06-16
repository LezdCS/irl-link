import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/usecases/settings/add_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_chat_group_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_chats_groups_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_chat_group_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class ChatsSettingsController extends GetxController {
  ChatsSettingsController({
    required this.addChatGroupUseCase,
    required this.removeChatGroupUseCase,
    required this.addChannelUseCase,
    required this.removeChannelUseCase,
    required this.getChatGroupsUseCase,
  });

  final AddChatGroupUsecase addChatGroupUseCase;
  final RemoveChatGroupUsecase removeChatGroupUseCase;
  final AddChannelUsecase addChannelUseCase;
  final RemoveChannelUsecase removeChannelUseCase;
  final GetChatGroupsUsecase getChatGroupsUseCase;

  RxList<ChatGroup> chatGroups = <ChatGroup>[].obs;

  @override
  void onInit() {
    super.onInit();
    getChatGroups();
  }

  Future<void> getChatGroups() async {
    final result = await getChatGroupsUseCase(params: null);
    result.fold(
      (l) => null,
      (r) {
        chatGroups.clear();
        chatGroups.addAll(r);
      },
    );

    if (chatGroups.firstWhereOrNull((g) => g.id == '-1') != null) {
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

      if (userTwitchChannel != null) {
        chatGroups
            .firstWhere((g) => g.id == '-1')
            .channels
            .add(userTwitchChannel);
      }
      if (userKickChannel != null) {
        chatGroups
            .firstWhere((g) => g.id == '-1')
            .channels
            .add(userKickChannel);
      }
    }
  }

  Future<void> addChatGroup(ChatGroup chatGroup) async {
    await addChatGroupUseCase(params: chatGroup);
    getChatGroups();
  }

  Future<void> removeChatGroup(ChatGroup chatGroup) async {
    await removeChatGroupUseCase(params: chatGroup);
    getChatGroups();
  }

  Future<void> addChannel(ChatGroup chatGroup, Channel channel) async {
    await addChannelUseCase(params: (chatGroup, channel));
    getChatGroups();
  }

  Future<void> removeChannel(ChatGroup chatGroup, Channel channel) async {
    await removeChannelUseCase(params: (chatGroup, channel));
    getChatGroups();
  }
}
