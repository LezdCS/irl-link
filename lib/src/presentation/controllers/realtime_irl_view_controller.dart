import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/realtime_irl.dart';
import 'package:irllink/src/core/utils/determine_position.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class RealtimeIrlViewController extends GetxController {
  late Timer timerRtIrl;
  late RealtimeIrl realtimeIrl;

  late HomeViewController homeViewController;

  @override
  void onInit() {
    homeViewController = Get.find<HomeViewController>();

    realtimeIrl =
        RealtimeIrl(homeViewController.settings.value.rtIrlPushKey ?? '');

    super.onInit();
  }

  Future stop() async {
    timerRtIrl.cancel();
    return await realtimeIrl.stopTracking();
  }

  Future start() async {
    realtimeIrl.status.value = RtIrlStatus.updating;
    DataState<Position> p = await determinePosition();

    timerRtIrl = Timer.periodic(const Duration(seconds: 4), (Timer t) async {
      if (p is DataSuccess &&
          realtimeIrl.status.value == RtIrlStatus.updating) {
        DataState updateResult = await realtimeIrl.updatePosition(p.data!);
        if (updateResult is DataFailed) {
          realtimeIrl.status.value = RtIrlStatus.stopped;
          await stop();
        }
      }
    });
  }
}
