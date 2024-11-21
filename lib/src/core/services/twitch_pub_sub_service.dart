import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/domain/entities/pinned_message.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:web_socket_channel/io.dart';


class TwitchPubSubService extends GetxService {
  TwitchPubSubService();

  late String accessToken;
  late String channelName;
  late String _broadcasterId;
  Rx<bool> isConnected = false.obs;

  late IOWebSocketChannel? _webSocketChannel;
  late StreamSubscription? _streamSubscription;

  late Timer pingTimer;

  Talker talker = Get.find<TalkerService>().talker;

  Future<TwitchPubSubService> init(
      {required String accessToken, required String channelName,}) async {
    this.accessToken = accessToken;
    this.channelName = channelName;
    return this;
  }

  Future<void> connect() async {
    _broadcasterId = await _getChannelId();

    String url = "wss://pubsub-edge.twitch.tv";

    _webSocketChannel = IOWebSocketChannel.connect(url);

    try {
      await _webSocketChannel?.ready;
      _ping();
      pingTimer = Timer.periodic(const Duration(minutes: 4), (Timer t) {
        _ping();
      });
      _listenToPinnedUpdates();
    } catch (e) {
      talker.warning(
          'Failed to connect to the Twitch EventSub Websocket. Retrying in 20 seconds.',);

      Future.delayed(const Duration(seconds: 20), () {
        connect();
      });
      return;
    }

    _streamSubscription = _webSocketChannel?.stream.listen(
      (data) => _eventListener(data),
      onDone: _onDone,
      onError: _onError,
    );
    isConnected.value = true;
  }

  void close() {
    _webSocketChannel?.sink.close();
    _streamSubscription?.cancel();
    _streamSubscription = null;
    pingTimer.cancel();
  }

  void _eventListener(data) {
    // Handle incoming events
    Map<String, dynamic> msgMapped = jsonDecode(data);
    String type = msgMapped['type'];
    if (type == 'PONG') {
      talker.info('Twitch PubSub Websocket PONG received.');
    } else if (type == 'RECONNECT') {
      talker.warning('Twitch PubSub Websocket RECONNECT received.');
      _reconnect();
    } else if (type == 'MESSAGE') {
      String topic = msgMapped['data']['topic'];
      if (topic == 'pinned-chat-updates-v1.$_broadcasterId') {
        Map<String, dynamic> message = jsonDecode(msgMapped['data']['message']);
        switch (message['type']) {
          case 'pin-message':
            _handlePinnedMessage(message);
            break;
          case 'unpin-message':
            _handleRemovePinnedMessage(message['data']['id']);
            break;
          default:
            break;
        }
      }
    }
  }

  void _onDone() {
    talker.warning('Twitch PubSub Websocket closed.');
    isConnected.value = false;
    close();
  }

  void _onError(error) {
    talker.warning('Twitch PubSub Websocket error: $error');
    isConnected.value = false;
    close();
  }

  void send(String message) {
    _webSocketChannel?.sink.add(message);
  }

  void _listenToPinnedUpdates() {
    send(
        '{"type":"LISTEN","data":{"topics":["pinned-chat-updates-v1.$_broadcasterId"],"auth_token":"$accessToken"}, "nonce":"${DateTime.now().millisecondsSinceEpoch}"}',);
  }

  void _ping() {
    send('{"type":"PING"}');
  }

  void _reconnect() {
    close();
    connect();
  }

  Future<String> _getChannelId() async {
    String? response = await TwitchApi.getTwitchUserChannelId(
      channelName,
      accessToken,
      kTwitchAuthClientId,
    );
    return response ?? '';
  }

  void _handlePinnedMessage(Map<String, dynamic> message) {
    PinnedMessage pinnedMessage =
        PinnedMessage.fromTwitch(message);
    Get.find<HomeViewController>().pinnedMessages.add(pinnedMessage);
  }

  void _handleRemovePinnedMessage(String pinId) {
    Get.find<HomeViewController>()
        .pinnedMessages
        .removeWhere((element) => element.id == pinId);
  }
}
