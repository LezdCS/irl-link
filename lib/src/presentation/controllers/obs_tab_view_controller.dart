import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/home_events.dart';
import 'package:obs_websocket/obs_websocket.dart';

import 'package:obs_websocket/src/model/scene.dart';


class ObsTabViewController extends GetxController {
  ObsTabViewController({required this.homeEvents});
  final HomeEvents homeEvents;


  ObsWebSocket? obsWebSocket;

  RxString alertMessage = "Failed to connect to OBS".obs;
  RxBool isConnected = false.obs;

  // obs scenes list
  RxList scenesList = RxList();
  // active scene name
  RxString currentScene = RxString("");
  // sources of active scene
  RxList sourcesList = RxList();
  // visible sources names
  RxSet visibleSourcesList = RxSet();

  RxBool isRecording = false.obs;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await getSettings();
    super.onReady();
  }

  @override
  void onClose() {
    // close obs websocket
    obsWebSocket!.close();

    super.onClose();
  }

  void connectWs(String url) async {
    try{
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
    }catch(e){
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

  Future<void> startStream() async {
    final StreamStatusResponse status = await obsWebSocket!.getStreamStatus();

    if (!status.streaming) {
      await obsWebSocket!.startStreaming();
    }
  }

  Future<void> stopStream() async {
    final StreamStatusResponse status = await obsWebSocket!.getStreamStatus();

    if (status.streaming) {
      await obsWebSocket!.stopStreaming();
    }
  }

  Future<void> startStopRecording() async {
    //TODO : to finish
    await obsWebSocket!.startStopRecording();
    BaseResponse? status = await obsWebSocket!.command('GetRecordingStatus');
    debugPrint(status!.rawResponse.toString());
    debugPrint(status.rawResponse['isRecording'].toString());
  }

  /*
  fetch scene list
   */
  Future<void> getSceneList() async {
    /*
    returns
    * current-scene 	String
    * scenes 	Array<Scene>
    */
    BaseResponse? response = await obsWebSocket!.command('GetSceneList');
    scenesList.clear();

    if (response!.status) {
      List respScenes = response.rawResponse["scenes"];

      for (var i = 0; i < respScenes.length; i++)
        scenesList.add(respScenes[i]["name"]);
    }
  }

  /*
  fetch current scene and its sources
  build a list with all visible sources
   */
  Future<void> getCurrentScene() async {
    /*
    returns
    * name 	String
    * scenes 	Array<SceneItem> (sources of the current scene)
    */
    Scene response = await obsWebSocket!.getCurrentScene();

    // loads current scene name
    currentScene.value = response.name;
    // loads current scene sources in list
    sourcesList.value = response.scenes;

    // builds visible sources list
    sourcesList.forEach(
        (source) => {if (source.render) visibleSourcesList.add(source.name)});
  }

  Future<void> setCurrentScene(String sceneName) async {
    // update on OBS
    await obsWebSocket!.setCurrentScene(sceneName);

    // update controller
    getCurrentScene();
  }

  void setSourceVisibleState(String sourceName, bool value) {
    // update on OBS
    obsWebSocket!.setSceneItemRender({"source": sourceName, "render": value});

    // update controller
    value
        ? visibleSourcesList.add(sourceName)
        : visibleSourcesList.remove(sourceName);
  }

  Future getSettings() async {
    await homeEvents.getSettings().then((value) async => {
      if (value.error == null)
        {
          settings.value = value.data!,
          if(obsWebSocket != null){
            obsWebSocket!.close(),
          },
          if(settings.value.isObsConnected!){
            this.connectWs(settings.value.obsWebsocketUrl!),
          }
        },
    });
  }
}
