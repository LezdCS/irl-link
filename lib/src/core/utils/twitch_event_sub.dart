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

  ValueNotifier<TwitchPoll?> currentPoll = ValueNotifier<TwitchPoll?>(null);
  ValueNotifier<TwitchPrediction?> currentPrediction = ValueNotifier<TwitchPrediction?>(null);
  ValueNotifier<TwitchHypeTrain?> currentHypeTrain = ValueNotifier<TwitchHypeTrain?>(null);

  TwitchEventSub(
    this.channelName,
    this.accessToken,
  );

  void connect() async {
    _broadcasterId = await _getChannelId();

    _webSocketChannel =
        IOWebSocketChannel.connect("wss://eventsub.wss.twitch.tv/ws");

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

    if (msgMapped['metadata'] != null && msgMapped['metadata']['message_type'] == 'session_welcome') {
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

      // fakeData();
    }

    if (msgMapped['subscription'] != null) {
      switch (msgMapped['subscription']['type']) {
        //POLLS
        case 'channel.poll.begin':
          currentPoll.value = TwitchPollDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.poll.progress':
          currentPoll.value = TwitchPollDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.poll.end':
          currentPoll.value = TwitchPollDTO.fromJson(msgMapped['event']);
          Future.delayed(const Duration(seconds: 20)).then((value) => 
            currentPoll.value = null
          );
          break;

        //PREDICTIONS
        case 'channel.prediction.begin':
          currentPrediction.value = TwitchPredictionDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.prediction.progress':
          currentPrediction.value = TwitchPredictionDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.prediction.lock':
          currentPrediction.value = TwitchPredictionDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.prediction.end':
          currentPrediction.value = TwitchPredictionDTO.fromJson(msgMapped['event']);
          Future.delayed(const Duration(seconds: 20)).then((value) => 
            currentPrediction.value = null
          );
          break;

        //HYPE TRAIN
        case 'channel.hype_train.begin':
          currentHypeTrain.value = TwitchHypeTrainDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.hype_train.progress':
          currentHypeTrain.value = TwitchHypeTrainDTO.fromJson(msgMapped['event']);
          break;
        case 'channel.hype_train.end':
          currentHypeTrain.value = TwitchHypeTrainDTO.fromJson(msgMapped['event']);
          Future.delayed(const Duration(seconds: 20)).then((value) => 
            currentHypeTrain.value = null
          );
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

  void fakeData() async {
    // PREDICTIONS
    _eventListener(predictionBeginJson);
    await Future.delayed(const Duration(seconds: 10));
    _eventListener(predictionProgressJson);
    await Future.delayed(const Duration(seconds: 10));
    _eventListener(predictionLockJson);
    await Future.delayed(const Duration(seconds: 10));
    _eventListener(predictionEndJson);

    // POLLS
    _eventListener(pollBeginJson);
    await Future.delayed(const Duration(seconds: 10));
    _eventListener(pollProgressJson);
    await Future.delayed(const Duration(seconds: 10));
    _eventListener(pollEndJson);

    // HYPE TRAIN
    _eventListener(hypeBeginJson);
    await Future.delayed(const Duration(seconds: 4));
    _eventListener(hypeProgressJson);
    await Future.delayed(const Duration(seconds: 4));
    _eventListener(hypeEndJson);
  }
}

const String predictionBeginJson = '''
  {
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.prediction.begin",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "outcomes": [
            {"id": "1243456", "title": "Yeah!", "color": "blue"},
            {"id": "2243456", "title": "No!", "color": "pink"}
        ],
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "locks_at": "2020-07-15T17:21:03.17106713Z"
    }
}
''';

const String predictionProgressJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.prediction.progress",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "outcomes": [
            {
                "id": "1243456",
                "title": "Yeah!",
                "color": "blue",
                "users": 10,
                "channel_points": 15000,
                "top_predictors": [
                    {
                        "user_name": "Cool_User",
                        "user_login": "cool_user",
                        "user_id": "1234",
                        "channel_points_won": null,
                        "channel_points_used": 500
                    },
                    {
                        "user_name": "Coolest_User",
                        "user_login": "coolest_user",
                        "user_id": "1236",
                        "channel_points_won": null,
                        "channel_points_used": 200
                    }
                ]
            },
            {
                "id": "2243456",
                "title": "No!",
                "color": "pink",
                "top_predictors": [
                    {
                        "user_name": "Cooler_User",
                        "user_login": "cooler_user",
                        "user_id": 12345,
                        "channel_points_won": null,
                        "channel_points_used": 5000
                    }
                ]
            }
        ],
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "locks_at": "2023-08-18T19:21:03.17106713Z"
    }
}
''';

const String predictionLockJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.prediction.lock",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "outcomes": [
            {
                "id": "1243456",
                "title": "Yeah!",
                "color": "blue",
                "users": 10,
                "channel_points": 15000,
                "top_predictors": [
                    {
                        "user_name": "Cool_User",
                        "user_login": "cool_user",
                        "user_id": "1234",
                        "channel_points_won": null,
                        "channel_points_used": 500
                    },
                    {
                        "user_name": "Coolest_User",
                        "user_login": "coolest_user",
                        "user_id": "1236",
                        "channel_points_won": null,
                        "channel_points_used": 200
                    }
                ]
            },
            {
                "id": "2243456",
                "title": "No!",
                "color": "pink",
                "top_predictors": [
                    {
                        "user_name": "Cooler_User",
                        "user_login": "cooler_user",
                        "user_id": 12345,
                        "channel_points_won": null,
                        "channel_points_used": 5000
                    }
                ]
            }
        ],
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "locked_at": "2020-07-15T17:21:03.17106713Z"
    }
}
''';

