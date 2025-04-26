import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/usecases/rtmp/add_rtmp_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/delete_rtmp_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_by_id_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:irllink/src/domain/usecases/rtmp/update_rtmp_usecase.dart';

class RtmpSettingsController extends GetxController {
  final GetRtmpListUseCase getRtmpListUseCase;
  final AddRtmpUseCase addRtmpUseCase;
  final UpdateRtmpUseCase updateRtmpUseCase;
  final GetRtmpByIdUseCase getRtmpByIdUseCase;
  final DeleteRtmpUseCase deleteRtmpUseCase;

  RtmpSettingsController({
    required this.getRtmpListUseCase,
    required this.addRtmpUseCase,
    required this.updateRtmpUseCase,
    required this.getRtmpByIdUseCase,
    required this.deleteRtmpUseCase,
  });

  RxList<Rtmp> rtmpList = <Rtmp>[].obs;
  Rxn<Rtmp> selectedRtmp = Rxn<Rtmp>();

  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getRtmpList();
  }

  Future<void> getRtmpList() async {
    final result = await getRtmpListUseCase();
    result.fold((l) {}, (r) {
      rtmpList.value = r;
    });
  }

  Future<void> addRtmp(Rtmp rtmp) async {
    final result = await addRtmpUseCase(params: rtmp);
    result.fold((l) {}, (r) {
      getRtmpList();
    });
  }

  Future<void> updateRtmp(Rtmp rtmp) async {
    final result = await updateRtmpUseCase(params: rtmp);
    result.fold((l) {}, (r) {
      rtmpList.value = rtmpList.map((e) => e.id == rtmp.id ? rtmp : e).toList();
    });
  }

  Future<void> getRtmpById(int id) async {
    final result = await getRtmpByIdUseCase(params: id);
    result.fold((l) {}, (r) {
      selectedRtmp.value = r;
    });
  }

  Future<void> deleteRtmp(int id) async {
    final result = await deleteRtmpUseCase(params: id);
    result.fold((l) {}, (r) {
      getRtmpList();
    });
  }
}
