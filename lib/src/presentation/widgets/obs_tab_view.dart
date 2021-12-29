import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ObsTabView extends GetView {

  // stream viewer count
  double _volume = 50;

  // selected scene id
  int selectedSceneId = -1;

  // selected scene id
  Set<int> selectedSourcesIds = new Set<int>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  // todo obs start stream
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    color: Color(0xFFA47CED),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("Start stream"),
                ),
              ),
              InkWell(
                onTap: () {
                  // todo obs stop stream
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    color: Color(0xFFA47CED),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("Stop stream"),
                ),
              )
            ],
          ),
          Text("Stream volume"),
          Slider(
            min: 0.0,
            max: 100.0,
            value: _volume,
            divisions: 5,
            label: '${_volume.round()}',
            activeColor: Color(0xFFA47CED),
            inactiveColor: Color(0xFF443B55),
            thumbColor: Colors.purpleAccent,
            onChanged: (value) {
              _volume = value;
            },
          ),
          Text("Scenes"),
          ListView(
              scrollDirection: Axis.horizontal,
              children: getScenes()
          ),
          Text("Sources"),
          GridView.count(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            padding: EdgeInsets.only(top: 15.0),
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            mainAxisSpacing: 0.2,
            crossAxisSpacing: 4.0,
            children: getSources(),
          )
        ],
      ),
    );
  }

  getScenes() {
    // todo get from obs
    final scenesList = ["scene1", "scene2", "scene3"];

    return List.generate(scenesList.length, (i) {
          return InkWell(
            onTap: () {
              selectedSceneId = i;
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: selectedSceneId == i ? Color(0xFFA47CED) : Color(0xFF443B55),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('${scenesList.elementAt(i)}'),
            ),
          );
    });
  }

  getSources() {
    // todo get from obs
    final srcList = ["src1", "src2", "src3"];

    return List.generate(srcList.length, (i){
          return InkWell(
            onTap: () {
              selectedSourcesIds.contains(i)
                  ? selectedSourcesIds.remove(i)
                  : selectedSourcesIds.add(i);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: selectedSourcesIds.contains(i) ? Color(0xFFA47CED) : Color(0xFF443B55),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('${srcList.elementAt(i)}'),
            ),
          );
    });
  }
}
