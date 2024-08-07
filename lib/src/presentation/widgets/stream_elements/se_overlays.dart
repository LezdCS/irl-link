import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:uuid/uuid.dart';

class SeOverlays extends GetView {
  @override
  final StreamelementsViewController controller;

  const SeOverlays({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          itemCount: controller.overlays.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
          itemBuilder: (BuildContext context, int index) {
            SeOverlay overlay = controller.overlays[index];
            return _overlayRow(controller, overlay, context);
          },
        ),
      ),
    );
  }
}

Widget _overlayRow(StreamelementsViewController controller, SeOverlay overlay,
    BuildContext context) {
  String? overlayUrl;
  Widget? webpage;
  bool isMuted = controller
      .homeViewController.settings.value.streamElementsSettings!.mutedOverlays
      .contains(overlay.id);
  if (controller.overlayToken != null && isMuted == false) {
    overlayUrl =
        'https://streamelements.com/overlay/${overlay.id}/${controller.overlayToken}';
    var uuid = const Uuid();
    webpage = WebPageView(uuid.v4() ,overlay.name, overlayUrl);
  }
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    padding: const EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 6),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(overlay.name),
            ),
            webpage != null
                ? InkWell(
                    onTap: (() => {
                          Get.defaultDialog(
                            title: 'Overlay',
                            titleStyle: const TextStyle(color: Colors.white),
                            backgroundColor: const Color(0xFF0e0e10),
                            buttonColor: const Color(0xFF9147ff),
                            cancelTextColor: const Color(0xFF9147ff),
                            textCancel: "return".tr,
                            radius: 10,
                            content: SizedBox(
                                width: 384, height: 216, child: webpage!),
                          )
                        }),
                    child: const Icon(Icons.preview),
                  )
                : Container(),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                List<String> mutedList = controller.homeViewController.settings
                    .value.streamElementsSettings!.mutedOverlays;
                if (isMuted) {
                  mutedList.removeWhere((element) => element == overlay.id);
                } else {
                  mutedList.add(overlay.id);
                }
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                        streamElementsSettings: controller.homeViewController
                            .settings.value.streamElementsSettings!
                            .copyWith(mutedOverlays: mutedList));
                controller.homeViewController.saveSettings();
                controller.overlays.refresh();
              },
              child: Icon(isMuted ? Icons.volume_mute : Icons.volume_up),
            ),
          ],
        ),
        controller.overlayToken != null
            ? SizedBox(width: 0, height: 0, child: webpage)
            : Container(),
      ],
    ),
  );
}
