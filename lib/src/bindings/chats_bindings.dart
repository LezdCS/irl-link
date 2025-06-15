import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/kick_local_data_source.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/kick_remote_data_source.dart';
import 'package:irllink/src/data/repositories/kick_repository_impl.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/domain/usecases/kick/ban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/unban_kick_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/add_hidden_user_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/get_hidden_users_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_hidden_user_usecase.dart';
import 'package:irllink/src/presentation/controllers/chats_controller.dart';

class ChatsBindings extends Bindings {
  @override
  void dependencies() {
    final talkerService = Get.find<TalkerService>();
    final settingsService = Get.find<SettingsService>();
    Dio kickDioClient = initDio(kKickApiUrlBase);
    final kickRepository = KickRepositoryImpl(
      localDataSource: KickLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
      remoteDataSource: KickRemoteDataSourceImpl(
        dioClient: kickDioClient,
        talker: talkerService.talker,
      ),
    );

    final unbanKickUserUseCase = UnbanKickUserUseCase(kickRepository);
    final banKickUserUseCase = BanKickUserUseCase(kickRepository);

    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: SettingsLocalDataSourceImpl(
        talker: talkerService.talker,
      ),
      talker: talkerService.talker,
    );

    final addHiddenUserUseCase =
        AddHiddenUserUseCase(settingsRepository: settingsRepository);
    final removeHiddenUserUseCase =
        RemoveHiddenUserUseCase(settingsRepository: settingsRepository);
    final getHiddenUsersUseCase =
        GetHiddenUsersUseCase(settingsRepository: settingsRepository);

    Get.lazyPut(
      () => ChatsController(
        talkerService: talkerService,
        banKickUserUseCase: banKickUserUseCase,
        unbanKickUserUseCase: unbanKickUserUseCase,
        addHiddenUserUseCase: addHiddenUserUseCase,
        removeHiddenUserUseCase: removeHiddenUserUseCase,
        getHiddenUsersUseCase: getHiddenUsersUseCase,
        settingsService: settingsService,
      ),
    );
  }
}
