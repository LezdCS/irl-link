import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/src/model/scene.dart';

class ObsTabViewController extends GetxController {
  final box = GetStorage();

  late ObsWebSocket obsWebSocket;

  RxString alertMessage = "Connecting...".obs;
  RxBool isConnected = false.obs;

  RxDouble slideValueForVolume = 50.0.obs;

  // obs scenes list
  RxList scenesList = RxList();
  // active scene
  RxString currentScene = RxString("");
  // sources of active scene
  RxList sourcesList = RxList();
  // visible sources
  RxSet selectedSourcesList = RxSet();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    // connect to obs ws
    try {
      // todo get ws URL from obs tab creation
      connectWs("192.168.1.51", 4444);
      alertMessage = "Connected.".obs;
      isConnected = true.obs;
    } catch(e) {
      alertMessage = e.toString().obs;
      isConnected = false.obs;
    }

    super.onReady();
  }

  @override
  void onClose() {
    // close obs websocket
    obsWebSocket.close();

    super.onClose();
  }

  void connectWs(String addr, int port) async {
    obsWebSocket = await ObsWebSocket.connect(
        connectUrl: 'ws://$addr:$port',
        timeout: const Duration(seconds: 30),
        onError: (e) => (throw e)
    );
  }

  void startStream() async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (!status.streaming) {
      await obsWebSocket.startStreaming();
    }
  }

  void stopStream() async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (status.streaming) {
      await obsWebSocket.stopStreaming();
    }
  }

  void getSceneList() async {
    /*
    returns
    * current-scene 	String
    * scenes 	Array<Scene>
    */
    BaseResponse? response = await obsWebSocket.command('GetSceneList');

    print("GetScenes: "+response!.status.toString());
    if (response.status) {
      scenesList = response.rawResponse.entries as RxList;
      debugPrint("Scenes: "+ scenesList.toString());
    }
  }

  void getCurrentScene() async {
    /*
    returns
    * name 	String
    * sources 	Array<SceneItem>
    */
    Scene response = await obsWebSocket.getCurrentScene();
    currentScene = response.name.obs;
    sourcesList = response.scenes.obs;
  }

  void getVisibleSources() {
    sourcesList.forEach((source) => {
      if (source.render)
        selectedSourcesList.add(source)
    });
  }

  void setCurrentScene(String sceneName) {
    obsWebSocket.setCurrentScene(sceneName);
  }
}
