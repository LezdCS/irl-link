import 'package:equatable/equatable.dart';

enum PollStatus {
  active,
  completed,
  terminated,
  archived,
  moderated,
  invalid,
}

class TwitchPoll extends Equatable {
  final String id;
  final String title;
  final List<Choice> choices;
  final int totalVotes;
  final PollStatus status;

  const TwitchPoll({
    required this.id,
    required this.title,
    required this.choices,
    required this.totalVotes,
    required this.status,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'totalVotes': totalVotes,
        'status': status,
      };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      choices,
      totalVotes,
      status,
    ];
  }

  @override
  bool get stringify => true;
}

class Choice extends Equatable {
  final String id;
  final String title;
  final int votes;

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
