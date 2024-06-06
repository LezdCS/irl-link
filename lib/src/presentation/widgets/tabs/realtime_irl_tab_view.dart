import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/realtime_irl.dart';
import 'package:irllink/src/presentation/controllers/realtime_irl_view_controller.dart';

class RealtimeIrlTabView extends GetView<RealtimeIrlViewController> {
  const RealtimeIrlTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: controller.realtimeIrl.status == RtIrlStatus.updating
            ? _stopUpdatingPosition()
            : _startUpdatingPosition(),
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
          onPressed: () {
            controller.start();
          },
          child: const Text('Start'),
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
          onPressed: () {
            controller.stop();
          },
          child: const Text('Stop'),
        ),
      ],
    );
  }
}
