import 'package:equatable/equatable.dart';

enum PollStatus {
  empty,
  active,
  completed,
}

class TwitchPoll extends Equatable {
  final String id;
  final String title;
  final List<Choice> choices;
  final int totalVotes;
  final PollStatus status;
  final Duration remainingTime;

  const TwitchPoll({
    required this.id,
    required this.title,
    required this.choices,
    required this.totalVotes,
    required this.status,
    required this.remainingTime,
  });

  factory TwitchPoll.empty() {
    return const TwitchPoll(
      id: '',
      title: '',
      choices: [],
      totalVotes: 0,
      status: PollStatus.empty,
      remainingTime: Duration(seconds: 0),
    );
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'totalVotes': totalVotes,
        'status': status,
        'remainingTime': remainingTime,
      };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      choices,
      totalVotes,
      status,
      remainingTime,
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
