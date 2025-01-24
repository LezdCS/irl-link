import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket_channel/io.dart';

class YoutubeChat {
  YoutubeChat({
    required this.talker,
    required this.twitchToken,
  });

  final Talker talker;
  final String twitchToken;
  IOWebSocketChannel? _webSocketChannel;
  StreamSubscription? _streamSubscription;
  Rx<bool> isConnected = false.obs;

  StreamController<ChatMessage>? _chatStreamController;
  Stream<ChatMessage> get chatStream => _getChatStream();

  Stream<ChatMessage> _getChatStream() {
    _chatStreamController ??= StreamController<ChatMessage>.broadcast();
    return _chatStreamController!.stream;
  }

  late String channelHandle;

  Future<YoutubeChat> init({
    required String channel,
  }) async {
    channelHandle = channel;

    return this;
  }

  Future<void> connect() async {
    if (_chatStreamController?.isClosed ?? false) {
      _chatStreamController = StreamController<ChatMessage>.broadcast();
    }

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String url = remoteConfig.getString('youtube_websocket_url');

    _webSocketChannel = IOWebSocketChannel.connect(
      url,
      protocols: [
        'Authorization',
        twitchToken,
      ],
    );

    try {
      talker.info('Connecting to Youtube Chat Websocket');
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
        'data': {
          'channelId': channelHandle,
        },
      }),
    );
  }

  void _onDone() {
    talker.warning("Youtube Chat: Connection closed");
    isConnected.value = false;
    close();
  }

  void _onError(Object o, StackTrace s) {
    isConnected.value = false;
    talker.error("Youtube Chat: error", o, s);
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
        for (var message in msgMapped['messages']) {
          _chatStreamController
              ?.add(ChatMessage.fromYoutube(message, channelHandle));
        }
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
    _chatStreamController?.close();
    _chatStreamController = null;
  }
}
