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

    realtimeIrl = RealtimeIrl('key'); //TODO: set key from settings

    super.onInit();
  }

  Future stop() async {
    realtimeIrl.status = RtIrlStatus.stopped;
    timerRtIrl.cancel();
    return await realtimeIrl.stopTracking();
  }

  Future start() async {
    realtimeIrl.status = RtIrlStatus.updating;
    timerRtIrl = Timer.periodic(const Duration(seconds: 4), (Timer t) async {
      DataState<Position> p = await determinePosition();
      if (p.error == null && realtimeIrl.status == RtIrlStatus.updating) {
        realtimeIrl.updatePosition(p.data!);
      }
    });
  }
}
