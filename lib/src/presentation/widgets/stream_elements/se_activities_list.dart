import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
// import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

class SeActivitiesList extends GetView {
  @override
  final StreamelementsViewController controller;

  const SeActivitiesList({
    super.key,
    required this.controller,
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
          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: controller.overlays.length,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (BuildContext context, int index) {
          //         SeOverlay overlay = controller
          //             .overlays[controller.overlays.length - 1 - index];
          //         return TextButton(
          //           child: Text(overlay.name),
          //           onPressed: () => {},
          //         );
          //       },
          //     ),
          //   ),
          // ),
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
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Followers",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showFollowerActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showFollowerActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Subscriptions",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showSubscriberActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showSubscriberActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Bits",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showCheerActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showCheerActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Donations",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showDonationActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showDonationActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Raids",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showRaidActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showRaidActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Hosts",
              ),
              value: controller.homeViewController.settings.value
                  .streamElementsSettings!.showHostActivity,
              onChanged: (bool? value) {
                controller.homeViewController.settings.value =
                    controller.homeViewController.settings.value.copyWith(
                  streamElementsSettings: controller
                      .homeViewController.settings.value.streamElementsSettings!
                      .copyWith(showHostActivity: value),
                );
                controller.homeViewController.homeEvents.setSettings(
                  settings: controller.homeViewController.settings.value,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
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
