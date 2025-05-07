import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/av_capture_session_preset.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/domain/usecases/rtmp/get_rtmp_list_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

class RtmpTabViewController extends GetxController {
  RtmpTabViewController({
    required this.settingsService,
    required this.talkerService,
    required this.getRtmpListUseCase,
  });

  final SettingsService settingsService;
  final TalkerService talkerService;
  final GetRtmpListUseCase getRtmpListUseCase;

  RtmpConnection? _connection;
  final Rxn<RtmpStream> stream = Rxn<RtmpStream>();
  StreamSubscription? _connectionSubscription;
  final Rx<CameraPosition> currentPosition = Rx(CameraPosition.back);

  RxBool isStreamingVideoRtmp = false.obs;
  RxBool isStreamReady = false.obs;
  TextEditingController urlController = TextEditingController();
  RxList<Rtmp> rtmpList = <Rtmp>[].obs;
  Rxn<Rtmp> selectedRtmp = Rxn<Rtmp>();

  @override
  void onInit() {
    super.onInit();
    _initializeStreaming();
    getRtmpList();
  }

  @override
  void onClose() {
    _connectionSubscription?.cancel();
    _connection?.close();
    stream.value?.dispose();
    urlController.dispose();
    super.onClose();
  }

  Future<void> getRtmpList() async {
    final result = await getRtmpListUseCase();
    result.fold(
      (l) => talkerService.talker.error(l.toString()),
      (r) {
        rtmpList.clear();
        selectedRtmp.value = null;
        rtmpList.value = r;
        if (rtmpList.isNotEmpty && selectedRtmp.value == null) {
          selectedRtmp.value = rtmpList.first;
        }
      },
    );
  }

  Future<void> addTemporaryRtmp(Rtmp rtmp) async {
    rtmpList.add(rtmp);
    selectedRtmp.value = rtmp;
  }

  Future<void> _initializeStreaming() async {
    try {
      await Permission.camera.request();
      await Permission.microphone.request();

      _connection = await RtmpConnection.create();
      _connectionSubscription =
          _connection?.eventChannel.receiveBroadcastStream().listen((event) {
        talkerService.talker.debug("RtmpConnection event: $event");
        switch (event["data"]["code"]) {
          case 'NetConnection.Connect.Success':
            _publishStream();
          case 'NetConnection.Connect.Closed':
          case 'NetConnection.Connect.Failed':
            isStreamingVideoRtmp.value = false;
            Get.snackbar('Info', 'Connection closed or failed.');
        }
      });

      stream.value = await RtmpStream.create(_connection!);
      stream.value?.audioSettings = AudioSettings(bitrate: 64 * 1000);
      stream.value?.videoSettings = VideoSettings(
        height: 1080,
        width: 1920,
        bitrate: 2700 * 1000,
        profileLevel: ProfileLevel.h264HighAutoLevel,
      );
      stream.value?.sessionPreset = AVCaptureSessionPreset.high;
      await stream.value
          ?.attachVideo(VideoSource(position: currentPosition.value));
      await stream.value?.attachAudio(AudioSource());

      isStreamReady.value = true;
    } catch (e) {
      talkerService.talker.error("Error initializing HaishinKit: $e");
      Get.snackbar(
        'Error',
        'An unexpected error occurred during initialization.',
      );
      isStreamingVideoRtmp.value = false;
      isStreamReady.value = false;
    }
  }

  Future<void> switchCamera() async {
    final newPosition = currentPosition.value == CameraPosition.back
        ? CameraPosition.front
        : CameraPosition.back;

    try {
      await stream.value?.attachVideo(VideoSource(position: newPosition));
      currentPosition.value = newPosition;
      talkerService.talker.debug("Switched camera to $newPosition");
    } catch (e) {
      talkerService.talker.error("Error switching camera: $e");
      Get.snackbar('Error', 'Failed to switch camera.');
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> startVideoStreaming() async {
    if (_connection == null || stream.value == null) {
      Get.snackbar('Error', 'Streaming components not initialized.');
      return;
    }

    if (isStreamingVideoRtmp.value) {
      Get.snackbar('Info', 'Already streaming.');
      return;
    }

    final rtmpConfig = selectedRtmp.value;
    if (rtmpConfig == null) {
      talkerService.talker
          .error("Cannot start stream: No RTMP configuration selected.");
      Get.snackbar('Error', 'Please select an RTMP destination.');
      return;
    }
    final baseUrl = rtmpConfig.url;

    if (baseUrl.isEmpty) {
      talkerService.talker
          .error("Cannot start stream: RTMP base URL is null or empty.");
      Get.snackbar('Error', 'RTMP configuration is missing a URL.');
      return;
    }

    talkerService.talker.debug("RTMP Base URL: $baseUrl");

    try {
      _connection?.connect(baseUrl);
    } catch (e) {
      talkerService.talker.error("Error connecting to RTMP server: $e");
      Get.snackbar('Error', 'Failed to connect to RTMP server.');
      isStreamingVideoRtmp.value = false;
    }
  }

  Future<void> _publishStream() async {
    final rtmpConfig = selectedRtmp.value;
    final streamKey = rtmpConfig?.key;

    if (streamKey == null || streamKey.isEmpty) {
      talkerService.talker
          .error("Cannot publish stream: RTMP stream key is null or empty.");
      Get.snackbar('Error', 'RTMP configuration is missing a stream key.');
      await stopVideoStreaming();
      return;
    }

    try {
      await stream.value?.publish(streamKey);
      isStreamingVideoRtmp.value = true;
      Get.snackbar(
        'Success',
        'Streaming started to ${rtmpConfig?.url}',
      );
      talkerService.talker.debug("Streaming published with key: $streamKey");
    } catch (e) {
      talkerService.talker.error("Error publishing stream: $e");
      Get.snackbar('Error', 'Failed to publish stream.');
      isStreamingVideoRtmp.value = false;
      _connection?.close();
    }
  }

  Future<void> stopVideoStreaming() async {
    try {
      _connection?.close();
      Get.snackbar('Success', 'Streaming stopped.');
      talkerService.talker.debug("Streaming stopped via connection close.");
      isStreamingVideoRtmp.value = false;
    } catch (e) {
      talkerService.talker
          .error("Error stopping stream (closing connection): $e");
      Get.snackbar('Error', 'Failed to stop stream.');
      isStreamingVideoRtmp.value = false;
    }
  }
}
