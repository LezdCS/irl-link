import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';
import 'package:irllink/src/presentation/widgets/alert_message.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsTabView extends GetView<ObsTabViewController> {
  const ObsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(
        () => controller.isConnected.value
            ? Container(
                padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
                color: context.theme.colorScheme.surface,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: controller.isStreaming.value
                                    ? "Stop stream".tr
                                    : "Start stream".tr,
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                backgroundColor: const Color(0xFF0e0e10),
                                buttonColor: const Color(0xFF9147ff),
                                cancelTextColor: const Color(0xFF9147ff),
                                textCancel: "cancel".tr,
                                textConfirm: "confirm".tr,
                                content: Column(
                                  children: [
                                    Text(
                                      "Are you sure you want to ${controller.isStreaming.value ? "stop" : "start"} stream?"
                                          .tr,
                                    ),
                                  ],
                                ),
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  controller.isStreaming.value
                                      ? controller.stopStream()
                                      : controller.startStream();
                                  Get.back();
                                },
                                radius: 10,
                              );
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minWidth: 80,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.isStreaming.value
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                controller.isStreaming.value
                                    ? "stop_stream".tr
                                    : "start_stream".tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              controller.startStopRecording();
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minWidth: 80,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.isRecording.value
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                controller.isRecording.value
                                    ? "stop_recording".tr
                                    : "start_recording".tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "preview_obs".tr,
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                backgroundColor: const Color(0xFF0e0e10),
                                buttonColor: const Color(0xFF9147ff),
                                cancelTextColor: const Color(0xFF9147ff),
                                textCancel: "return".tr,
                                radius: 10,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => ColoredBox(
                                        color: Colors.black,
                                        child: Image(
                                          image: Image.memory(
                                            controller.sceneScreenshot.value,
                                          ).image,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              controller.getSourceScreenshot(
                                controller.currentScene.value,
                              );
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minWidth: 80,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "preview_scene".tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 40,
                    ),
                    Wrap(
                      children: [
                        Row(
                          children: [
                            Text(
                              "scenes".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Obx(
                              () => IconButton(
                                onPressed: () => controller.toggleScenesOrder(),
                                icon: Icon(
                                  controller.isScenesReversed.value
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: Colors.white,
                                ),
                                tooltip: controller.isScenesReversed.value
                                    ? "Sort scenes in normal order"
                                    : "Sort scenes in reverse order",
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 40,
                          width: width,
                          child: getScenes(),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 40,
                    ),
                    Wrap(
                      children: [
                        Text(
                          "sources".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: width,
                          child: getSources(context),
                        ),
                      ],
                    ),
                    Divider(
                      height: 40,
                      thickness: 4,
                      indent: 0,
                      endIndent: 0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Column(
                      children: [
                        Text(
                          'CPU usage: ${controller.statsResponse.value?.cpuUsage.toStringAsFixed(2)}',
                        ),
                        Text(
                          'Memory usage: ${controller.statsResponse.value?.memoryUsage.toStringAsFixed(2)}',
                        ),
                        Text(
                          'Avaibalable disk space: ${controller.statsResponse.value?.availableDiskSpace.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : ColoredBox(
                color: context.theme.colorScheme.surface,
                child: Column(
                  children: [
                    alertMessage(
                      color: Theme.of(context).colorScheme.error,
                      message: controller.alertMessage.value,
                      isProgress: false,
                    ),
                    InkWell(
                      onTap: () {
                        controller.applySettings();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "retry_connection".tr,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Get.find<SettingsService>()
                          .settings
                          .value
                          .obsWebsocketUrl
                          .contains("https"),
                      child: const Text(
                        "It seems that your OBS websocket URL contains 'https', try without it.",
                        textAlign: TextAlign.center,
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
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        String elementAt = controller.scenesList.elementAt(index);
        return InkWell(
          onTap: () {
            controller.setCurrentScene(elementAt);
          },
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 80,
              maxWidth: 120,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.currentScene.value == elementAt
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.all(8),
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
      physics: const ScrollPhysics(),
      primary: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 16,
        childAspectRatio: 5 / 2,
      ),
      itemCount: controller.sourcesList.length,
      itemBuilder: (BuildContext context, int index) {
        SceneItemDetail source = controller.sourcesList.elementAt(index);
        double? sourceVolume = controller.sourcesVolumesMap[source.sourceName];
        return GestureDetector(
          onTap: () {
            controller.setSourceVisibleState(
              source.sceneItemId,
              sceneItemEnabled: source.sceneItemEnabled,
            );
          },
          onLongPress: () {
            Get.defaultDialog(
              title: source.sourceName,
              titleStyle: const TextStyle(color: Colors.white),
              backgroundColor: const Color(0xFF0e0e10),
              buttonColor: const Color(0xFF9147ff),
              cancelTextColor: const Color(0xFF9147ff),
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
                        label:
                            "${controller.sourcesVolumesMap[source.sourceName]!.toStringAsFixed(2)} dB",
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
            avatar: sourceVolume != null
                ? const Icon(
                    Icons.volume_up,
                    size: 18,
                  )
                : null,
            showCheckmark: false,
            visualDensity: VisualDensity.comfortable,
            label: SizedBox(
              width: 100,
              height: 17,
              child: Text(
                source.sourceName,
                softWrap: false,
                textAlign: TextAlign.center,
              ),
            ),
            selected: source.sceneItemEnabled,
          ),
        );
      },
    );
  }
}
