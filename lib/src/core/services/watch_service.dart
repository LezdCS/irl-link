import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/presentation/controllers/tabs/obs_tab_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class WatchService extends GetxService {
  static const String _channelName = 'com.irllink';
  final _channel = const MethodChannel(_channelName);
  ObsTabViewController? _obsController;
  Talker talker = Get.find<TalkerService>().talker;
  bool _isChannelAvailable = false;

  Future<WatchService> init() async {
    // Always set the method handler so we can receive calls when the channel becomes
    // available later.
    _channel.setMethodCallHandler(_handleWatchMessage);

    // Check if platform channel exists now (it may become available later).
    try {
      await _ensureChannelAvailable();
    } catch (e) {
      talker.error('Watch platform channel error: $e');
    }

    return this;
  }

  Future<void> _handleWatchMessage(MethodCall call) async {
    talker.logCustom(WatchLog('Data from watch: ${call.arguments}'));
    final data = call.arguments['data'];
    final controller = _obsController ??= Get.find<ObsTabViewController>();

    switch (call.method) {
      case "sendChangeObsSceneToFlutter":
        controller.setCurrentScene(data['scene']);
      case "sendToggleObsSourceToFlutter":
        controller.setSourceVisibleState(
          data['sourceItemId'],
          sceneItemEnabled: data['sceneItemEnabled'],
        );
    }
  }

  Future<bool> _ensureChannelAvailable() async {
    if (_isChannelAvailable) {
      return true;
    }
    try {
      final bool exists =
          await _channel.invokeMethod('isChannelAvailable') ?? false;
      _isChannelAvailable = exists;
      if (exists) {
        talker.logCustom(WatchLog('Watch platform channel is now available'));
      } else {
        talker.warning('Watch platform channel is not available');
      }
    } catch (_) {
      _isChannelAvailable = false;
    }
    return _isChannelAvailable;
  }

  Future<void> sendChatMessageToNative(ChatMessage message) async {
    if (!await _ensureChannelAvailable()) {
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendChatMessageToNative",
        "data": message.toJsonForWatch(),
      });
    } catch (e) {
      talker.error('Failed to send chat message to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendUpdateObsConnecteToNative({
    required bool isConnected,
  }) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendUpdateObsConnecteToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendUpdateObsConnecteToNative",
        "data": isConnected,
      });
    } catch (e) {
      talker.error('Failed to send update obs connected to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendSelectedObsSceneToNative(String sceneName) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendSelectedObsSceneToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSelectedObsSceneToNative",
        "data": sceneName,
      });
    } catch (e) {
      talker.error('Failed to send update obs scene to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendObsScenesToNative(List<String> scenes) async {
    if (!await _ensureChannelAvailable()) {
      talker
          .warning('Watch channel unavailable; skipping sendObsScenesToNative');
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendObsScenesToNative",
        "data": scenes,
      });
    } catch (e) {
      talker.error('Failed to send obs scenes to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendObsSourcesToNative(String data) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendObsSourcesToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendObsSourcesToNative",
        "data": data,
      });
    } catch (e) {
      talker.error('Failed to send obs sources to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendSeConnectedToNative({required bool isConnected}) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendSeConnectedToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSeConnectedToNative",
        "data": isConnected,
      });
    } catch (e) {
      talker.error('Failed to send se connected to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendSeActivityToNative(SeActivity activity) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendSeActivityToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendSeActivityToNative",
        "data": activity.toJsonForWatch(),
      });
    } catch (e) {
      talker.error('Failed to send se activity to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendViewersToNative(int viewers) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning('Watch channel unavailable; skipping sendViewersToNative');
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendViewersToNative",
        "data": viewers,
      });
    } catch (e) {
      talker.error('Failed to send viewers to watch: $e');
      _isChannelAvailable = false;
    }
  }

  Future<void> sendLiveStatusToNative({required bool isLive}) async {
    if (!await _ensureChannelAvailable()) {
      talker.warning(
          'Watch channel unavailable; skipping sendLiveStatusToNative',);
      return;
    }
    try {
      await _channel.invokeMethod("flutterToWatch", {
        "method": "sendLiveStatusToNative",
        "data": isLive,
      });
    } catch (e) {
      talker.error('Failed to send live status to watch: $e');
      _isChannelAvailable = false;
    }
  }
}
