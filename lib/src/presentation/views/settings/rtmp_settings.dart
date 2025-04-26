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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: List.from(
                  controller.rtmpList.map(
                    (e) => Dismissible(
                      key: Key(e.id.toString()),
                      onDismissed: (direction) {
                        controller.deleteRtmp(e.id);
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            Text(
                              'delete'.tr,
                            ),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(e.name),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _addRtmpButton(context, controller),
        ],
      ),
    );
  }
}

Widget _addDialog(
  BuildContext context,
  RtmpSettingsController controller,
) {
  return Column(
    spacing: 10,
    children: [
      TextField(
        controller: controller.nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
      ),
      TextField(
        controller: controller.urlController,
        decoration: const InputDecoration(
          labelText: 'URL',
        ),
      ),
      TextField(
        controller: controller.keyController,
        decoration: const InputDecoration(
          labelText: 'Key',
        ),
      ),
    ],
  );
}

Widget _addRtmpButton(
  BuildContext context,
  RtmpSettingsController controller,
) {
  return InkWell(
    onTap: () {
      Get.defaultDialog(
        content: _addDialog(context, controller),
        title: "add".tr,
        textCancel: "cancel".tr,
        textConfirm: "add".tr,
        backgroundColor: Theme.of(context).colorScheme.surface,
        buttonColor: const Color(0xFF9147ff),
        cancelTextColor: const Color(0xFF9147ff),
        confirmTextColor: Colors.white,
        radius: 10,
        onConfirm: () {
          controller.addRtmp(
            Rtmp(
              id: 0,
              name: controller.nameController.text,
              url: controller.urlController.text,
              key: controller.keyController.text,
              createdAt: DateTime.now(),
            ),
          );
          controller.nameController.clear();
          controller.urlController.clear();
          controller.keyController.clear();
          Get.back();
        },
      );
    },
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('New RTMP target'),
          Icon(Icons.add),
        ],
      ),
    ),
  );
}
