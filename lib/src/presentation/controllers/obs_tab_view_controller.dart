import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsTabViewController extends GetxController {
  ObsTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  ObsWebSocket? obsWebSocket;

  RxString alertMessage = "Failed to connect to OBS".obs;

  RxBool isConnected = false.obs;

  RxList scenesList = RxList();

  RxString currentScene = RxString("");

  RxList sourcesList = RxList();

  RxSet visibleSourcesList = RxSet();

  RxBool isRecording = false.obs;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await getSettings();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Connect to the OBS websocket at [url]
  void connectWs(String url) async {
    try {
      obsWebSocket = await ObsWebSocket.connect(
          connectUrl: 'ws://$url',
          fallbackEvent: (e) => connectionLost(e),
          onError: (e) => connectFail(e),
          timeout: Duration(seconds: 30));
      // success
      alertMessage.value = "Connected.";
      isConnected.value = true;
      getSceneList();
      getCurrentScene();
    } catch (e) {
      alertMessage.value = "Failed to connect to OBS";
      isConnected.value = false;
    }
  }

  void connectFail(e) {
    debugPrint("connectFail : connect.onError");
    debugPrint(e);
    isConnected.value = false;
    alertMessage.value = "Can't connect to OBS...";
  }

  void connectionLost(e) {
    debugPrint("connectionLost : connect.fallBackEvent");
    debugPrint(e);
    isConnected.value = false;
    alertMessage.value = "Connection with OBS lost ...";
  }

  /// Start the stream
  Future<void> startStream() async {
    final StreamStatusResponse status = await obsWebSocket!.getStreamStatus();

    if (!status.streaming) {
      await obsWebSocket!.startStreaming();
    }
  }

  /// Stop the stream
  Future<void> stopStream() async {
    final StreamStatusResponse status = await obsWebSocket!.getStreamStatus();

    if (status.streaming) {
      await obsWebSocket!.stopStreaming();
    }
  }

  /// Toggle OBS recording
  Future<void> startStopRecording() async {
    //TODO : to finish
    await obsWebSocket!.startStopRecording();
    BaseResponse? status = await obsWebSocket!.command('GetRecordingStatus');
    debugPrint(status!.rawResponse.toString());
    debugPrint(status.rawResponse['isRecording'].toString());
  }

  /// Fetch scene list
  Future<void> getSceneList() async {
    BaseResponse? response = await obsWebSocket!.command('GetSceneList');
    scenesList.clear();

    if (response!.status) {
      List respScenes = response.rawResponse["scenes"];

      for (var i = 0; i < respScenes.length; i++)
        scenesList.add(respScenes[i]["name"]);
    }
  }

  /// Fetch current scene and its sources
  /// Build a list with all visible sources
  Future<void> getCurrentScene() async {
    Scene response = await obsWebSocket!.getCurrentScene();

    currentScene.value = response.name;
    sourcesList.value = response.scenes;

    sourcesList.forEach(
        (source) => {if (source.render) visibleSourcesList.add(source.name)});
  }

  /// Switch to the scene named [sceneName]
  Future<void> setCurrentScene(String sceneName) async {
    await obsWebSocket!.setCurrentScene(sceneName);
    getCurrentScene();
  }

  /// Show or hide the source named [sourceName] according to the [value]
  void setSourceVisibleState(String sourceName, bool value) {
    obsWebSocket!.setSceneItemRender({"source": sourceName, "render": value});
    value
        ? visibleSourcesList.add(sourceName)
        : visibleSourcesList.remove(sourceName);
  }

  Future getSettings() async {
    await homeEvents.getSettings().then((value) async => {
          if (value.error == null)
            {
              settings.value = value.data!,
              this.applySettings(),
            },
        });
  }

  Future applySettings() async {
    if (obsWebSocket != null) {
      obsWebSocket!.close();
    }
    if (settings.value.isObsConnected!) {
      this.connectWs(settings.value.obsWebsocketUrl!);
    }
  }
}
