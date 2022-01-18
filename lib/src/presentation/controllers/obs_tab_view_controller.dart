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
  // active scene name
  RxString currentScene = RxString("");
  // sources of active scene
  RxList sourcesList = RxList();
  // visible sources names
  RxSet visibleSourcesList = RxSet();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    // connect to obs ws
    // todo get ws URL from obs tab creation
    connectWs("172.21.202.107", 4444);

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
        onError: (e) => connectFail(e)
    );

    // success
    alertMessage.value = "Connected.";
    isConnected.value = true;
    initController();
  }

  void connectFail(e) {
    isConnected.value = false;
    alertMessage.value = "Can't connect to OBS...";
  }

  void initController() {
    // loads all scenes
    getSceneList();

    // loads current scene and its sources
    // checks which sources are visible
    getCurrentScene();
  }

  Future<void> startStream()  async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (!status.streaming) {
      await obsWebSocket.startStreaming();
    }
  }

  Future<void> stopStream()  async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (status.streaming) {
      await obsWebSocket.stopStreaming();
    }
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
    BaseResponse? response = await obsWebSocket.command('GetSceneList');

    if (response!.status) {
      List respScenes = response.rawResponse["scenes"];

      for (var i=0; i<respScenes.length; i++)
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
    Scene response = await obsWebSocket.getCurrentScene();

    // loads current scene name
    currentScene.value = response.name;
    // loads current scene sources in list
    sourcesList.value = response.scenes;
    
    // builds visible sources list
    sourcesList.forEach((source) => {
      if (source.render) visibleSourcesList.add(source.name)
    });
  }

  Future<void> setCurrentScene(String sceneName) async {
    // update on OBS
    await obsWebSocket.setCurrentScene(sceneName);

    // update controller
    getCurrentScene();
  }

  void setSourceVisibleState(String sourceName, bool value) {
    // update on OBS
    obsWebSocket.setSceneItemRender({
      "source": sourceName,
      "render": value
    });

    // update controller
    value
        ? visibleSourcesList.add(sourceName)
        : visibleSourcesList.remove(sourceName)
    ;
  }
}
