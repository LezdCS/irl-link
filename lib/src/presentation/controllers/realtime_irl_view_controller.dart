import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
    if (Platform.isAndroid) {
      dynamic result = await Get.dialog(
        AlertDialog(
          title: const Text('RealtimeIRL'),
          content: const Text(
            'This application will ask the permission to access your location to share it with RealtimeIRL service.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    DataState<Position> p = await determinePosition();

    if (p.error != null) {
      Get.snackbar(
        "Error",
        p.error!,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
      return;
    }
    realtimeIrl.status.value = RtIrlStatus.updating;

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
