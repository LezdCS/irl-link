import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';

import 'alert_message_view.dart';

class ObsTabView extends GetView<ObsTabViewController> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(() =>
      controller.isConnected.value ? Container(
        padding: EdgeInsets.only(left: 8, top: 5, right: 8),
        color: Color(0xFF282828),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // obs start stream
                    controller.startStream();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xFFA47CED),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text("Start stream",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // obs stop stream
                    controller.stopStream();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xFFA47CED),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text("Stop stream",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Wrap(children: [
              Text("Stream volume", style: TextStyle(color: Colors.white)),
              Container(
                child: Slider(
                  min: 0.0,
                  max: 100.0,
                  value: controller.slideValueForVolume.value,
                  divisions: 100,
                  label: '${controller.slideValueForVolume.value.round()}',
                  activeColor: Color(0xFFA47CED),
                  inactiveColor: Color(0xFF443B55),
                  thumbColor: Colors.purpleAccent,
                  onChanged: (value) {
                    controller.slideValueForVolume.value = value;
                  },
                ),
              ),
            ]),
            SizedBox(height: 10),
            Wrap(children: [
              Text(
                "Scenes",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                height: 60,
                width: width,
                child: getScenes(),
              ),
            ]),
            SizedBox(height: 10),
            Wrap(children: [
              Text(
                "Sources",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: width,
                height: 120,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.only(top: 5.0),
                  crossAxisCount: 2,
                  childAspectRatio: 0.60,
                  children: getSources(),
                ),
              )
            ])
          ],
        ),
      )
          : AnimatedOpacity(
        opacity: controller.isConnected.value ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1000),
        child: AlertMessageView(
          color: controller.isConnected.value
              ? Color(0xFF33A031)
              : Color(0xFFEC7508),
          message: controller.alertMessage.value,
          isProgress: !controller.isConnected.value,
        ),
      )
      ),
    );
  }

  getScenes() {
    return ListView.builder(
      itemCount: controller.scenesList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int i) {
        var elementAt = controller.scenesList.elementAt(i);
        return InkWell(
          onTap: () {
            controller.setCurrentScene(elementAt);
          },
          child: Container(
            margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
            padding: EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: controller.currentScene == elementAt
                  ? Color(0xFFA47CED)
                  : Color(0xFF443B55),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(elementAt),
          ),
        );
      },
    );
  }

  getSources() {
    return List.generate(controller.sourcesList.length, (i) {
      var elementAt = controller.sourcesList.elementAt(i);
      return InkWell(
        onTap: () {
          controller.setSourceVisibleState(elementAt.name,
              controller.visibleSourcesList.contains(elementAt.name) ? false : true
          );
        },
        child: Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: controller.visibleSourcesList.contains(elementAt.name)
                ? Color(0xFFA47CED)
                : Color(0xFF443B55),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(elementAt.name),
        ),
      );
    });
  }
}
