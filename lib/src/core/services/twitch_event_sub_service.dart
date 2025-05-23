import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/utils/constants.dart';
import 'package:irllink/src/core/utils/convert_to_device_timezone.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/data/entities/twitch/twitch_hype_train_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_prediction_dto.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/domain/usecases/twitch/create_poll_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/end_poll_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/end_prediction_usecase.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:twitch_chat/twitch_chat.dart';
import 'package:web_socket_channel/io.dart';

class TwitchEventSubService extends GetxController with WidgetsBindingObserver {
  TwitchEventSubService({
    required this.createPollUseCase,
    required this.endPollUseCase,
    required this.endPredictionUseCase,
    required this.talker,
    required this.dioClient,
  }) : mappr = Mappr();

  final CreatePollUseCase createPollUseCase;
  final EndPollUseCase endPollUseCase;
  final EndPredictionUseCase endPredictionUseCase;

  final Talker talker;
  final Mappr mappr;
  final Dio dioClient;

  late String accessToken;
  late String channelName;
  IOWebSocketChannel? _webSocketChannel;
  StreamSubscription? _streamSubscription;
  String? _broadcasterId;

  Rx<TwitchPoll> currentPoll = TwitchPoll.empty().obs;
  Rx<Duration> remainingTimePoll = Duration.zero.obs;

  Rx<TwitchPrediction> currentPrediction = TwitchPrediction.empty().obs;
  Rx<Duration> remainingTimePrediction = Duration.zero.obs;
  RxString selectedOutcomeId = "-1".obs;

  Rx<TwitchHypeTrain> currentHypeTrain = TwitchHypeTrain.empty().obs;
  Rx<Duration> remainingTimeHypeTrain = Duration.zero.obs;

  void setup({
    required String token,
    required String channel,
  }) {
    channelName = channel;
    accessToken = token;

    listenToPoll();
    listenToPrediction();
    listenToHypeTrain();
  }

  Rx<bool> isConnected = false.obs;

  Future<void> connect() async {
    _broadcasterId = await _getChannelId();

    String url = "wss://eventsub.wss.twitch.tv/ws";
    if (kDebugMode) {
      url = "ws://localhost:8080/ws";
    }

    _webSocketChannel = IOWebSocketChannel.connect(url);

    try {
      await _webSocketChannel?.ready;
    } catch (e) {
      talker.warning(
        'Failed to connect to the Twitch EventSub Websocket. Retrying in 20 seconds.',
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
  }

  void close() {
    _webSocketChannel?.sink.close();
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  void reconnect() {
    close();
    connect();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // The app is back to the foreground
      reconnect(); // Reconnect to Twitch EventSub
    } else if (state == AppLifecycleState.paused) {
      // The app is sent to the background
    }
  }

  void _eventListener(String data) {
    Map msgMapped = jsonDecode(data);

    if (msgMapped['metadata'] != null &&
        msgMapped['metadata']['message_type'] == 'session_welcome') {
      String sessionId = msgMapped['payload']['session']['id'];

      //SUBSCRIBE TO POLLS BEGIN, PROGRESS, END
      subscribeToEvent(
        'channel.poll.begin',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.poll.progress',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.poll.end',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );

      //SUBSCRIBE TO PREDICTIONS BEGIN, PROGRESS, END
      subscribeToEvent(
        'channel.prediction.begin',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.prediction.progress',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.prediction.lock',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.prediction.end',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );

      //SUBSCRIBE TO HYPE TRAINS
      subscribeToEvent(
        'channel.hype_train.begin',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.hype_train.progress',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
      subscribeToEvent(
        'channel.hype_train.end',
        '1',
        sessionId,
        {"broadcaster_user_id": _broadcasterId ?? ''},
      );
    }

    String? subsriptionType = msgMapped['metadata']['subscription_type'];
    if (subsriptionType != null) {
      Map<String, dynamic> event = msgMapped['payload']['event'];
      switch (subsriptionType) {
        //POLLS
        case 'channel.poll.begin':
        case 'channel.poll.progress':
          final pollDTO = TwitchPollDTO.fromJson(event);
          currentPoll.value = mappr.convert<TwitchPollDTO, TwitchPoll>(pollDTO);
        case 'channel.poll.end':
          final pollDTO = TwitchPollDTO.fromJson(event);
          currentPoll.value = mappr.convert<TwitchPollDTO, TwitchPoll>(pollDTO);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentPoll.value = TwitchPoll.empty(),
          );

        //PREDICTIONS
        case 'channel.prediction.begin':
        case 'channel.prediction.progress':
        case 'channel.prediction.lock':
          final predictionDTO = TwitchPredictionDTO.fromJson(event);
          currentPrediction.value = mappr
              .convert<TwitchPredictionDTO, TwitchPrediction>(predictionDTO);
        case 'channel.prediction.end':
          final predictionDTO = TwitchPredictionDTO.fromJson(event);
          currentPrediction.value = mappr
              .convert<TwitchPredictionDTO, TwitchPrediction>(predictionDTO);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentPrediction.value = TwitchPrediction.empty(),
          );

        //HYPE TRAIN
        case 'channel.hype_train.begin':
        case 'channel.hype_train.progress':
          final hypeTrainDTO = TwitchHypeTrainDTO.fromJson(event);
          currentHypeTrain.value =
              mappr.convert<TwitchHypeTrainDTO, TwitchHypeTrain>(hypeTrainDTO);
        case 'channel.hype_train.end':
          final hypeTrainDTO = TwitchHypeTrainDTO.fromJson(event);
          currentHypeTrain.value =
              mappr.convert<TwitchHypeTrainDTO, TwitchHypeTrain>(hypeTrainDTO);
          Future.delayed(const Duration(seconds: 20)).then(
            (value) => currentHypeTrain.value = TwitchHypeTrain.empty(),
          );
        default:
          break;
      }
    }
  }

  void _onDone() {
    talker.info("Twitch Sub Event: Connection closed");
    isConnected.value = false;
    close();
  }

  void _onError(Object o, StackTrace s) {
    isConnected.value = false;
    talker.error("Twitch Sub Event: error", o, s);
  }

  Future<String> _getChannelId() async {
    String? response = await TwitchApi.getTwitchUserChannelId(
      channelName,
      accessToken,
      kTwitchAuthClientId,
    );
    return response ?? '';
  }

  void subscribeToEvent(
    String type,
    String version,
    String sessionId,
    Map<String, String> condition,
  ) async {
    try {
      dioClient.options.headers['Client-Id'] = kTwitchAuthClientId;
      dioClient.options.headers["authorization"] = "Bearer $accessToken";
      // await dio.post('http://localhost:8080/eventsub/subscriptions', data: {
      await dioClient.post(
        '/helix/eventsub/subscriptions',
        data: {
          "type": type,
          "version": version,
          "condition": condition,
          "transport": {"method": "websocket", "session_id": sessionId},
        },
      );
    } on DioException catch (e) {
      talker.error(e.response.toString());
    }
  }

  void listenToPoll() {
    Timer? timer;

    currentPoll.listen((poll) {
      if (poll.status == PollStatus.active) {
        if (timer != null) {
          timer?.cancel();
        }
        remainingTimePoll = convertToDeviceTimezone(currentPoll.value.endsAt)
            .difference(DateTime.now())
            .obs;
        if (remainingTimePoll.value.inSeconds > 0) {
          // Every 1 second, refresh remaining time
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              remainingTimePoll.value = convertToDeviceTimezone(poll.endsAt)
                  .difference(DateTime.now());
            },
          );
        }
      } else {
        timer?.cancel();
      }
    });
  }

