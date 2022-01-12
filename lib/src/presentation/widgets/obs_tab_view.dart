import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';

class ObsTabView extends GetView<ObsTabViewController> {
  final ObsTabViewController controller = Get.find<ObsTabViewController>();

  // selected scene id
  int selectedSceneId = -1;

  // selected scene id
  Set<int> selectedSourcesIds = new Set<int>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
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
      ),
    );
  }

  getScenes() {
    controller.getSceneList();
    // todo get from obs
    final scenesList = [
      "scene1",
      "scene2",
      "scene4",
      "scene5",
      "scene6",
      "scene7",
      "scene8",
      "scene9"
    ];

    return ListView.builder(
      itemCount: scenesList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: () {
            selectedSceneId = i;
          },
          child: Container(
            margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
            padding: EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color:
                  selectedSceneId == i ? Color(0xFFA47CED) : Color(0xFF443B55),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('${scenesList.elementAt(i)}'),
          ),
        );
      },
    );
  }

  getSources() {
    // todo get from obs
    final srcList = [
      "src1",
      "src2",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3",
      "src3"
    ];

    return List.generate(srcList.length, (i) {
      return InkWell(
        onTap: () {
          selectedSourcesIds.contains(i)
              ? selectedSourcesIds.remove(i)
              : selectedSourcesIds.add(i);
        },
        child: Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: selectedSourcesIds.contains(i)
                ? Color(0xFFA47CED)
                : Color(0xFF443B55),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('${srcList.elementAt(i)}'),
        ),
      );
    });
  }
}
