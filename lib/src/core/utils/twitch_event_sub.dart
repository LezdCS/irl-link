import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:irllink/src/data/entities/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch_prediction_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';
import 'package:irllink/src/domain/entities/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch_prediction.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:web_socket_channel/io.dart';

import '../../data/entities/twitch/twitch_hype_train_dto.dart';
import 'constants.dart';

class TwitchEventSub {
  String accessToken;
  String channelName;
  IOWebSocketChannel? _webSocketChannel;
  StreamSubscription? _streamSubscription;
  String? _broadcasterId;

  ValueNotifier<TwitchPoll> currentPoll =
      ValueNotifier<TwitchPoll>(TwitchPoll.empty());
  ValueNotifier<TwitchPrediction> currentPrediction =
      ValueNotifier<TwitchPrediction>(TwitchPrediction.empty());
  ValueNotifier<TwitchHypeTrain> currentHypeTrain =
      ValueNotifier<TwitchHypeTrain>(TwitchHypeTrain.empty());

  TwitchEventSub(
    this.channelName,
    this.accessToken,
  );

  void connect() async {
    _broadcasterId = await _getChannelId();

    _webSocketChannel =
        IOWebSocketChannel.connect("wss://eventsub.wss.twitch.tv/ws");
    // _webSocketChannel = IOWebSocketChannel.connect("ws://localhost:8080/ws");


    _streamSubscription = _webSocketChannel?.stream.listen(
      (data) => _eventListener(data),
      onDone: _onDone,
      onError: _onError,
    );
  }

  void close() {
    debugPrint('close');
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

    if (msgMapped['metadata']['subscription_type'] != null) {
      switch (msgMapped['metadata']['subscription_type']) {
        //POLLS
        case 'channel.poll.begin':
          currentPoll.value =
              TwitchPollDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.poll.progress':
          currentPoll.value =
              TwitchPollDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.poll.end':
          currentPoll.value =
              TwitchPollDTO.fromJson(msgMapped['payload']['event']);
          Future.delayed(const Duration(seconds: 20))
              .then((value) => currentPoll.value = TwitchPoll.empty());
          break;

        //PREDICTIONS
        case 'channel.prediction.begin':
          currentPrediction.value =
              TwitchPredictionDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.prediction.progress':
          currentPrediction.value =
              TwitchPredictionDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.prediction.lock':
          currentPrediction.value =
              TwitchPredictionDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.prediction.end':
          currentPrediction.value =
              TwitchPredictionDTO.fromJson(msgMapped['payload']['event']);
          Future.delayed(const Duration(seconds: 20)).then(
              (value) => currentPrediction.value = TwitchPrediction.empty());
          break;

        //HYPE TRAIN
        case 'channel.hype_train.begin':
          currentHypeTrain.value =
              TwitchHypeTrainDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.hype_train.progress':
          currentHypeTrain.value =
              TwitchHypeTrainDTO.fromJson(msgMapped['payload']['event']);
          break;
        case 'channel.hype_train.end':
          currentHypeTrain.value =
              TwitchHypeTrainDTO.fromJson(msgMapped['payload']['event']);
          Future.delayed(const Duration(seconds: 20)).then(
              (value) => currentHypeTrain.value = TwitchHypeTrain.empty());
          break;
        default:
      }
    }
  }

  void _onDone() {
    debugPrint("Twitch Sub Event: Connection closed");
    close();
  }

  void _onError(Object o, StackTrace s) {
    debugPrint(o.toString());
    debugPrint(s.toString());
  }

  Future<String> _getChannelId() async {
    String? response = await TwitchApi.getTwitchUserChannelId(
        channelName, accessToken, kTwitchAuthClientId);
    return response ?? '';
  }

  void subscribeToEvent(String type, String version, String sessionId,
      Map<String, String> condition) async {
    var dio = Dio();
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
      debugPrint(e.response.toString());
    }
  }
}