import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsTabViewController extends GetxController {
  ObsTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  ObsWebSocket? obsWebSocket;
  RxBool isConnected = false.obs;
  RxString alertMessage = "Failed to connect to OBS".obs;

  RxList<String> scenesList = RxList();
  RxString currentScene = RxString("");

  RxList<SceneItemDetail> sourcesList = RxList();
  RxMap<String, double> sourcesVolumesMap = RxMap();

  Rx<Uint8List> sceneScreenshot = const Base64Decoder().convert("").obs;

  RxBool isStreaming = false.obs;
  RxBool isRecording = false.obs;

  Rxn<StatsResponse> statsResponse = Rxn<StatsResponse>();

  late Timer statsTimer;

  @override
  Future<void> onReady() async {
    await applySettings();

    isConnected.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendUpdateObsConnecteToNative",
        "data": value,
      });
    });

    currentScene.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendSelectedObsSceneToNative",
        "data": value,
      });
    });

    scenesList.listen((value) {
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendObsScenesToNative",
        "data": value,
      });
    });

    sourcesList.listen((value) {
      String data = jsonEncode(value.map((e) => e.toJson()).toList());
      debugPrint("sourcesList: $data");
      // Send to watchOS
      const platform = MethodChannel('com.irllink');
      platform.invokeMethod("flutterToWatch", {
        "method": "sendObsSourcesToNative",
        "data": data,
      });
    });

    super.onReady();
  }

  @override
  void onClose() {
    isConnected.value = false;
    statsTimer.cancel();
    obsWebSocket?.close();
    super.onClose();
  }

  /// Connect to the OBS websocket at [url] with optional [password]
  void connectWs(String url, String password) async {
    try {
      if (!url.startsWith('ws://') && !url.startsWith('wss://')) {
        url = 'ws://$url';
      }
      globals.talker?.logTyped(ObsLog("Connecting to OBS at $url..."));
      obsWebSocket = await ObsWebSocket.connect(
        url,
        password: password,
        onDone: connectionLost,
        timeout: const Duration(seconds: 30),
      );

      await obsWebSocket?.listen(EventSubscription.all.code);

      obsWebSocket?.addHandler<RecordStateChanged>(
          (RecordStateChanged recordingStateChanged) {
        isRecording.value = recordingStateChanged.outputActive;
      });

      obsWebSocket?.addHandler<StreamStateChanged>(
          (StreamStateChanged streamStateChanged) {
        isStreaming.value = streamStateChanged.outputActive;
      });

      obsWebSocket?.addHandler<SceneItemEnableStateChanged>(
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

      obsWebSocket?.addFallbackListener((Event event) {
        switch (event.eventType) {
          case 'CurrentProgramSceneChanged':
            getCurrentScene();
            break;
          case 'InputVolumeChanged':
            sourcesVolumesMap[event.eventData?['inputName']] =
                event.eventData?['inputVolumeDb'];
            sourcesList.refresh();
            sourcesVolumesMap.refresh();
            break;
          case 'SceneListChanged':
            getSceneList();
            break;
          case 'SceneItemCreated':
            getCurrentScene();
            break;
          case 'SceneItemRemoved':
            getCurrentScene();
            break;
          case 'InputNameChanged':
            getCurrentScene();
            break;
        }
      });

      alertMessage.value = "Connected.";
      isConnected.value = true;
      Settings settings = Get.find<SettingsService>().settings.value;

      List obsConnectionsHistory = settings.obsConnectionsHistory;
      if (obsConnectionsHistory.firstWhereOrNull(
            (element) =>
                element['url'] == url && element['password'] == password,
          ) ==
          null) {
        obsConnectionsHistory.add({
          "url": url,
          "password": password,
        });

        settings =
            settings.copyWith(obsConnectionsHistory: obsConnectionsHistory);
        Get.find<SettingsService>().saveSettings();
      }

      getSceneList();
      getCurrentScene();

      final StreamStatusResponse streamStatus =
          await obsWebSocket!.stream.getStatus;
      isStreaming.value = streamStatus.outputActive;

      final RecordStatusResponse recordStatus =
          await obsWebSocket!.record.getRecordStatus();
      isRecording.value = recordStatus.outputActive;

      statsResponse.value = await obsWebSocket!.general.getStats();
      statsTimer = Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) async {
          statsResponse.value = await obsWebSocket!.general.getStats();
        },
      );
    } catch (e) {
      alertMessage.value = "Failed to connect to OBS";
      isConnected.value = false;
    }
  }

  void connectionLost() {
    globals.talker?.error("Connection lost with OBS.");
    statsTimer.cancel();
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
    for (var source in sources) {
      var response = await obsWebSocket!.send(
          "GetInputVolume", {"inputName": source.sourceName}).catchError((e) {
        return null;
      });
      if (response?.requestStatus.code == 100) {
        sourcesVolumesMap[source.sourceName] =
            response?.responseData?['inputVolumeDb'];
      }
    }
  }

  /// Switch to the scene named [sceneName]
  Future<void> setCurrentScene(String sceneName) async {
    await obsWebSocket!.scenes.setCurrentProgramScene(sceneName);
  }

  /// Show or hide the source named [sourceName] according to the [sceneItemEnabled]
  void setSourceVisibleState(int sceneItemId, bool sceneItemEnabled) {
    obsWebSocket!.sceneItems.setEnabled(
      SceneItemEnableStateChanged(
        sceneName: currentScene.value,
        sceneItemId: sceneItemId,
        sceneItemEnabled: !sceneItemEnabled,
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
    sceneScreenshot.value = const Base64Decoder().convert(imageBase64);
  }

  Future applySettings() async {
    Settings settings = Get.find<SettingsService>().settings.value;

    if (obsWebSocket != null) {
      obsWebSocket!.close();
    }
    if (settings.isObsConnected) {
      connectWs(settings.obsWebsocketUrl, settings.obsWebsocketPassword);
    }
  }
}
