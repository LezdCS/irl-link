import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:haishin_kit/stream_view_texture.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/presentation/controllers/tabs/rtmp_tab_view_controller.dart';

class RtmpTabView extends GetView<RtmpTabViewController> {
  const RtmpTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final isReady = controller.isStreamReady.value;
        // final isStreaming = controller.isStreamingVideoRtmp.value;
        // final currentStream = controller.stream.value;

        // if (!isReady || currentStream == null) {
        if (!isReady) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     border: Border.all(
              //       color: isStreaming ? Colors.redAccent : Colors.grey,
              //       width: 3,
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(3),
              //     child: AspectRatio(
              //       aspectRatio: 16 / 9,
              //       child: StreamViewTexture(
              //         currentStream,
              //         key: ValueKey(
              //           '${currentStream.hashCode}_${controller.currentPosition.value}_${controller.isStreamingVideoRtmp.value}',
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              _controlRowWidget(context),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    _rtmpSelectorDropdown(),
                  ],
                ),
              ),
            ],
          ),
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
                controller.selectedRtmp.value = newValue;
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
              onPressed: controller.isStreamReady.value
                  ? (controller.isStreamingVideoRtmp.value
                      ? controller.stopVideoStreaming
                      : controller.startVideoStreaming)
                  : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.cameraswitch),
              color: Colors.blue,
              onPressed: controller.isStreamReady.value
                  ? controller.switchCamera
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
