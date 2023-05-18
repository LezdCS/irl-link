import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

import '../../../domain/entities/se_activity.dart';

class SeActivitiesList extends GetView {
  final StreamelementsViewController controller;

  SeActivitiesList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 0),
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
    List<String> settingsValues = [
      "Followers",
      "Subscribers",
      "Donations",
      "Bits",
      "Raids",
      "Hosts",
      "Merch",
    ];
    return PopupMenuButton(
      offset: Offset(30, 10),
      color: Theme.of(Get.context!).colorScheme.secondary,
      child: Icon(Icons.settings),
      itemBuilder: (context) => List.generate(settingsValues.length, (index) {
        return PopupMenuItem(
          child: CheckboxListTile(
            activeColor: Colors.deepPurple[600],
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              settingsValues[index],
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            value: true,
            onChanged: (bool? value) {},
          ),
        );
      }),
    );
  }
}

Widget _activityCollapsed(StreamelementsViewController controller, SeActivity activity) {
  return ExpandableButton(
    child: Container(
      padding: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: activity.colorsForEnum()[0],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: activity.colorsForEnum()[1],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: activity.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: activity.textFromEnum()),
                  TextSpan(
                    text: activity.message != null
                        ? ' "' + activity.message! + '"'
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
            child: Icon(Icons.restart_alt),
          ),
        ],
      ),
    ),
  );
}

Widget _activityExpanded( StreamelementsViewController controller ,SeActivity activity) {
  return ExpandableButton(
    child: Container(
      padding: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 20),
      decoration: BoxDecoration(
        color: activity.colorsForEnum()[0],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: activity.colorsForEnum()[1],
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: activity.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: activity.textFromEnum()),
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.replayEvent(activity);
                },
                child: Icon(Icons.restart_alt),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 3, right: 3, top: 10),
            child: Text(
              activity.message != null ? ' "' + activity.message! + '"' : "",
            ),
          ),
        ],
      ),
    ),
  );
}