  void listenToPrediction() {
    Timer? timer;

    currentPrediction.listen((prediction) {
      if (prediction.status == PredictionStatus.active) {
        if (timer != null) {
          timer?.cancel();
        }
        remainingTimePrediction =
            convertToDeviceTimezone(prediction.remainingTime)
                .difference(DateTime.now())
                .obs;
        if (remainingTimePrediction.value.inSeconds > 0) {
          // Every 1 second, refresh remaining time
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              remainingTimePrediction.value =
                  convertToDeviceTimezone(prediction.remainingTime)
                      .difference(DateTime.now());
            },
          );
        }
      } else {
        timer?.cancel();
      }
    });
  }

  void listenToHypeTrain() {
    Timer? timer;

    currentHypeTrain.listen((train) {
      if (train.id == '') {
        timer?.cancel();
        return;
      }

      if (timer != null) {
        timer?.cancel();
      }

      remainingTimeHypeTrain =
          convertToDeviceTimezone(train.endsAt).difference(DateTime.now()).obs;
      if (remainingTimeHypeTrain.value.inSeconds > 0) {
        // Every 1 second, refresh remaining time
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            remainingTimeHypeTrain.value = convertToDeviceTimezone(train.endsAt)
                .difference(DateTime.now());
          },
        );
      }
    });
  }

  Future<void> createPoll(String question, List<Choice> choices) async {
    TwitchPoll newPoll = TwitchPoll(
      id: "",
      title: "",
      choices: choices,
      status: PollStatus.active,
      totalVotes: 0,
      endsAt: DateTime.now(),
    );
    final createPollResult = await createPollUseCase(
      params: CreatePollUseCaseParams(
        accessToken: accessToken,
        broadcasterId: _broadcasterId!,
        newPoll: newPoll,
      ),
    );
    createPollResult.fold(
      (l) => {},
      (r) => {},
    );
  }

  // status is either TERMINATED to end poll and display the result to viewer
  // or ARCHIVED to end the poll and hide it
  Future<void> endPoll(String status) async {
    final endPollResult = await endPollUseCase(
      params: EndPollUseCaseParams(
        accessToken: accessToken,
        broadcasterId: _broadcasterId!,
        pollId: currentPoll.value.id,
        status: status,
      ),
    );
    endPollResult.fold(
      (l) => {},
      (r) => {},
    );
  }

  // status is either RESOLVED to end prediction with a winner (should provide winning_outcome_id)
  // or CANCELED to end the prediction and refund
  // or LOCKED to lock prediction so user can no longer make predictions
  void endPrediction(String status, String? winningOutcomeId) {
    endPredictionUseCase(
      params: EndPredictionUseCaseParams(
        accessToken: accessToken,
        broadcasterId: _broadcasterId!,
        predictionId: currentPrediction.value.id,
        status: status,
        winningOutcomeId: winningOutcomeId,
      ),
    );
  }
}
