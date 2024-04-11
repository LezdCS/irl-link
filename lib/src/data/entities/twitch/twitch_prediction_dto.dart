import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/twitch/twitch_prediction.dart';

class TwitchPredictionDTO extends TwitchPrediction {
  const TwitchPredictionDTO({
    required super.id,
    required super.title,
    required super.winningOutcomeId,
    required super.totalUsers,
    required super.outcomes,
    required super.status,
    required super.remainingTime,
  });

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'winningOutcomeId': winningOutcomeId,
        'totalUsers': totalUsers,
        'outcomes': outcomes,
        'status': status,
        'remainingTime': remainingTime,
      };

  factory TwitchPredictionDTO.fromJson(Map<String, dynamic> map) {
    List<Outcome> outcomes = [];
    int totalUsers = 0;
    PredictionStatus status = PredictionStatus.active;

    Outcome o;
    map['outcomes'].forEach((outcome) => {
          o = OutcomeDTO.fromJson(outcome),
          outcomes.add(o),
          totalUsers += o.users,
        });

    if (map['locked_at'] != null) {
      status = PredictionStatus.locked;
    }

    switch (map["status"]) {
      case "resolved":
        status = PredictionStatus.resolved;
        break;
      case "canceled":
        status = PredictionStatus.canceled;
        break;
    }

    DateFormat df = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime endsAt =
        df.parse(map['locks_at'] ?? map['locked_at'] ?? map['ended_at']);

    return TwitchPredictionDTO(
      id: map['id'],
      title: map['title'],
      outcomes: outcomes,
      totalUsers: totalUsers,
      winningOutcomeId: map["winning_outcome_id"] ?? '',
      status: status,
      remainingTime: endsAt,
    );
  }
}

class OutcomeDTO extends Outcome {
  const OutcomeDTO({
    required super.id,
    required super.title,
    required super.users,
    required super.channelPoints,
    required super.color,
  });

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'users': users,
        'channelPoints': channelPoints,
        'color': color,
      };

  factory OutcomeDTO.fromJson(Map<String, dynamic> map) {
    Color color;
    if (map['color'] == "pink") {
      color = Colors.pink;
    } else {
      color = Colors.blue;
    }
    return OutcomeDTO(
      id: map['id'],
      title: map['title'],
      users: map['users'] ?? 0,
      channelPoints: map['channel_points'] ?? 0,
      color: color,
    );
  }
}
