import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
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
              child: Column(
                children: [
                  _rtmpSelectorDropdown(),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.urlController,
                    decoration: const InputDecoration(
                      labelText: 'RTMP URL',
                      hintText: 'rtmp://server/live/key',
                    ),
                    onChanged: (value) => controller.rtmpUrl.value = value,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  // RTMP selector dropdown
  Widget _rtmpSelectorDropdown() {
    return Obx(() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Rtmp>(
            value: controller.selectedRtmp.value,
            hint: const Text('Select RTMP Server'),
            isExpanded: true,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onChanged: (Rtmp? newValue) {
              if (newValue != null) {
                controller.updateSelectedRtmp(newValue);
              }
            },
            items: controller.rtmpList.map<DropdownMenuItem<Rtmp>>((Rtmp rtmp) {
              return DropdownMenuItem<Rtmp>(
                value: rtmp,
                child: Text(rtmp.name),
              );
            }).toList(),
          ),
        ),
      );
    });
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
          // Obx(
          //   () => IconButton(
          //     icon: const Icon(Icons.pause),
          //     color: Colors.blue,
          //     onPressed: controller.isStreamingVideoRtmp.value
          //         ? controller.pauseVideoStreaming
          //         : null,
          //   ),
          // ),
          // Obx(
          //   () => IconButton(
          //     icon: const Icon(Icons.play_circle_outline), // Resume Icon
          //     color: Colors.blue,
          //     // TODO(LezdCS): Need state to track if paused to enable this correctly
          //     onPressed: controller.isStreamingVideoRtmp.value
          //         ? controller.resumeVideoStreaming
          //         : null,
          //   ),
          // ),
          _cameraSelectorDropdown(),
        ],
      ),
    );
  }

  // New widget for the camera selector dropdown
  Widget _cameraSelectorDropdown() {
    return Obx(() {
      // Disable dropdown if controller is not initialized or less than 2 cameras
      bool isEnabled = controller.isControllerInitialized.value &&
          controller.cameras.length > 1;

      // Ensure selected camera is in the list of available cameras
      CameraDescription? currentSelection = controller.selectedCamera.value;
      if (currentSelection != null &&
          !controller.cameras
              .any((cam) => cam.name == currentSelection?.name)) {
        currentSelection = null; // Reset if selected camera is not available
      }

      // If no valid selection or only one camera, default to the first camera if available
      if (currentSelection == null && controller.cameras.isNotEmpty) {
        currentSelection = controller.cameras.first;
      }

      return DropdownButton<CameraDescription>(
        value: currentSelection, // Use the potentially updated selection
        // Hint displayed when no item is selected (though we try to default)
        hint: const Text('Select Camera'),
        // Disable the dropdown visually and functionally if not enabled
        onChanged: isEnabled
            ? (CameraDescription? newValue) {
                if (newValue != null) {
                  controller.onNewCameraSelected(newValue);
                }
              }
            : null,
        items: controller.cameras.map<DropdownMenuItem<CameraDescription>>(
            (CameraDescription camera) {
          return DropdownMenuItem<CameraDescription>(
            value: camera,
            // Display camera name and direction
            child: Text(
              '${camera.name} (${camera.lensDirection?.name ?? 'Unknown'})',
            ),
          );
        }).toList(),
        // Style the dropdown button
        icon: const Icon(Icons.camera_alt),
        underline: Container(), // Remove the default underline
      );
    });
  }
}
