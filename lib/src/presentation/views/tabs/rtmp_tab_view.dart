import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/rtmp_tab_view_controller.dart';
import 'package:rtmp_broadcaster/camera.dart';

class RtmpTabView extends GetView<RtmpTabViewController> {
  const RtmpTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isControllerInitialized.value ||
            controller.controller == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: <Widget>[
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: controller.isStreamingVideoRtmp.value
                        ? Colors.redAccent
                        : Colors.grey,
                    width: 3,
                  ),
                ),
                // AspectRatio needed to prevent distortion
                child: AspectRatio(
                  aspectRatio: controller.controller!.value.aspectRatio,
                  child: CameraPreview(controller.controller!),
                ),
              ),
            ),
            _controlRowWidget(context),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: controller.urlController,
                decoration: const InputDecoration(
                  labelText: 'RTMP URL',
                  hintText: 'rtmp://server/live/key',
                ),
                onChanged: (value) => controller.rtmpUrl.value = value,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _controlRowWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isStreamingVideoRtmp.value
                    ? Icons.stop
                    : Icons.play_arrow,
              ),
              color: Colors.blue,
              onPressed: controller.isControllerInitialized.value
                  ? (controller.isStreamingVideoRtmp.value
                      ? controller.stopVideoStreaming
                      : controller.startVideoStreaming)
                  : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.pause),
              color: Colors.blue,
              onPressed: controller.isStreamingVideoRtmp.value
                  ? controller.pauseVideoStreaming
                  : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.play_circle_outline), // Resume Icon
              color: Colors.blue,
              // TODO(LezdCS): Need state to track if paused to enable this correctly
              onPressed: controller.isStreamingVideoRtmp.value
                  ? controller.resumeVideoStreaming
                  : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.switch_camera),
            color: Colors.blue,
            onPressed: controller.isControllerInitialized.value &&
                    controller.cameras.length > 1
                ? controller.switchCamera
                : null,
          ),
        ],
      ),
    );
  }
}
