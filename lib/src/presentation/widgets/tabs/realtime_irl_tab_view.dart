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
        () => Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: controller.realtimeIrl.status.value == RtIrlStatus.updating
                  ? _stopUpdatingPosition(
                      title: 'Stop updating position',
                      description:
                          'Your GPS location is currently shared with RealtimeIRL...')
                  : _startUpdatingPosition(),
            ),
            Visibility(
              visible:
                  controller.realtimeIrl.status.value == RtIrlStatus.stopped,
              child: Column(
                children: [
                  const Divider(),
                  _stopUpdatingPosition(
                      title: 'Emergency stop',
                      description:
                          'In case your location is still visible on RealtimeIRL, you can stop the service immediately.'),
                ],
              ),
            ),
          ],
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

  Widget _stopUpdatingPosition(
      {required String title, required String description}) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
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
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
