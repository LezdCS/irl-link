import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';

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

Widget _overlayRow(StreamelementsViewController controller,
    SeOverlay overlay, BuildContext context) {
  String overlayUrl =
      'https://streamelements.com/overlay/${overlay.id}/${controller.overlayToken}';
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
            InkWell(
              onTap: (() => {}),
              child: Icon(Icons.preview),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: (() => {}),
              child: Icon(Icons.volume_up),
            ),
          ],
        ),
        Visibility(
          visible: false,
          child: WebPageView(overlay.name, overlayUrl),
        ),
      ],
    ),
  );
}
