import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/datasources/local/streamelements_local_data_source.dart';
import 'package:irllink/src/data/datasources/remote/streamelements_remote_data_source.dart';
import 'package:irllink/src/data/repositories/streamelements_repository_impl.dart';
import 'package:irllink/src/domain/usecases/streamelements/disconnect_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_local_credentials_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_me_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/get_se_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/login_usecase.dart';
import 'package:irllink/src/domain/usecases/streamelements/set_se_settings_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/streamelements_settings_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class StreamelementsSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Talker talker = Get.find<TalkerService>().talker;
    Dio streamElementsDioClient = initDio(kStreamelementsUrlBase);

    final streamelementsRepository = StreamelementsRepositoryImpl(
      talker: talker,
      remoteDataSource: StreamelementsRemoteDataSourceImpl(
        dioClient: streamElementsDioClient,
        talker: talker,
      ),
      localDataSource: StreamelementsLocalDataSourceImpl(
        talker: talker,
      ),
    );
    StreamElementsLoginUseCase streamElementsLoginUseCase =
        StreamElementsLoginUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    StreamElementsDisconnectUseCase streamElementsDisconnectUseCase =
        StreamElementsDisconnectUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    StreamElementsGetLocalCredentialsUseCase
        streamElementsGetLocalCredentialsUseCase =
        StreamElementsGetLocalCredentialsUseCase(
      streamelementsRepository: streamelementsRepository,
    );
    StreamElementsGetMeUseCase streamElementsGetMeUseCase =
        StreamElementsGetMeUseCase(
      streamelementsRepository: streamelementsRepository,
    );

    GetStreamElementsSettingsUseCase getStreamElementsSettingsUseCase =
        GetStreamElementsSettingsUseCase(
      repository: streamelementsRepository,
    );
    SetStreamElementsSettingsUseCase setStreamElementsSettingsUseCase =
        SetStreamElementsSettingsUseCase(
      repository: streamelementsRepository,
    );

    Get.lazyPut(
      () => StreamelementsSettingsController(
        streamElementsLoginUseCase: streamElementsLoginUseCase,
        streamElementsDisconnectUseCase: streamElementsDisconnectUseCase,
        streamElementsGetLocalCredentialsUseCase:
            streamElementsGetLocalCredentialsUseCase,
        getMeUseCase: streamElementsGetMeUseCase,
        storeService: Get.find<StoreService>(),
        getStreamElementsSettingsUseCase: getStreamElementsSettingsUseCase,
        setStreamElementsSettingsUseCase: setStreamElementsSettingsUseCase,
      ),
    );
  }
}
