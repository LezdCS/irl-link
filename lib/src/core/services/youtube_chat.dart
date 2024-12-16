import 'dart:async';
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket_channel/io.dart';

class YoutubeChat {
  YoutubeChat({
    required this.talker,
  });

  final Talker talker;
  IOWebSocketChannel? _webSocketChannel;
  StreamSubscription? _streamSubscription;
  Rx<bool> isConnected = false.obs;

  final StreamController<ChatMessage> _chatStreamController =
      StreamController<ChatMessage>.broadcast();
  Stream<ChatMessage> get chatStream => _chatStreamController.stream;

  late String channelHandle;

  Future<YoutubeChat> init({
    required String channel,
  }) async {
    channelHandle = channel;

    return this;
  }

  Future<void> connect() async {
    String url = "wss://youtube-api.irlhosting.com";

    _webSocketChannel = IOWebSocketChannel.connect(url);

    try {
      await _webSocketChannel?.ready;
    } catch (e) {
      talker.warning(
        'Failed to connect to the Youtube Chat Websocket. Retrying in 20 seconds.',
      );

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

    _webSocketChannel?.sink.add(
      jsonEncode({
        'type': 'subscribe',
        'channelId': channelHandle,
      }),
    );
  }

  void _onDone() {
    // talker.info("Twitch Sub Event: Connection closed");
    isConnected.value = false;
    close();
  }

  void _onError(Object o, StackTrace s) {
    isConnected.value = false;
    // talker.error("Twitch Sub Event: error", o, s);
  }

  void _eventListener(String data) {
    Map msgMapped = jsonDecode(data);
    switch (msgMapped['type']) {
      case 'connected':
        talker.info('Connection confirmed: ${msgMapped['message']}');
        break;

      case 'subscribed':
        talker.info('Subscribed to channel: ${msgMapped['channelId']}');
        break;

      case 'messages':
        talker.debug('New messages: ${msgMapped['messages']}');
        break;

      case 'error':
        talker.error('Youtube Chat Server error: ${msgMapped['message']}');
        break;
    }
  }

  void close() {
    _webSocketChannel?.sink.close();
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _chatStreamController.close();
  }
}
