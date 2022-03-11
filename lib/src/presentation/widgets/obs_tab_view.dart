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
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Obx(
        () => controller.isConnected.value
            ? Container(
                padding: EdgeInsets.only(left: 8, top: 10, right: 8),
                color: context.theme.primaryColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.startStream();
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 80.0,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Start stream",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            controller.stopStream();
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 80.0,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Stop stream",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            controller.startStopRecording();
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 80.0,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Start recording",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Wrap(children: [
                      Text(
                        "Scenes",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
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
                        margin: EdgeInsets.only(top: 10),
                        width: width,
                        height: 100,
                        child: getSources(),
                      ),
                    ])
                  ],
                ),
              )
            : Container(
                color: context.theme.primaryColor,
                child: Column(
                  children: [
                    AlertMessageView(
                      color: Color(0xFFEC0808),
                      message: controller.alertMessage.value,
                      isProgress: false,
                    ),
                    InkWell(
                      onTap: () {
                        controller.getSettings();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFA47CED),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Retry connection",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  getScenes() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.scenesList.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(
        width: 10,
      ),
      itemBuilder: (BuildContext context, int i) {
        var elementAt = controller.scenesList.elementAt(i);
        return InkWell(
          onTap: () {
            controller.setCurrentScene(elementAt);
          },
          child: Container(
            constraints: BoxConstraints(
              minWidth: 80.0,
              maxWidth: 120,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.currentScene == elementAt
                  ? Colors.deepPurpleAccent[200]
                  : Colors.grey[850],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: EdgeInsets.all(8),
            child: Tooltip(
              message: elementAt,
              child: Text(
                elementAt,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  getSources() {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: ScrollPhysics(),
      primary: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.5,
      ),
      itemCount: controller.sourcesList.length,
      itemBuilder: (BuildContext ctx, index) {
        var elementAt = controller.sourcesList.elementAt(index);
        return InkWell(
          onTap: () {
            controller.setSourceVisibleState(
                elementAt.name,
                controller.visibleSourcesList.contains(elementAt.name)
                    ? false
                    : true);
            controller.sourcesList.refresh();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.visibleSourcesList.contains(elementAt.name)
                  ? Colors.deepPurpleAccent[200]
                  : Colors.grey[850],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: EdgeInsets.all(8),
            child: Tooltip(
              message: elementAt.name,
              child: Text(
                elementAt.name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
