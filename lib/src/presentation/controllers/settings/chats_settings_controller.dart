import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/usecases/settings/add_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_chat_group_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_chat_group_usecase.dart';

class ChatsSettingsController extends GetxController {
  ChatsSettingsController({
    required this.addChatGroupUseCase,
    required this.removeChatGroupUseCase,
    required this.addChannelUseCase,
    required this.removeChannelUseCase,
  });

  final AddChatGroupUsecase addChatGroupUseCase;
  final RemoveChatGroupUsecase removeChatGroupUseCase;
  final AddChannelUsecase addChannelUseCase;
  final RemoveChannelUsecase removeChannelUseCase;

  Future<void> addChatGroup(ChatGroup chatGroup) async {
    addChatGroupUseCase(params: chatGroup);
  }

  Future<void> removeChatGroup(ChatGroup chatGroup) async {
    removeChatGroupUseCase(params: chatGroup);
  }

  Future<void> addChannel(ChatGroup chatGroup, Channel channel) async {
    addChannelUseCase(params: (chatGroup, channel));
  }

  Future<void> removeChannel(ChatGroup chatGroup, Channel channel) async {
    removeChannelUseCase(params: (chatGroup, channel));
  }
}