const String predictionEndJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.prediction.end",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "winning_outcome_id": "12345",
        "outcomes": [
            {
                "id": "12345",
                "title": "Yeah!",
                "color": "blue",
                "users": 2,
                "channel_points": 15000,
                "top_predictors": [
                    {
                        "user_name": "Cool_User",
                        "user_login": "cool_user",
                        "user_id": "1234",
                        "channel_points_won": 10000,
                        "channel_points_used": 500
                    },
                    {
                        "user_name": "Coolest_User",
                        "user_login": "coolest_user",
                        "user_id": "1236",
                        "channel_points_won": 5000,
                        "channel_points_used": 100
                    }
                ]
            },
            {
                "id": "22435",
                "title": "No!",
                "users": 2,
                "channel_points": 200,
                "color": "pink",
                "top_predictors": [
                    {
                        "user_name": "Cooler_User",
                        "user_login": "cooler_user",
                        "user_id": 12345,
                        "channel_points_won": null,
                        "channel_points_used": 100
                    },
                    {
                        "user_name": "Elite_User",
                        "user_login": "elite_user",
                        "user_id": 1337,
                        "channel_points_won": null,
                        "channel_points_used": 100
                    }
                ]
            }
        ],
        "status": "resolved",
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "ended_at": "2020-07-15T17:16:11.17106713Z"
    }
}
''';

const String pollBeginJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.poll.begin",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "choices": [
            {"id": "123", "title": "Yeah!"},
            {"id": "124", "title": "No!"},
            {"id": "125", "title": "Maybe!"}
        ],
        "bits_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "channel_points_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "ends_at": "2020-07-15T17:16:08.17106713Z"
    }
}
''';

const String pollProgressJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.poll.progress",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "choices": [
            {"id": "123", "title": "Yeah!", "bits_votes": 5, "channel_points_votes": 7, "votes": 12},
            {"id": "124", "title": "No!", "bits_votes": 10, "channel_points_votes": 4, "votes": 14},
            {"id": "125", "title": "Maybe!", "bits_votes": 0, "channel_points_votes": 7, "votes": 7}
        ],
        "bits_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "channel_points_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "ends_at": "2020-07-15T17:16:08.17106713Z"
    }
}
''';

const String pollEndJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.poll.end",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1243456",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "title": "Aren’t shoes just really hard socks?",
        "choices": [
            {"id": "123", "title": "Blue", "bits_votes": 50, "channel_points_votes": 70, "votes": 120},
            {"id": "124", "title": "Yellow", "bits_votes": 100, "channel_points_votes": 40, "votes": 140},
            {"id": "125", "title": "Green", "bits_votes": 10, "channel_points_votes": 70, "votes": 80}
        ],
        "bits_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "channel_points_voting": {
            "is_enabled": true,
            "amount_per_vote": 10
        },
        "status": "completed",
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "ended_at": "2020-07-15T17:16:11.17106713Z"
    }
}
''';

const String hypeBeginJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.hype_train.begin",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1b0AsbInCHZW2SQFQkCzqN07Ib2",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "total": 137,
        "progress": 137,
        "goal": 500,
        "top_contributions": [
            { "user_id": "123", "user_login": "pogchamp", "user_name": "PogChamp", "type": "bits", "total": 50 },
            { "user_id": "456", "user_login": "kappa", "user_name": "Kappa", "type": "subscription", "total": 45 }
        ],
        "last_contribution": { "user_id": "123", "user_login": "pogchamp", "user_name": "PogChamp", "type": "bits", "total": 50 },
        "level": 2,
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "expires_at": "2023-08-18T06:21:03.17106713Z"
    }
}
''';

const String hypeProgressJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.hype_train.progress",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1b0AsbInCHZW2SQFQkCzqN07Ib2",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "level": 2,
        "total": 700,
        "progress": 200,
        "goal": 1000,
        "top_contributions": [
            { "user_id": "123", "user_login": "pogchamp", "user_name": "PogChamp", "type": "bits", "total": 50 },
            { "user_id": "456", "user_login": "kappa", "user_name": "Kappa", "type": "subscription", "total": 45 }
        ],
        "last_contribution": { "user_id": "123", "user_login": "pogchamp", "user_name": "PogChamp", "type": "bits", "total": 50 },
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "expires_at": "2023-08-18T06:21:03.17106713Z"
    }
}
''';

const String hypeEndJson = '''
{
    "subscription": {
        "id": "f1c2a387-161a-49f9-a165-0f21d7a4e1c4",
        "type": "channel.hype_train.end",
        "version": "1",
        "status": "enabled",
        "cost": 0,
        "condition": {
            "broadcaster_user_id": "1337"
        },
         "transport": {
            "method": "webhook",
            "callback": "https://example.com/webhooks/callback"
        },
        "created_at": "2019-11-16T10:11:12.634234626Z"
    },
    "event": {
        "id": "1b0AsbInCHZW2SQFQkCzqN07Ib2",
        "broadcaster_user_id": "1337",
        "broadcaster_user_login": "cool_user",
        "broadcaster_user_name": "Cool_User",
        "level": 2,
        "total": 137,
        "top_contributions": [
            { "user_id": "123", "user_login": "pogchamp", "user_name": "PogChamp", "type": "bits", "total": 50 },
            { "user_id": "456", "user_login": "kappa", "user_name": "Kappa", "type": "subscription", "total": 45 }
        ],
        "started_at": "2020-07-15T17:16:03.17106713Z",
        "ended_at": "2023-08-18T04:35:03.17106713Z",
        "cooldown_ends_at": "2020-07-15T18:16:11.17106713Z"
    }
}
''';