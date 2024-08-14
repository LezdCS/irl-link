import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:irllink/main.dart';
import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/services/realtime_irl.dart';
import 'package:irllink/src/core/utils/determine_position.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class RealtimeIrlViewController extends GetxController {
  late RealtimeIrl realtimeIrl;

  late HomeViewController homeViewController;

  @override
  void onInit() {
    homeViewController = Get.find<HomeViewController>();

    realtimeIrl =
        RealtimeIrl(homeViewController.settings.value.rtIrlPushKey ?? '');

    FlutterForegroundTask.addTaskDataCallback(realtimeIrl.onReceiveTaskData);
    _initService();
    super.onInit();
  }

  @override
  void onClose() {
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
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        notificationIcon: null,
        notificationButtons: [
          const NotificationButton(id: 'btn_hello', text: 'hello'),
        ],
        callback: startCallback,
      );
    }
  }

  Future stop() async {
    return await realtimeIrl.stopTracking();
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
    Settings settings = homeViewController.settings.value;
    realtimeIrl.key = settings.rtIrlPushKey ?? '';
  }
}
