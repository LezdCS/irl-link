import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';

class WatchService extends GetxService {
  Future<WatchService> init() async {
    const channel = MethodChannel('com.irllink');
    channel.setMethodCallHandler((call) async {
      // Receive data from Native
      debugPrint('Data from watch: ${call.arguments}');
      dynamic data = call.arguments['data'];
      switch (call.method) {
        case "sendChangeObsSceneToFlutter":
          ObsTabViewController obsTabViewController =
              Get.find<ObsTabViewController>();
          obsTabViewController.setCurrentScene(data['scene']);
          break;
        case "sendToggleObsSourceToFlutter":
          ObsTabViewController obsTabViewController =
              Get.find<ObsTabViewController>();
          obsTabViewController.setSourceVisibleState(
            data['sourceItemId'],
            data['sceneItemEnabled'],
          );
          break;
        default:
          break;
      }
    });
    return this;
  }
}
