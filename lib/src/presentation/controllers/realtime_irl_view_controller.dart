import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:irllink/main.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/realtime_irl.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/determine_position.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class RealtimeIrlViewController extends GetxController {
  late RealtimeIrl realtimeIrl;

  final HomeViewController homeViewController = Get.find<HomeViewController>();

  @override
  void onInit() {
    Settings settings = Get.find<SettingsService>().settings.value;

    realtimeIrl = RealtimeIrl(settings.rtIrlPushKey);

    FlutterForegroundTask.addTaskDataCallback(realtimeIrl.onReceiveTaskData);
    _initService();
    super.onInit();
  }

  @override
  void onClose() {
    FlutterForegroundTask.stopService();
    FlutterForegroundTask.removeTaskDataCallback(realtimeIrl.onReceiveTaskData);
    super.onClose();
  }

  Future<void> _initService() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'IRL Link',
        notificationText: 'Your location is being shared with RealtimeIRL.',
        notificationIcon: const NotificationIconData(
            resType: ResourceType.drawable,
            resPrefix: ResourcePrefix.ic,
            name: 'bg_service_small',),
        notificationButtons: [
          const NotificationButton(id: 'rtirl_stop', text: 'Stop sharing'),
        ],
        callback: startCallback,
      );
    }
  }

  Future stop() async {
    return realtimeIrl.stopTracking();
  }

  Future start() async {
    if (Platform.isAndroid) {
      if (await Geolocator.checkPermission() == LocationPermission.denied) {
        await Get.dialog(
          barrierDismissible: false,
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

    _startService();
  }

  Future applySettings() async {
    Settings settings = Get.find<SettingsService>().settings.value;
    realtimeIrl.key = settings.rtIrlPushKey;
  }
}
