import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_prediction_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:web_socket_channel/io.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;

import '../../data/entities/twitch/twitch_hype_train_dto.dart';
import '../utils/constants.dart';

class TwitchEventSub {
  String accessToken;
  String channelName;
  IOWebSocketChannel? _webSocketChannel;
  StreamSubscription? _streamSubscription;
  String? _broadcasterId;

  Rx<TwitchPoll> currentPoll = TwitchPoll.empty().obs;
  Rx<TwitchPrediction> currentPrediction = TwitchPrediction.empty().obs;
  ValueNotifier<TwitchHypeTrain> currentHypeTrain =
      ValueNotifier<TwitchHypeTrain>(TwitchHypeTrain.empty());

  TwitchEventSub(
    this.channelName,
    this.accessToken,
  );

  bool get isConnected => _streamSubscription != null;

  void connect() async {
    _broadcasterId = await _getChannelId();

    String url = "wss://eventsub.wss.twitch.tv/ws";
    if (kDebugMode) {
      url = "ws://localhost:8080/ws";
    }

    _webSocketChannel = IOWebSocketChannel.connect(url);

    try {
      await _webSocketChannel?.ready;
    } catch (e) {
      globals.talker?.warning('Failed to connect to the Twitch EventSub Websocket.');
      return;
    }

    _streamSubscription = _webSocketChannel?.stream.listen(
      (data) => _eventListener(data),
      onDone: _onDone,
      onError: _onError,
    );
  }

  void close() {
    _webSocketChannel?.sink.close();
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  void _eventListener(String data) {
    // debugPrint("Sub event: $data");
    Map msgMapped = jsonDecode(data);

    if (msgMapped['metadata'] != null &&
        msgMapped['metadata']['message_type'] == 'session_welcome') {
      String sessionId = msgMapped['payload']['session']['id'];

      //SUBSCRIBE TO POLLS BEGIN, PROGRESS, END
      subscribeToEvent('channel.poll.begin', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.poll.progress', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.poll.end', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});

      //SUBSCRIBE TO PREDICTIONS BEGIN, PROGRESS, END
      subscribeToEvent('channel.prediction.begin', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.prediction.progress', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.prediction.lock', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.prediction.end', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});

      //SUBSCRIBE TO HYPE TRAINS
      subscribeToEvent('channel.hype_train.begin', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.hype_train.progress', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
      subscribeToEvent('channel.hype_train.end', '1', sessionId,
          {"broadcaster_user_id": _broadcasterId ?? ''});
    }

    String? subsriptionType = msgMapped['metadata']['subscription_type'];
    if (subsriptionType != null) {
      Map<String, dynamic> event = msgMapped['payload']['event'];
      switch (subsriptionType) {
        //POLLS
        case 'channel.poll.begin':
        case 'channel.poll.progress':
          currentPoll.value = TwitchPollDTO.fromJson(event);
          break;
        case 'channel.poll.end':
          currentPoll.value = TwitchPollDTO.fromJson(event);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentPoll.value = TwitchPoll.empty(),
          );
          break;

        //PREDICTIONS
        case 'channel.prediction.begin':
        case 'channel.prediction.progress':
        case 'channel.prediction.lock':
          currentPrediction.value = TwitchPredictionDTO.fromJson(event);
          break;
        case 'channel.prediction.end':
          currentPrediction.value = TwitchPredictionDTO.fromJson(event);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentPrediction.value = TwitchPrediction.empty(),
          );
          break;

        //HYPE TRAIN
        case 'channel.hype_train.begin':
        case 'channel.hype_train.progress':
          currentHypeTrain.value = TwitchHypeTrainDTO.fromJson(event);
          break;
        case 'channel.hype_train.end':
          currentHypeTrain.value = TwitchHypeTrainDTO.fromJson(event);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentHypeTrain.value = TwitchHypeTrain.empty(),
          );
          break;
        default:
          break;
      }
    }
  }

  void _onDone() {
    globals.talker?.info("Twitch Sub Event: Connection closed");
    close();
  }

  void _onError(Object o, StackTrace s) {
    globals.talker?.error("Twitch Sub Event: error", o, s);
  }

  Future<String> _getChannelId() async {
    String? response = await TwitchApi.getTwitchUserChannelId(
        channelName, accessToken, kTwitchAuthClientId);
    return response ?? '';
  }

  void subscribeToEvent(String type, String version, String sessionId,
      Map<String, String> condition) async {
    var dio = initDio();
    try {
      dio.options.headers['Client-Id'] = kTwitchAuthClientId;
      dio.options.headers["authorization"] = "Bearer $accessToken";
      // await dio.post('http://localhost:8080/eventsub/subscriptions', data: {
      await dio
          .post('https://api.twitch.tv/helix/eventsub/subscriptions', data: {
        "type": type,
        "version": version,
        "condition": condition,
        "transport": {"method": "websocket", "session_id": sessionId}
      });
    } on DioException catch (e) {
      globals.talker?.error(e.response.toString());
    }
  }
}
