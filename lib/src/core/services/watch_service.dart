import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/presentation/controllers/obs_tab_view_controller.dart';

class WatchService extends GetxService {
  static const String _channelName = 'com.irllink';
  final _channel = const MethodChannel(_channelName);
  late final ObsTabViewController _obsController;

  Future<WatchService> init() async {
    // Check if platform channel exists
    try {
      final bool exists =
          await _channel.invokeMethod('isChannelAvailable') ?? false;
      if (!exists) {
        debugPrint('Watch platform channel is not available');
        return this;
      }

      _obsController = Get.find<ObsTabViewController>();

      _channel.setMethodCallHandler(_handleWatchMessage);
    } catch (e) {
      debugPrint('Watch platform channel error: $e');
    }

    return this;
  }

  Future<void> _handleWatchMessage(MethodCall call) async {
    debugPrint('Data from watch: ${call.arguments}');
    final data = call.arguments['data'];

    switch (call.method) {
      case "sendChangeObsSceneToFlutter":
        _obsController.setCurrentScene(data['scene']);
      case "sendToggleObsSourceToFlutter":
        _obsController.setSourceVisibleState(
          data['sourceItemId'],
          sceneItemEnabled: data['sceneItemEnabled'],
        );
    }
  }

  Future<void> sendChatMessageToNative(ChatMessage message) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendChatMessageToNative",
        "data": message.toJsonForWatch(),
      });
    } catch (e) {
      debugPrint('Failed to send chat message to watch: $e');
    }
  }

  Future<void> sendUpdateObsConnecteToNative({
    required bool isConnected,
  }) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendUpdateObsConnecteToNative",
        "data": isConnected,
      });
    } catch (e) {
      debugPrint('Failed to send update obs connected to watch: $e');
    }
  }

  Future<void> sendSelectedObsSceneToNative(String sceneName) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSelectedObsSceneToNative",
        "data": sceneName,
      });
    } catch (e) {
      debugPrint('Failed to send update obs scene to watch: $e');
    }
  }

  Future<void> sendObsScenesToNative(List<String> scenes) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendObsScenesToNative",
        "data": scenes,
      });
    } catch (e) {
      debugPrint('Failed to send obs scenes to watch: $e');
    }
  }

  Future<void> sendObsSourcesToNative(String data) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendObsSourcesToNative",
        "data": data,
      });
    } catch (e) {
      debugPrint('Failed to send obs sources to watch: $e');
    }
  }

  Future<void> sendSeConnectedToNative({required bool isConnected}) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSeConnectedToNative",
        "data": isConnected,
      });
    } catch (e) {
      debugPrint('Failed to send se connected to watch: $e');
    }
  }

  Future<void> sendSeActivityToNative(SeActivity activity) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSeActivityToNative",
        "data": activity.toJsonForWatch(),
      });
    } catch (e) {
      debugPrint('Failed to send se activity to watch: $e');
    }
  }

  Future<void> sendViewersToNative(int viewers) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendViewersToNative",
        "data": viewers,
      });
    } catch (e) {
      debugPrint('Failed to send viewers to watch: $e');
    }
  }

  Future<void> sendLiveStatusToNative({required bool isLive}) async {
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendLiveStatusToNative",
        "data": isLive,
      });
    } catch (e) {
      debugPrint('Failed to send live status to watch: $e');
    }
  }
}
