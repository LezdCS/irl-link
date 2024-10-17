import 'dart:ui';

enum PredictionStatus {
  empty,
  resolved,
  active,
  canceled,
  locked,
}

class TwitchPrediction {
  final String id;
  final String title;
  final String winningOutcomeId;
  final int totalUsers;
  final List<Outcome> outcomes;
  final PredictionStatus status;
  final DateTime remainingTime;

  const TwitchPrediction({
    required this.id,
    required this.title,
    required this.winningOutcomeId,
    required this.totalUsers,
    required this.outcomes,
    required this.status,
    required this.remainingTime,
  });

  factory TwitchPrediction.empty() {
    return TwitchPrediction(
      id: '',
      title: '',
      winningOutcomeId: '',
      totalUsers: 0,
      outcomes: const [],
      status: PredictionStatus.empty,
      remainingTime: DateTime.now(),
    );
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'winningOutcomeId': winningOutcomeId,
        'totalUsers': totalUsers,
        'outcomes': outcomes,
        'status': status,
        'remainingTime': remainingTime,
      };
  
}

class Outcome {
  final String id;
  final String title;
  final int users;
  final int channelPoints;
  final Color color;

  const Outcome({
    required this.id,
    required this.title,
    required this.users,
    required this.channelPoints,
    required this.color,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'users': users,
        'channelPoints': channelPoints,
        'color': color,
      };
}
