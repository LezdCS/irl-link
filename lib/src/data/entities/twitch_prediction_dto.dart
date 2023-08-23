import 'package:flutter/material.dart';
import '../../domain/entities/twitch_prediction.dart';

class TwitchPredictionDTO extends TwitchPrediction {
  const TwitchPredictionDTO({
    required String id,
    required String title,
    required String winningOutcomeId,
    required int totalUsers,
    required List<Outcome> outcomes,
    required PredictionStatus status,
  }) : super(
          id: id,
          title: title,
          winningOutcomeId: winningOutcomeId,
          totalUsers: totalUsers,
          outcomes: outcomes,
          status: status,
        );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'winningOutcomeId': winningOutcomeId,
        'totalUsers': totalUsers,
        'outcomes': outcomes,
        'status': status,
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
    return TwitchPredictionDTO(
      id: map['id'],
      title: map['title'],
      outcomes: outcomes,
      totalUsers: totalUsers,
      winningOutcomeId: map["winning_outcome_id"] ?? '',
      status: status,
    );
  }
}

class OutcomeDTO extends Outcome {
  const OutcomeDTO({
    required String id,
    required String title,
    required int users,
    required int channelPoints,
    required Color color,
  }) : super(
            id: id,
            title: title,
            users: users,
            channelPoints: channelPoints,
            color: color);

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
