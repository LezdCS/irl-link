import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/data/datasources/local/rtmp_local_data_source.dart';
import 'package:irllink/src/data/repositories/rtmp_repository_impl.dart';
import 'package:irllink/src/domain/usecases/rtmp/add_rtmp_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/delete_rtmp_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_by_id_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/update_rtmp_usecase.dart';
import 'package:irllink/src/presentation/controllers/settings/rtmp_settings_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RtmpSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Talker talker = Get.find<TalkerService>().talker;

    final rtmpRepository = RtmpRepositoryImpl(
      talker: talker,
      localDataSource: RtmpLocalDataSourceImpl(
        talker: talker,
      ),
    );
    final getRtmpListUseCase = GetRtmpListUseCase(rtmpRepository);
    final addRtmpUseCase = AddRtmpUseCase(rtmpRepository);
    final updateRtmpUseCase = UpdateRtmpUseCase(rtmpRepository);
    final getRtmpByIdUseCase = GetRtmpByIdUseCase(rtmpRepository);
    final deleteRtmpUseCase = DeleteRtmpUseCase(rtmpRepository);
    Get.lazyPut<RtmpSettingsController>(
      () => RtmpSettingsController(
        getRtmpListUseCase: getRtmpListUseCase,
        addRtmpUseCase: addRtmpUseCase,
        updateRtmpUseCase: updateRtmpUseCase,
        getRtmpByIdUseCase: getRtmpByIdUseCase,
        deleteRtmpUseCase: deleteRtmpUseCase,
      ),
    );
  }
}
