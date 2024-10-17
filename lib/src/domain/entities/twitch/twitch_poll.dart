import 'package:flutter/material.dart';

enum PollStatus {
  empty,
  active,
  completed,
}

@immutable
class TwitchPoll {
  final String id;
  final String title;
  final List<Choice> choices;
  final int totalVotes;
  final PollStatus status;
  final DateTime endsAt;

  const TwitchPoll({
    required this.id,
    required this.title,
    required this.choices,
    required this.totalVotes,
    required this.status,
    required this.endsAt,
  });

  factory TwitchPoll.empty() {
    return TwitchPoll(
      id: '',
      title: '',
      choices: const [],
      totalVotes: 0,
      status: PollStatus.empty,
      endsAt: DateTime.now(),
    );
  }
}

@immutable
class Choice {
  final String id;
  final String title;
  final int votes;

  const Choice({
    required this.id,
    required this.title,
    required this.votes,
  });
}
