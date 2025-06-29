import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/presentation/controllers/tabs/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';
import 'package:uuid/uuid.dart';

class SeOverlays extends GetView<StreamelementsViewController> {
  const SeOverlays({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsService settingsService = Get.find<SettingsService>();
    Settings settings = settingsService.settings.value;
    String? overlayToken = settings.streamElementsSettings.overlayToken;
    return Column(
      children: [
        Visibility(
          visible: overlayToken == null,
          child: const Text(
            'To unlock this feature, please enter your overlay token in the settings.',
          ),
        ),
        Container(
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
                return _overlayRow(controller, overlay, context, overlayToken);
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget _overlayRow(
  StreamelementsViewController controller,
  SeOverlay overlay,
  BuildContext context,
  String? overlayToken,
) {
  final SettingsService settingsService = Get.find<SettingsService>();
  Settings settings = settingsService.settings.value;

  if (overlayToken == null) {
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
            ],
          ),
        ],
      ),
    );
  }

  bool isMuted =
      settings.streamElementsSettings.mutedOverlays.contains(overlay.id);
  String? overlayUrl;
  Widget? webpage;

  if (!isMuted) {
    overlayUrl =
        'https://streamelements.com/overlay/${overlay.id}/$overlayToken';
    var uuid = const Uuid();
    BrowserTab tab = BrowserTab(
      id: uuid.v4(),
      title: overlay.name,
      url: overlayUrl,
      toggled: true,
      iOSAudioSource: false,
    );
    webpage = WebPageView(tab);
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
            if (webpage != null)
              InkWell(
                onTap: () => {
                  Get.defaultDialog(
                    title: 'Overlay',
                    titleStyle: const TextStyle(color: Colors.white),
                    backgroundColor: const Color(0xFF0e0e10),
                    buttonColor: const Color(0xFF9147ff),
                    cancelTextColor: const Color(0xFF9147ff),
                    textCancel: "return".tr,
                    radius: 10,
                    content: SizedBox(
                      width: 384,
                      height: 216,
                      child: webpage,
                    ),
                  ),
                },
                child: const Icon(Icons.preview),
              )
            else
              Container(),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                List<String> mutedList =
                    settings.streamElementsSettings.mutedOverlays;
                if (isMuted) {
                  mutedList.removeWhere((element) => element == overlay.id);
                } else {
                  mutedList.add(overlay.id);
                }
                settingsService.settings.value = settings.copyWith(
                  streamElementsSettings: settings.streamElementsSettings
                      .copyWith(mutedOverlays: mutedList),
                );
                settingsService.saveSettings();
                controller.overlays.refresh();
              },
              child: Icon(isMuted ? Icons.volume_mute : Icons.volume_up),
            ),
          ],
        ),
      ],
    ),
  );
}
