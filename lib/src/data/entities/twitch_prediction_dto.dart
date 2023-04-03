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
    PredictionStatus status = PredictionStatus.ACTIVE;

    Outcome o;
    map['outcomes'].forEach((outcome) => {
          o = OutcomeDTO.fromJson(outcome),
          outcomes.add(o),
          totalUsers += o.users,
        });

    switch (map["status"]) {
      case "RESOLVED":
        status = PredictionStatus.RESOLVED;
        break;
      case "ACTIVE":
        status = PredictionStatus.ACTIVE;
        break;
      case "CANCELED":
        status = PredictionStatus.CANCELED;
        break;
      case "LOCKED":
        status = PredictionStatus.LOCKED;
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

  Map toJson() => {
        'id': id,
        'title': title,
        'users': users,
        'channelPoints': channelPoints,
        'color': color,
      };

  factory OutcomeDTO.fromJson(Map<String, dynamic> map) {
    Color color;
    if (map['color'] == "PINK") {
      color = Colors.pink;
    } else {
      color = Colors.blue;
    }
    return OutcomeDTO(
      id: map['id'],
      title: map['title'],
      users: int.parse(map['users']),
      channelPoints: int.parse(map['channelPoints']),
      color: color,
    );
  }
}
