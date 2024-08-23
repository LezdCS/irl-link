import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
// import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

class SeActivitiesList extends GetView<StreamelementsViewController> {
  const SeActivitiesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _activitiesSettings(),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                controller: controller.activitiesScrollController,
                itemCount: controller.activities.length,
                itemBuilder: (BuildContext context, int index) {
                  SeActivity activity = controller
                      .activities[controller.activities.length - 1 - index];
                  return ExpandableNotifier(
                    child: Expandable(
                      collapsed: _activityCollapsed(controller, activity),
                      expanded: activity.message != ""
                          ? _activityExpanded(controller, activity)
                          : _activityCollapsed(controller, activity),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activitiesSettings() {
    return PopupMenuButton(
      offset: const Offset(30, 10),
      color: Theme.of(Get.context!).colorScheme.secondary,
      child: const Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Obx(() {
            Settings settings = Get.find<SettingsService>().settings.value;
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Followers",
              ),
              value: settings.streamElementsSettings!.showFollowerActivity,
              onChanged: (bool? value) {
                Get.find<SettingsService>().settings.value = settings.copyWith(
                  streamElementsSettings: settings.streamElementsSettings!
                      .copyWith(showFollowerActivity: value),
                );
                Get.find<SettingsService>().saveSettings();
              },
            );
          }),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = Get.find<SettingsService>().settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "Subscriptions",
                ),
                value: settings.streamElementsSettings!.showSubscriberActivity,
                onChanged: (bool? value) {
                  Get.find<SettingsService>().settings.value =
                      settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings!
                        .copyWith(showSubscriberActivity: value),
                  );
                  Get.find<SettingsService>().saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(child: Obx(
          () {
            Settings settings = Get.find<SettingsService>().settings.value;
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Bits",
              ),
              value: settings.streamElementsSettings!.showCheerActivity,
              onChanged: (bool? value) {
                Get.find<SettingsService>().settings.value = settings.copyWith(
                  streamElementsSettings: settings.streamElementsSettings!
                      .copyWith(showCheerActivity: value),
                );
                Get.find<SettingsService>().saveSettings();
              },
            );
          },
        )),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = Get.find<SettingsService>().settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "Donations",
                ),
                value: settings.streamElementsSettings!.showDonationActivity,
                onChanged: (bool? value) {
                  Get.find<SettingsService>().settings.value =
                      settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings!
                        .copyWith(showDonationActivity: value),
                  );
                  Get.find<SettingsService>().saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = Get.find<SettingsService>().settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "Raids",
                ),
                value: settings.streamElementsSettings!.showRaidActivity,
                onChanged: (bool? value) {
                  Get.find<SettingsService>().settings.value =
                      settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings!
                        .copyWith(showRaidActivity: value),
                  );
                  Get.find<SettingsService>().saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = Get.find<SettingsService>().settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "Hosts",
                ),
                value: settings.streamElementsSettings!.showHostActivity,
                onChanged: (bool? value) {
                  Get.find<SettingsService>().settings.value =
                      settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings!
                        .copyWith(showHostActivity: value),
                  );
                  Get.find<SettingsService>().saveSettings();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _activityCollapsed(
      StreamelementsViewController controller, SeActivity activity) {
    return ExpandableButton(
      child: Container(
        padding: const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: activity.colorsForEnum()[1],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            activity.getIcon(),
            const SizedBox(width: 4),
            Expanded(
              child: Text.rich(
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    TextSpan(
                      text: activity.textFromEnum(),
                      style: TextStyle(
                        color: activity.colorsForEnum()[0],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(
                      text: activity.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: activity.message != null
                          ? ' "${activity.message!}"'
                          : "",
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.replayEvent(activity);
              },
              child: const Icon(Icons.restart_alt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityExpanded(
      StreamelementsViewController controller, SeActivity activity) {
    return ExpandableButton(
      child: Container(
        padding: const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 20),
        decoration: BoxDecoration(
          color: activity.colorsForEnum()[1],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activity.getIcon(),
                const SizedBox(width: 4),
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: activity.textFromEnum(),
                        style: TextStyle(
                          color: activity.colorsForEnum()[0],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: activity.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.replayEvent(activity);
                  },
                  child: const Icon(Icons.restart_alt),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 3, right: 3, top: 10),
              child: Text(
                activity.message != null ? ' "${activity.message!}"' : "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
