import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:web_socket_channel/io.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

class TwitchPubSubService extends GetxService {
  TwitchPubSubService();

  late String accessToken;
  late String channelName;
  late String _broadcasterId;
  Rx<bool> isConnected = false.obs;

  late IOWebSocketChannel? _webSocketChannel;
  late StreamSubscription? _streamSubscription;

  Future<TwitchPubSubService> init({required String accessToken, required String channelName}) async {
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
      //TODO : every 4 minutes we need to send a PING message to the server, if the server to not respond PONG within 10 seconds, we need to reconnect
      _listenToPinnedUpdates();
    } catch (e) {
      globals.talker?.warning(
          'Failed to connect to the Twitch EventSub Websocket. Retrying in 20 seconds.');

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
  }

  void _eventListener(data) {
    // Handle incoming events
     Map msgMapped = jsonDecode(data);
    if (msgMapped['type'] == 'PONG') {
      globals.talker?.info('Twitch PubSub Websocket PONG received.');
    } else if (msgMapped['type'] == 'RECONNECT') {
      globals.talker?.warning('Twitch PubSub Websocket RECONNECT received.');
      _reconnect();
    } else {
      globals.talker?.info('Twitch PubSub Websocket message received: $data');
    }
  }

  void _onDone() {
    globals.talker?.warning('Twitch PubSub Websocket closed.');
    isConnected.value = false;
    close();
  }

  void _onError(error) {
    globals.talker?.warning('Twitch PubSub Websocket error: $error');
    isConnected.value = false;
    close();
  }

  void send(String message) {
    _webSocketChannel?.sink.add(message);
  }
  
  void _listenToPinnedUpdates() {
    send('{"type":"LISTEN","data":{"topics":["pinned-chat-updates-v1.$_broadcasterId"],"auth_token":"$accessToken"}, "nonce":"${DateTime.now().millisecondsSinceEpoch}"}');
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
}