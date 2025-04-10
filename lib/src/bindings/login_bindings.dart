import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/twitch_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/twitch_remote_data_source.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/refresh_token_usecase.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Dio dioTwitchClient = initDio(kTwitchApiUrlBase);
    Talker talker = Get.find<TalkerService>().talker;
    // Repositories
    TwitchRepositoryImpl twitchRepository = TwitchRepositoryImpl(
      remoteDataSource: TwitchRemoteDataSourceImpl(
        dioClient: dioTwitchClient,
        talker: talker,
      ),
      localDataSource: TwitchLocalDataSourceImpl(
        talker: talker,
        storage: GetStorage(),
      ),
      talker: talker,
    );

    // Use cases
    GetTwitchLocalUseCase getTwitchLocalUseCase =
        GetTwitchLocalUseCase(twitchRepository);
    RefreshTwitchTokenUseCase refreshTwitchTokenUseCase =
        RefreshTwitchTokenUseCase(twitchRepository);
    LoginUseCase loginUseCase = LoginUseCase(twitchRepository);

    Get.lazyPut<LoginViewController>(
      () => LoginViewController(
        getTwitchLocalUseCase: getTwitchLocalUseCase,
        refreshTwitchTokenUseCase: refreshTwitchTokenUseCase,
        loginUseCase: loginUseCase,
      ),
    );
  }
}
