import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obs_websocket/obs_websocket.dart';

class ObsTabViewController extends GetxController {
  final box = GetStorage();

  late ObsWebSocket obsWebSocket;

  RxDouble slideValueForVolume = 50.0.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    // connect to obs ws
    // todo get ws URL from obs tab creation
    obsWebSocket = await ObsWebSocket.connect(
        connectUrl: 'ws://localhost:4444',
        timeout: const Duration(seconds: 5)
    );

    super.onReady();
  }

  @override
  void onClose() {
    // close obs websocket
    obsWebSocket.close();

    super.onClose();
  }

  startStream() async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (!status.streaming) {
      await obsWebSocket.startStreaming();
    }
  }

  stopStream() async {
    final StreamStatusResponse status = await obsWebSocket.getStreamStatus();

    if (status.streaming) {
      await obsWebSocket.stopStreaming();
    }
  }


  /*
  returns
  * current-scene 	String
  * scenes 	Array<Scene>
  */
  getSceneList() async {
    BaseResponse? response = await obsWebSocket.command('GetSceneList');

    print(response);
    // List scenes = response.map['scenes'];
  }

  /*
  returns
  * name 	String
  * sources 	Array<SceneItem>
  */
  getCurrentScene() {

  }

  setCurrentScene(String sceneName) {

  }
}
