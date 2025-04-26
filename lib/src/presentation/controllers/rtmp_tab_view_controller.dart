import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:rtmp_broadcaster/camera.dart';

class RtmpTabViewController extends GetxController {
  RtmpTabViewController({
    required this.settingsService,
    required this.talkerService,
  });

  final SettingsService settingsService;
  final TalkerService talkerService;

  List<CameraDescription> cameras = [];
  CameraController? controller;
  RxBool isControllerInitialized = false.obs;
  RxBool isStreamingVideoRtmp = false.obs;
  RxString rtmpUrl = ''.obs; // TODO(LezdCS): Get from settings or dialog
  TextEditingController urlController = TextEditingController();
  Rxn<CameraDescription> selectedCamera = Rxn<CameraDescription>();

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
    // TODO(LezdCS): Load URL from settings or show dialog on stream start
    urlController.text =
        'rtmp://your_rtmp_server/live/stream_key'; // Example URL
    rtmpUrl.value = urlController.text;
  }

  @override
  void onClose() {
    controller?.dispose();
    urlController.dispose();
    super.onClose();
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
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium, // Or choose based on settings
    );

    selectedCamera.value = cameraDescription;

    try {
      await controller!.initialize();
      isControllerInitialized.value = true;
    } on CameraException catch (e) {
      _showCameraException(e);
    } catch (e) {
      talkerService.talker.error("Error initializing camera controller: $e");
      Get.snackbar('Error', 'Failed to initialize camera controller.');
      isControllerInitialized.value = false;
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

    rtmpUrl.value = urlController.text; // Update URL from text field
    if (rtmpUrl.value.isEmpty) {
      Get.snackbar('Error', 'RTMP URL is required.');
      return null;
    }

    try {
      await controller!.startVideoStreaming(rtmpUrl.value);
      isStreamingVideoRtmp.value = true;
      Get.snackbar('Success', 'Streaming started to: ${rtmpUrl.value}');
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    } catch (e) {
      talkerService.talker.error("Error starting stream: $e");
      Get.snackbar('Error', 'Failed to start stream.');
      isStreamingVideoRtmp.value = false;
      return null;
    }
    return rtmpUrl.value;
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

  Future<void> switchCamera() async {
    if (cameras.length < 2 ||
        selectedCamera.value == null ||
        controller == null) {
      Get.snackbar(
        'Info',
        'Not enough cameras available or controller not ready.',
      );
      return;
    }

    final bool wasStreaming = isStreamingVideoRtmp.value;

    try {
      // Stop streaming if it was active
      if (wasStreaming) {
        await stopVideoStreaming();
        // Small delay to allow resources to release, might help prevent surface issues
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Find the next camera
      final currentLensDirection = selectedCamera.value!.lensDirection;
      CameraDescription? newCamera;

      if (currentLensDirection == CameraLensDirection.back) {
        newCamera = cameras.firstWhereOrNull(
          (cam) => cam.lensDirection == CameraLensDirection.front,
        );
      } else {
        newCamera = cameras.firstWhereOrNull(
          (cam) => cam.lensDirection == CameraLensDirection.back,
        );
      }

      // If no opposite camera found, cycle through available ones
      if (newCamera == null) {
        int currentIndex = cameras.indexOf(selectedCamera.value!);
        int nextIndex = (currentIndex + 1) % cameras.length;
        newCamera = cameras[nextIndex];
      }

      // Switch to the new camera
      if (newCamera != selectedCamera.value) {
        // Set controller initialized to false before switching
        isControllerInitialized.value = false;
        await onNewCameraSelected(newCamera);
        // Ensure the new controller is initialized before potentially restarting stream
        // `onNewCameraSelected` already sets `isControllerInitialized.value = true` on success
        if (!isControllerInitialized.value) {
          talkerService.talker
              .warning('New camera failed to initialize after switch.');
          return; // Don't restart stream if initialization failed
        }
      } else {
        talkerService.talker.info('No different camera to switch to.');
        // If we stopped streaming but didn't actually switch, restart it.
        if (wasStreaming) {
          await startVideoStreaming();
        }
        return;
      }

      // Restart streaming if it was active before the switch
      if (wasStreaming) {
        // Add a small delay before restarting stream, sometimes helps surface availability
        await Future.delayed(const Duration(milliseconds: 100));
        await startVideoStreaming();
      }
    } catch (e, stackTrace) {
      talkerService.talker.error('Error switching camera: $e, $stackTrace');
      Get.snackbar('Error', 'Failed to switch camera.');
      // Attempt to restart streaming if it was active, although state might be uncertain
      if (wasStreaming) {
        try {
          await startVideoStreaming();
        } catch (startError) {
          talkerService.talker.error(
            'Failed to restart stream after switch error: $startError',
          );
        }
      }
    }
  }
}
