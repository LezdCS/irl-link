class TwitchHypeTrain {
  final String id;
  final int total;
  final int progress;
  final int goal;
  final int level;
  final List<Contribution> topContributions;
  final Contribution? lastContribution;
  final DateTime endsAt;

  const TwitchHypeTrain({
    required this.id,
    required this.total,
    required this.progress,
    required this.goal,
    required this.level,
    required this.topContributions,
    required this.lastContribution,
    required this.endsAt,
  });

  factory TwitchHypeTrain.empty() {
    return TwitchHypeTrain(
      id: '',
      total: 0,
      progress: 0,
      goal: 0,
      level: 0,
      topContributions: const [],
      endsAt: DateTime.now(),
      lastContribution: null,
    );
  }
}

class Contribution {
  final String userId;
  final String userLogin;
  final String userName;
  final String type;
  final int total;

  const Contribution({
    required this.userId,
    required this.userLogin,
    required this.userName,
    required this.type,
    required this.total,
  });
}
