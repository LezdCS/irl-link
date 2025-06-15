import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/presentation/controllers/tabs/streamelements_view_controller.dart';

class SeActivitiesList extends GetView<StreamelementsViewController> {
  const SeActivitiesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
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
    final SettingsService settingsService = Get.find<SettingsService>();
    return PopupMenuButton(
      offset: const Offset(30, 10),
      color: Theme.of(Get.context!).colorScheme.secondary,
      child: const Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Obx(() {
            StreamElementsSettings? seSettings =
                settingsService.settings.value.streamElementsSettings;
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "followers".tr,
              ),
              value: seSettings.showFollowerActivity,
              onChanged: (bool? value) {
                settingsService.settings.value =
                    settingsService.settings.value.copyWith(
                  streamElementsSettings:
                      seSettings.copyWith(showFollowerActivity: value),
                );
                settingsService.saveSettings();
              },
            );
          }),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = settingsService.settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "subscriptions".tr,
                ),
                value: settings.streamElementsSettings.showSubscriberActivity,
                onChanged: (bool? value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(showSubscriberActivity: value),
                  );
                  settingsService.saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = settingsService.settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "bits".tr,
                ),
                value: settings.streamElementsSettings.showCheerActivity,
                onChanged: (bool? value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(showCheerActivity: value),
                  );
                  settingsService.saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = settingsService.settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "donations".tr,
                ),
                value: settings.streamElementsSettings.showDonationActivity,
                onChanged: (bool? value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(showDonationActivity: value),
                  );
                  settingsService.saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = settingsService.settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "raids".tr,
                ),
                value: settings.streamElementsSettings.showRaidActivity,
                onChanged: (bool? value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(showRaidActivity: value),
                  );
                  settingsService.saveSettings();
                },
              );
            },
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () {
              Settings settings = settingsService.settings.value;
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "hosts".tr,
                ),
                value: settings.streamElementsSettings.showHostActivity,
                onChanged: (bool? value) {
                  settingsService.settings.value = settings.copyWith(
                    streamElementsSettings: settings.streamElementsSettings
                        .copyWith(showHostActivity: value),
                  );
                  settingsService.saveSettings();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _activityCollapsed(
    StreamelementsViewController controller,
    SeActivity activity,
  ) {
    String? badge;
    switch (activity.provider) {
      case StreamProvider.twitch:
        badge = "lib/assets/twitch/twitch_logo.png";
      case StreamProvider.youtube:
        badge = "lib/assets/youtube/youtubeLogo.png";
      case StreamProvider.facebook:
        badge = null;
    }
    return ExpandableButton(
      child: Container(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: activity.colorsForEnum()[1],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            if (badge != null)
              Image(
                width: 18,
                height: 18,
                image: AssetImage(badge),
              ),
            activity.getIcon(),
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
    StreamelementsViewController controller,
    SeActivity activity,
  ) {
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
