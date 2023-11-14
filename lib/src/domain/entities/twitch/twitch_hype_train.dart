import 'package:equatable/equatable.dart';

class TwitchHypeTrain extends Equatable {
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
      topContributions: [],
      endsAt: DateTime.now(),
      lastContribution: null,
    );
  }

  Map toJson() => {
        'id': id,
        'total': total,
        'progress': progress,
        'goal': goal,
        'level': level,
        'topContributions': topContributions,
        'lastContribution': lastContribution,
        'endsAt': endsAt,
      };

  @override
  List<Object?> get props {
    return [
      id,
      total,
      progress,
      goal,
      level,
      topContributions,
      lastContribution,
      endsAt,
    ];
  }

  @override
  bool get stringify => true;
}

class Contribution extends Equatable {
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

  Map toJson() => {
        'userId': userId,
        'userLogin': userLogin,
        'userName': userName,
        'type': type,
        'total': total,
      };

  @override
  List<Object?> get props {
    return [
      userId,
      userLogin,
      userName,
      type,
      total,
    ];
  }

  @override
  bool get stringify => true;
}
