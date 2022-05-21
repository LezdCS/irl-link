import 'package:equatable/equatable.dart';

enum PollStatus {
  ACTIVE,
  COMPLETED,
  TERMINATED,
  ARCHIVED,
  MODERATED,
  INVALID,
}

class TwitchPoll extends Equatable {
  final String id;
  final String title;
  final List<Choice> choices;
  final String totalVotes;
  final PollStatus status;
  final String endedAt;

  const TwitchPoll({
    required this.id,
    required this.title,
    required this.choices,
    required this.totalVotes,
    required this.status,
    required this.endedAt,
  });

  Map toJson() => {
    'id': id,
    'title': title,
    'choices': choices,
    'totalVotes': totalVotes,
    'status': status,
    'endedAt': endedAt,
  };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      choices,
      totalVotes,
      status,
      endedAt,
    ];
  }

  @override
  bool get stringify => true;
}

class Choice extends Equatable {
  final String id;
  final String title;
  final String votes;

  const Choice({
    required this.id,
    required this.title,
    required this.votes,
  });

  Map toJson() => {
    'id': id,
    'title': title,
    'votes': votes,
  };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      votes,
    ];
  }

  @override
  bool get stringify => true;
}