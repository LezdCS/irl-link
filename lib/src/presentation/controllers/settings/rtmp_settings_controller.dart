import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/usecases/rtmp/add_rtmp_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_by_id_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/update_rtmp_usecase.dart';

class RtmpSettingsController extends GetxController {
  final GetRtmpListUseCase getRtmpListUseCase;
  final AddRtmpUseCase addRtmpUseCase;
  final UpdateRtmpUseCase updateRtmpUseCase;
  final GetRtmpByIdUseCase getRtmpByIdUseCase;

  RtmpSettingsController({
    required this.getRtmpListUseCase,
    required this.addRtmpUseCase,
    required this.updateRtmpUseCase,
    required this.getRtmpByIdUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    getRtmpList();
  }

  Future<void> getRtmpList() async {
    final result = await getRtmpListUseCase();
    result.fold((l) {}, (r) {});
  }

  Future<void> addRtmp(Rtmp rtmp) async {
    final result = await addRtmpUseCase(params: rtmp);
    result.fold((l) {}, (r) {});
  }

  Future<void> updateRtmp(Rtmp rtmp) async {
    final result = await updateRtmpUseCase(params: rtmp);
    result.fold((l) {}, (r) {});
  }

  Future<void> getRtmpById(int id) async {
    final result = await getRtmpByIdUseCase(params: id);
    result.fold((l) {}, (r) {});
  }
}
