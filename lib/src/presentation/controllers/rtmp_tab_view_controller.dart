import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:rtmp_broadcaster/camera.dart';

class RtmpTabViewController extends GetxController {
  RtmpTabViewController({
    required this.settingsService,
    required this.talkerService,
    required this.getRtmpListUseCase,
  });

  final SettingsService settingsService;
  final TalkerService talkerService;
  final GetRtmpListUseCase getRtmpListUseCase;

  List<CameraDescription> cameras = [];
  CameraController? controller;
  RxBool isControllerInitialized = false.obs;
  RxBool isStreamingVideoRtmp = false.obs;
  TextEditingController urlController = TextEditingController();
  Rxn<CameraDescription> selectedCamera = Rxn<CameraDescription>();
  RxList<Rtmp> rtmpList = <Rtmp>[].obs;
  Rxn<Rtmp> selectedRtmp = Rxn<Rtmp>();

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
    getRtmpList();
  }

  @override
  void onClose() {
    controller?.dispose();
    urlController.dispose();
    super.onClose();
  }

  Future<void> getRtmpList() async {
    final result = await getRtmpListUseCase();
    result.fold(
      (l) => talkerService.talker.error(l.toString()),
      (r) {
        rtmpList.value = r;
        // Set default selected RTMP to the first in the list if available
        if (rtmpList.isNotEmpty && selectedRtmp.value == null) {
          selectedRtmp.value = rtmpList.first;
        }
      },
    );
  }

  Future<void> _initializeCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Select the first available camera initially
        await onNewCameraSelected(cameras.first);
      }
    } on CameraException catch (e) {
      _logError(e.code, e.description);
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: ${e.description}',
      );
    } catch (e) {
      talkerService.talker.error("Error initializing cameras: $e");
      Get.snackbar(
        'Error',
        'An unexpected error occurred while initializing cameras.',
      );
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    // Stop streaming if currently active
    if (isStreamingVideoRtmp.value) {
      await stopVideoStreaming();
    }

    // Signal that the controller is about to be re-initialized
    isControllerInitialized.value = false;

    // Dispose the old controller
    if (controller != null) {
      await controller!.dispose();
      controller = null; // Ensure controller is null before creating a new one
    }

    // Allow the UI to update and resources to potentially release
    // Needs import 'package:flutter/scheduler.dart';
    await SchedulerBinding.instance.endOfFrame;

    // Check if the widget is still mounted before proceeding
    if (!isClosed) {
      controller = CameraController(
        cameraDescription,
        ResolutionPreset.medium, // Or choose based on settings
      );

      selectedCamera.value = cameraDescription;

      try {
        await controller!.initialize();
        // Check again if mounted before updating state
        if (!isClosed) {
          isControllerInitialized.value = true;
        }
      } on CameraException catch (e) {
        // Check if mounted before showing snackbar
        if (!isClosed) {
          _showCameraException(e);
          isControllerInitialized.value =
              false; // Ensure state reflects failure
        }
      } catch (e) {
        // Check if mounted before showing snackbar/logging
        if (!isClosed) {
          talkerService.talker
              .error("Error initializing camera controller: $e");
          Get.snackbar('Error', 'Failed to initialize camera controller.');
          isControllerInitialized.value =
              false; // Ensure state reflects failure
        }
      }
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> startVideoStreaming() async {
    if (!isControllerInitialized.value || controller == null) {
      Get.snackbar('Error', 'Select a camera first.');
      return null;
    }

    if (isStreamingVideoRtmp.value) {
      Get.snackbar('Info', 'Already streaming.');
      return null;
    }

    if (selectedRtmp.value!.url.isEmpty) {
      Get.snackbar('Error', 'RTMP URL is required.');
      return null;
    }

    try {
      await controller!.startVideoStreaming(selectedRtmp.value!.url);
      isStreamingVideoRtmp.value = true;
      Get.snackbar(
        'Success',
        'Streaming started to: ${selectedRtmp.value!.url}',
      );
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    } catch (e) {
      talkerService.talker.error("Error starting stream: $e");
      Get.snackbar('Error', 'Failed to start stream.');
      isStreamingVideoRtmp.value = false;
      return null;
    }
    return null;
  }

  Future<void> stopVideoStreaming() async {
    if (!isStreamingVideoRtmp.value ||
        controller == null ||
        !isControllerInitialized.value) {
      Get.snackbar('Info', 'Not streaming.');
      return;
    }

    try {
      await controller!.stopVideoStreaming();
      isStreamingVideoRtmp.value = false;
      Get.snackbar('Success', 'Streaming stopped.');
    } on CameraException catch (e) {
      _showCameraException(e);
    } catch (e) {
      talkerService.talker.error("Error stopping stream: $e");
      Get.snackbar('Error', 'Failed to stop stream.');
      // We might still be streaming? Keep state as true or set to false?
      // isStreamingVideoRtmp.value = false; // Let's assume it stopped
    }
  }

  Future<void> pauseVideoStreaming() async {
    if (!isStreamingVideoRtmp.value) {
      return;
    }
    try {
      await controller!.pauseVideoStreaming();
      Get.snackbar('Info', 'Streaming paused.');
    } on CameraException catch (e) {
      _showCameraException(e);
    } catch (e) {
      talkerService.talker.error("Error pausing stream: $e");
      Get.snackbar('Error', 'Failed to pause stream.');
    }
  }

  Future<void> resumeVideoStreaming() async {
    if (!isStreamingVideoRtmp.value) {
      return;
    }
    try {
      await controller!.resumeVideoStreaming();
      Get.snackbar('Info', 'Streaming resumed.');
    } on CameraException catch (e) {
      _showCameraException(e);
    } catch (e) {
      talkerService.talker.error("Error resuming stream: $e");
      Get.snackbar('Error', 'Failed to resume stream.');
    }
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    Get.snackbar(
      'Camera Error',
      'Error: ${e.code}\n${e.description ?? "No description"}',
    );
  }

  void _logError(String code, String? message) {
    talkerService.talker.error('Camera Error: $code ${message ?? ""}');
  }
}
