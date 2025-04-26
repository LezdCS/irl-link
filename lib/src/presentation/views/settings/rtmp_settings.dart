import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/rtmp.dart';
import 'package:irllink/src/presentation/controllers/settings/rtmp_settings_controller.dart';

class RtmpSettings extends GetView<RtmpSettingsController> {
  const RtmpSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTMP Settings'),
      ),
      body: Column(
        children: [
          Obx(
            () => Column(
              children: List.from(controller.rtmpList.map((e) => Text(e.name))),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addRtmp(
                Rtmp(
                  id: 0,
                  name: 'test',
                  url: 'test',
                  key: 'test',
                  createdAt: DateTime.now(),
                ),
              );
            },
            child: const Text('Add RTMP'),
          ),
        ],
      ),
    );
  }
}
