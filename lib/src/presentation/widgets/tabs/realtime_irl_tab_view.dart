import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/realtime_irl.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';

class RealtimeIrlTabView extends GetView<RealtimeIrlViewController> {
  const RealtimeIrlTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          child: controller.realtimeIrl.status.value == RtIrlStatus.updating
              ? _stopUpdatingPosition()
              : _startUpdatingPosition(),
        ),
      ),
    );
  }

  Widget _startUpdatingPosition() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Start updating position',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            controller.start();
          },
          child: const Text('Start'),
        ),
        const SizedBox(height: 10),
        const Text(
          'By clicking the button above, you will start sharing your current GPS location with RealtimeIRL.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _stopUpdatingPosition() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Stop updating position',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            controller.stop();
          },
          child: const Text('Stop'),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your GPS location is currently shared with RealtimeIRL...',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
