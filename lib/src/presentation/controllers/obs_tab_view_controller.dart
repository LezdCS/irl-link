import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsTabViewController extends GetxController {
  ObsTabViewController({required this.homeEvents});

  final HomeEvents homeEvents;

  ObsWebSocket? obsWebSocket;
  RxBool isConnected = false.obs;
  RxString alertMessage = "Failed to connect to OBS".obs;

  RxList scenesList = RxList();
  RxString currentScene = RxString("");

  RxList<SceneDetail> sourcesList = RxList();

  RxBool isStreaming = false.obs;
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

  /// Connect to the OBS websocket at [url] with optional [password]
  void connectWs(String url, String password) async {
    try {
      obsWebSocket = await ObsWebSocket.connect(
        connectUrl: 'ws://$url',
        onDone: connectionLost,
        timeout: Duration(seconds: 30),
      );

      obsWebSocket!.addHandler<RecordingStateEvent>(
          (RecordingStateEvent recordingStateEvent) async {
        switch (recordingStateEvent.type) {
          case 'RecordingStarted':
            isRecording.value = true;
            break;
          case 'RecordingStopped':
            isRecording.value = false;
            break;
        }
      });

      obsWebSocket!.addHandler<StreamStateEvent>(
          (StreamStateEvent streamStateEvent) async {
        switch (streamStateEvent.type) {
          case 'StreamStarted':
            isStreaming.value = true;
            break;
          case 'StreamStoppedEvent':
            isStreaming.value = false;
            break;
        }
      });

      obsWebSocket!.addHandler<StreamStatusEvent>(
          (StreamStatusEvent streamStatusEvent) async {
        //emit every 2 secs if stream is active
        // https://pub.dev/documentation/obs_websocket/latest/obs_websocket/StreamStatusEvent-class.html
        //TODO : display some of the informations on the OBS View
        debugPrint(streamStatusEvent.toString());
      });

      obsWebSocket!.addHandler<SceneItemStateEvent>(
          (SceneItemStateEvent sceneItemStateEvent) async {
        SceneDetail s = sourcesList
            .firstWhere((source) => source.id == sceneItemStateEvent.itemId);

        Map<String, dynamic> srcJson = s.toJson();
        srcJson['render'] = sceneItemStateEvent.itemVisible;
        SceneDetail updatedSource = SceneDetail.fromJson(srcJson);
        sourcesList[sourcesList.indexOf(s)] = updatedSource;
      });

      obsWebSocket!.addFallbackListener((BaseEvent baseEvent) {
        if (baseEvent.updateType == 'SwitchScenes') {
          getCurrentScene();
        }
      });

      final AuthRequiredResponse? authRequired =
          await obsWebSocket?.getAuthRequired();
      if (authRequired!.authRequired!) {
        await obsWebSocket?.authenticate(authRequired, password);
      }

      alertMessage.value = "Connected.";
      isConnected.value = true;
      getSceneList();
      getCurrentScene();
      //TODO : get stream status (only once)
      //TODO : get recording status (only once)
    } catch (e) {
      alertMessage.value = "Failed to connect to OBS";
      isConnected.value = false;
    }
  }

  void connectionFailed(Object o, StackTrace s) {
    debugPrint("connectionFailed");
    isConnected.value = false;
    alertMessage.value = "Can't connect to OBS...";
  }

  void connectionLost() {
    debugPrint("connectionLost");
    isConnected.value = false;
    alertMessage.value = "Connection with OBS lost...";
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
    await obsWebSocket!.startStopRecording();
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
  Future<void> getCurrentScene() async {
    Scene response = await obsWebSocket!.getCurrentScene();

    currentScene.value = response.name;
    sourcesList.value = response.scenes;
  }

  /// Switch to the scene named [sceneName]
  Future<void> setCurrentScene(String sceneName) async {
    await obsWebSocket!.setCurrentScene(sceneName);
  }

  /// Show or hide the source named [sourceName] according to the [value]
  void setSourceVisibleState(String sourceName, bool value) {
    obsWebSocket!.setSceneItemRender({"source": sourceName, "render": value});
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
      this.connectWs(settings.value.obsWebsocketUrl!,
          settings.value.obsWebsocketPassword!);
    }
  }
}
