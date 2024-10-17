enum PollStatus {
  empty,
  active,
  completed,
}

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

  Map toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'totalVotes': totalVotes,
        'status': status,
        'endsAt': endsAt,
      };
  
}

class Choice {
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

}
