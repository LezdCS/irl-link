import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:obs_websocket/obs_websocket.dart';

import 'home_view_controller.dart';

class ObsTabViewController extends GetxController {
  ObsTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  ObsWebSocket? obsWebSocket;
  RxBool isConnected = false.obs;
  RxString alertMessage = "Failed to connect to OBS".obs;

  RxList scenesList = RxList();
  RxString currentScene = RxString("");

  RxList<SceneItemDetail> sourcesList = RxList();
  RxMap<String, double> sourcesVolumesMap = RxMap();

  Rx<Uint8List> sceneScreenshot = Base64Decoder().convert("").obs;

  RxBool isStreaming = false.obs;
  RxBool isRecording = false.obs;

  RxMap<Map, DateTime> obsData = <Map, DateTime>{}.obs;

  late HomeViewController homeViewController;

  @override
  void onInit() {
    obsData[{}] = DateTime.now();
    homeViewController = Get.find<HomeViewController>();

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await applySettings();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Connect to the OBS websocket at [url] with optional [password]
  void connectWs(String url, String password) async {
    try {
      obsWebSocket = await ObsWebSocket.connect(
        'ws://$url',
        password: password,
        onDone: connectionLost,
        timeout: Duration(seconds: 30),
      );

      await obsWebSocket!.listen(EventSubscription.all.code);

      obsWebSocket!.addHandler<RecordStateChanged>(
          (RecordStateChanged recordingStateChanged) {
        isRecording.value = recordingStateChanged.outputActive;
      });

      obsWebSocket!.addHandler<StreamStateChanged>(
          (StreamStateChanged streamStateChanged) {
        isStreaming.value = streamStateChanged.outputActive;
      });

      obsWebSocket!.addHandler<SceneItemEnableStateChanged>(
          (SceneItemEnableStateChanged sceneItemEnableStateChanged) {
        SceneItemDetail s = sourcesList.firstWhere((source) =>
            source.sceneItemId == sceneItemEnableStateChanged.sceneItemId);

        Map<String, dynamic> srcJson = s.toJson();
        srcJson['sceneItemTransform'] = srcJson['sceneItemTransform'].toJson();
        srcJson['sceneItemEnabled'] =
            sceneItemEnableStateChanged.sceneItemEnabled;
        SceneItemDetail updatedSource = SceneItemDetail.fromJson(srcJson);
        sourcesList[sourcesList.indexOf(s)] = updatedSource;
      });

      obsWebSocket!.addFallbackListener((Event event) {
        if (event.eventType == 'CurrentProgramSceneChanged') {
          getCurrentScene();
        }
        if (event.eventType == 'InputVolumeChanged') {
          sourcesVolumesMap[event.eventData?['inputName']] =
              event.eventData?['inputVolumeDb'];
          sourcesList.refresh();
          sourcesVolumesMap.refresh();
        }
        if (event.eventType == 'SceneListChanged') {
          getSceneList();
        }
        if (event.eventType == 'SceneItemCreated') {
          getCurrentScene();
        }
        if (event.eventType == 'SceneItemRemoved') {
          getCurrentScene();
        }
        if (event.eventType == 'InputNameChanged') {
          getCurrentScene();
        }
      });

      alertMessage.value = "Connected.";
      isConnected.value = true;

      List obsConnectionsHistory = homeViewController.settings.value.obsConnectionsHistory!;
      if (obsConnectionsHistory.firstWhereOrNull(
            (element) =>
                element['url'] == url && element['password'] == password,
          ) ==
          null) {
        obsConnectionsHistory.add({
          "url": url,
          "password": password,
        });

        homeViewController.settings.value = homeViewController.settings.value
            .copyWith(obsConnectionsHistory: obsConnectionsHistory);
        homeEvents.setSettings(settings: homeViewController.settings.value);
      }

      getSceneList();
      getCurrentScene();

      final StreamStatusResponse streamStatus =
          await obsWebSocket!.stream.getStatus;
      isStreaming.value = streamStatus.outputActive;

      final RecordStatusResponse recordStatus =
          await obsWebSocket!.record.getRecordStatus();
      isRecording.value = recordStatus.outputActive;

      final StatsResponse statsResponse =
          await obsWebSocket!.general.getStats();
      debugPrint(statsResponse.toString());
    } catch (e) {
      alertMessage.value = "Failed to connect to OBS";
      isConnected.value = false;
    }
  }

  void connectionLost() {
    debugPrint("connectionLost");
    isConnected.value = false;
    alertMessage.value = "Connection with OBS lost...";
  }

  /// Start the stream
  Future<void> startStream() async {
    final StreamStatusResponse status = await obsWebSocket!.stream.getStatus;

    if (!status.outputActive) {
      await obsWebSocket!.stream.startStream();
    }
  }

  /// Stop the stream
  Future<void> stopStream() async {
    final StreamStatusResponse status = await obsWebSocket!.stream.getStatus;

    if (status.outputActive) {
      await obsWebSocket!.stream.stopStream();
    }
  }

  /// Toggle OBS recording
  Future<void> startStopRecording() async {
    await obsWebSocket!.record.toggleRecord();
  }

  /// Fetch scene list
  Future<void> getSceneList() async {
    SceneListResponse? response = await obsWebSocket!.scenes.getSceneList();
    scenesList.clear();

    List<Scene> respScenes = response.scenes;

    for (var i = 0; i < respScenes.length; i++) {
      scenesList.add(respScenes[i].sceneName);
    }
  }

  /// Fetch current scene and its sources
  Future<void> getCurrentScene() async {
    String currentSceneName =
        await obsWebSocket!.scenes.getCurrentProgramScene();

    currentScene.value = currentSceneName;

    List<SceneItemDetail> sources =
        await obsWebSocket!.sceneItems.getSceneItemList(currentSceneName);
    sourcesList.value = sources;
    sourcesVolumesMap.clear();
    sources.forEach((source) async {
      var response = await obsWebSocket!.send("GetInputVolume",
          {"inputName": source.sourceName}).catchError((e) {});
      if (response?.requestStatus.code == 100) {
        sourcesVolumesMap[source.sourceName] =
            response?.responseData?['inputVolumeDb'];
      }
    });
  }

  /// Switch to the scene named [sceneName]
  Future<void> setCurrentScene(String sceneName) async {
    await obsWebSocket!.scenes.setCurrentProgramScene(sceneName);
  }

  /// Show or hide the source named [sourceName] according to the [sceneItemEnabled]
  void setSourceVisibleState(SceneItemDetail source) {
    obsWebSocket!.sceneItems.setEnabled(
      SceneItemEnableStateChanged(
        sceneName: currentScene.value,
        sceneItemId: source.sceneItemId,
        sceneItemEnabled: !source.sceneItemEnabled,
      ),
    );
  }

  void setInputVolume(String inputName, double inputVolumeDb) {
    obsWebSocket!.send("SetInputVolume",
        {"inputName": inputName, "inputVolumeDb": inputVolumeDb});
    sourcesList.refresh();
    sourcesVolumesMap.refresh();
  }

  void getSourceScreenshot(String sourceName) async {
    var response = await obsWebSocket!.send("GetSourceScreenshot",
        {"sourceName": sourceName, "imageFormat": "png"});

    String imageBase64 = response?.responseData?['imageData'].split(",").last;
    sceneScreenshot.value = Base64Decoder().convert(imageBase64);
  }

  Future applySettings() async {
    if (obsWebSocket != null) {
      obsWebSocket!.close();
    }
    if (homeViewController.settings.value.isObsConnected!) {
      this.connectWs(homeViewController.settings.value.obsWebsocketUrl!,
          homeViewController.settings.value.obsWebsocketPassword!);
    }
  }
}
