import 'package:intl/intl.dart';

import '../../../domain/entities/twitch/twitch_hype_train.dart';

class TwitchHypeTrainDTO extends TwitchHypeTrain {
  const TwitchHypeTrainDTO({
    required super.id,
    required super.total,
    required super.progress,
    required super.goal,
    required super.level,
    required super.topContributions,
    required super.lastContribution,
    required super.endsAt,
  });

  @override
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

  factory TwitchHypeTrainDTO.fromJson(Map<String, dynamic> map) {
    List<Contribution> topContributions = [];

    Contribution c;
    map['top_contributions'].forEach((contribution) => {
          c = ContributionDTO.fromJson(contribution),
          topContributions.add(c),
        });

    DateFormat df = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime endsAt = df.parse(map['expires_at'] ?? map['ended_at']);

    return TwitchHypeTrainDTO(
      id: map['id'],
      total: map['total'],
      progress: map['progress'] ?? 0,
      goal: map['goal'] ?? 0,
      level: map['level'],
      topContributions: topContributions,
      lastContribution: map['last_contribution'] != null
          ? ContributionDTO.fromJson(map['last_contribution'])
          : null,
      endsAt: endsAt,
    );
  }
}

class ContributionDTO extends Contribution {
  const ContributionDTO({
    required super.userId,
    required super.userLogin,
    required super.userName,
    required super.type,
    required super.total,
  });

  factory ContributionDTO.fromJson(Map<String, dynamic> map) {
    return ContributionDTO(
      total: map['total'],
      userId: map['user_id'],
      userLogin: map['user_login'],
      userName: map['user_name'],
      type: map['type'],
    );
  }
}
