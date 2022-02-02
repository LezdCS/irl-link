import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/domain/entities/se_activity.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';

class StreamelementsTabView extends GetView<StreamelementsViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.primaryColor,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: Colors.purple,
              unselectedLabelColor:
                  Theme.of(Get.context!).textTheme.bodyText1!.color,
              indicatorColor: Colors.purple,
              indicatorWeight: 0.000001,
              tabs: [Text("Notifications"), Text("Song Requests")],
            ),
          ],
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
        ),
        child: SafeArea(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _activities(),
              Container(
                child: Text("nop"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activities() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.settings),
              Wrap(
                children: [
                  Icon(Icons.pause),
                  Icon(Icons.play_arrow_outlined),
                  Icon(Icons.notifications_on_outlined),
                  Icon(Icons.restart_alt),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller.activitiesScrollController,
              itemCount: controller.activities.length,
              itemBuilder: (BuildContext context, int index) {
                SeActivity activity = controller
                    .activities[controller.activities.length - 1 - index];
                return Container(
                  padding:
                      EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
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
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: activity.username,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: activity.textFromEnum()),
                            ]),
                          ),
                        ],
                      ),
                      Icon(Icons.restart_alt),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
