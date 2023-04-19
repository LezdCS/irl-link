import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';
import 'package:marquee/marquee.dart';
import 'package:obs_websocket/obs_websocket.dart';

import '../alert_message_view.dart';

class ObsTabView extends GetView<ObsTabViewController> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(
        () => controller.isConnected.value
            ? Container(
                padding: EdgeInsets.only(left: 8, top: 10, right: 8),
                color: context.theme.colorScheme.background,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListView(
                        shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isStreaming.value
                                  ? controller.stopStream()
                                  : controller.startStream();
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 80.0,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.isStreaming.value
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                controller.isStreaming.value
                                    ? "stop_stream".tr
                                    : "start_stream".tr,
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
                                color: controller.isRecording.value
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                controller.isRecording.value
                                    ? "stop_recording".tr
                                    : "start_recording".tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "preview_obs".tr,
                                titleStyle: TextStyle(color: Colors.white),
                                backgroundColor: Color(0xFF0e0e10),
                                buttonColor: Color(0xFF9147ff),
                                cancelTextColor: Color(0xFF9147ff),
                                textCancel: "return".tr,
                                radius: 10,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => Container(
                                        color: Colors.black,
                                        child: Image(
                                            image: Image.memory(controller
                                                    .sceneScreenshot.value)
                                                .image),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              controller.getSourceScreenshot(
                                  controller.currentScene.value);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 80.0,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Preview scene",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       constraints: BoxConstraints(
                    //         minWidth: 80.0,
                    //       ),
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         color:
                    //             Theme.of(context).colorScheme.tertiaryContainer,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(8),
                    //         ),
                    //       ),
                    //       padding: EdgeInsets.all(8),
                    //       child: Text(
                    //         "Show advanced stats",
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Divider(
                      height: 40,
                      thickness: 4,
                      indent: 0,
                      endIndent: 0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Wrap(children: [
                      Text(
                        "scenes".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
                        width: width,
                        child: getScenes(),
                      ),
                    ]),
                    Divider(
                      height: 40,
                      thickness: 4,
                      indent: 0,
                      endIndent: 0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Wrap(children: [
                      Text(
                        "sources".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: width,
                        child: getSources(context),
                      ),
                    ]),
                    // Divider(
                    //   height: 40,
                    //   thickness: 4,
                    //   indent: 0,
                    //   endIndent: 0,
                    //   color: Theme.of(context).colorScheme.secondary,
                    // ),
                    // Wrap(children: [
                    //   Text(
                    //     "CPU Usage",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   _cpuGraph(width),
                    // ]),
                  ],
                ),
              )
            : Container(
                color: context.theme.colorScheme.background,
                child: Column(
                  children: [
                    AlertMessageView(
                      color: Theme.of(context).colorScheme.error,
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
                          color: Theme.of(context).colorScheme.tertiary,
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
      itemBuilder: (BuildContext context, int index) {
        var elementAt = controller.scenesList.elementAt(index);
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
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.tertiaryContainer,
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

  getSources(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      primary: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 16,
        mainAxisSpacing: 0,
        childAspectRatio: 5 / 2,
      ),
      itemCount: controller.sourcesList.length,
      itemBuilder: (BuildContext context, int index) {
        SceneItemDetail source = controller.sourcesList.elementAt(index);
        double? sourceVolume = controller.sourcesVolumesMap[source.sourceName];
        return GestureDetector(
          onTap: () {
            controller.setSourceVisibleState(source);
          },
          onLongPress: () {
            Get.defaultDialog(
              title: source.sourceName,
              titleStyle: TextStyle(color: Colors.white),
              backgroundColor: Color(0xFF0e0e10),
              buttonColor: Color(0xFF9147ff),
              cancelTextColor: Color(0xFF9147ff),
              textCancel: "return".tr,
              radius: 10,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: sourceVolume != null,
                    child: Obx(
                      () => Slider(
                        value:
                            controller.sourcesVolumesMap[source.sourceName] ??
                                0,
                        onChanged: (value) {
                          controller.setInputVolume(source.sourceName, value);
                        },
                        min: -100,
                        max: 0,
                        label: controller.sourcesVolumesMap[source.sourceName]!
                                .toStringAsFixed(2) +
                            " dB",
                        divisions: 400,
                        activeColor: Theme.of(context).colorScheme.tertiary,
                        inactiveColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: ChoiceChip(
            disabledColor: Theme.of(context).colorScheme.tertiaryContainer,
            selectedColor: Theme.of(context).colorScheme.tertiary,
            avatar: sourceVolume != null
                ? Icon(
                    Icons.volume_up,
                    size: 18,
                  )
                : null,
            label: Container(
              width: 100,
              height: 17,
              child: source.sourceName.length > 12
                  ? Marquee(
                      text: source.sourceName,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 10.0,
                      velocity: 30.0,
                      startAfter: Duration(seconds: 2),
                      pauseAfterRound: Duration(seconds: 2),
                    )
                  : Text(
                      source.sourceName,
                      softWrap: false,
                      textAlign: TextAlign.center,
                    ),
            ),
            labelStyle: TextStyle(color: Colors.white),
            selected: source.sceneItemEnabled,
          ),
        );
      },
    );
  }
}
//
// Widget leftTitleWidgetsCpu(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Color(0xff75729e),
//     fontWeight: FontWeight.normal,
//     fontSize: 12,
//   );
//
//   return Container(
//     padding: const EdgeInsets.only(right: 6),
//     child: Text(value.round().toString() + "%",
//         style: style, textAlign: TextAlign.right),
//   );
// }
//
// Widget bottomTitleWidgetsHours(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Color(0xff75729e),
//     fontWeight: FontWeight.normal,
//     fontSize: 12,
//   );
//
//   return Container(
//     padding: const EdgeInsets.only(top: 6),
//     child: Text("4:30", style: style, textAlign: TextAlign.center),
//   );
// }
//
// Widget _cpuGraph(double width) {
//
//   List<FlSpot> spots = [
//     FlSpot(1, 1),
//     FlSpot(3, 20),
//     FlSpot(5, 30),
//     FlSpot(7, 30),
//     FlSpot(10, 40),
//     FlSpot(12, 29),
//     FlSpot(13, 60),
//   ];
//
//   return Container(
//     margin: EdgeInsets.only(top: 10),
//     width: width,
//     height: 200,
//     child: LineChart(
//       //TODO : https://github.com/imaNNeoFighT/fl_chart/blob/master/example/lib/line_chart/samples/line_chart_sample1.dart
//       LineChartData(
//         lineTouchData: LineTouchData(
//           handleBuiltInTouches: true,
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//           ),
//         ),
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               getTitlesWidget: leftTitleWidgetsCpu,
//               showTitles: true,
//               interval: 20,
//               reservedSize: 40,
//             ),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               getTitlesWidget: bottomTitleWidgetsHours,
//               showTitles: true,
//               interval: 9,
//               reservedSize: 40,
//             ),
//           ),
//           topTitles: AxisTitles(),
//           rightTitles: AxisTitles(),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border(
//             bottom: BorderSide(color: Color(0xff4e4965), width: 1),
//             left: BorderSide(color: Color(0xff4e4965), width: 1),
//             right: BorderSide(color: Colors.transparent),
//             top: BorderSide(color: Colors.transparent),
//           ),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             isCurved: false,
//             color: Colors.purple,
//             barWidth: 2,
//             isStrokeCapRound: true,
//             dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(show: false),
//             spots: spots,
//           ),
//         ],
//         minX: 0,
//         maxX: 60,
//         maxY: 100,
//         minY: 0,
//       ),
//     ),
//   );
// }
