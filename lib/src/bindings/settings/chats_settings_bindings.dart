import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings/add_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_chat_group_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_chats_groups_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_channel_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_chat_group_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/chats_settings_controller.dart';

class ChatsSettingsBindings extends Bindings {
  @override
  void dependencies() {
    final talkerService = Get.find<TalkerService>();
    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );
    final addChatGroupUseCase = AddChatGroupUsecase(
      settingsRepository: settingsRepository,
    );
    final removeChatGroupUseCase = RemoveChatGroupUsecase(
      settingsRepository: settingsRepository,
    );
    final addChannelUseCase = AddChannelUsecase(
      settingsRepository: settingsRepository,
    );
    final removeChannelUseCase = RemoveChannelUsecase(
      settingsRepository: settingsRepository,
    );
    final getChatGroupsUseCase = GetChatGroupsUsecase(
      settingsRepository: settingsRepository,
    );
    Get.lazyPut(
      () => ChatsSettingsController(
        addChatGroupUseCase: addChatGroupUseCase,
        removeChatGroupUseCase: removeChatGroupUseCase,
        addChannelUseCase: addChannelUseCase,
        removeChannelUseCase: removeChannelUseCase,
        getChatGroupsUseCase: getChatGroupsUseCase,
      ),
    );
  }
}
