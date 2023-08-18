import 'package:intl/intl.dart';

import '../../../domain/entities/twitch/twitch_hype_train.dart';

class TwitchHypeTrainDTO extends TwitchHypeTrain {
  const TwitchHypeTrainDTO({
    required String id,
    required int total,
    required int progress,
    required int goal,
    required int level,
    required List<Contribution> topContributions,
    required Contribution? lastContribution,
    required Duration endsAt,
  }) : super(
          id: id,
          total: total,
          progress: progress,
          goal: goal,
          level: level,
          topContributions: topContributions,
          lastContribution: lastContribution,
          endsAt: endsAt,
        );

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
    DateTime now = df.parse(df.format(DateTime.now().toUtc()));
    Duration endsAtDuration = endsAt.difference(now);

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
      endsAt: endsAtDuration,
    );
  }
}

class ContributionDTO extends Contribution {
  const ContributionDTO({
    required String userId,
    required String userLogin,
    required String userName,
    required String type,
    required int total,
  }) : super(
            userId: userId,
            userLogin: userLogin,
            userName: userName,
            type: type,
            total: total);

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
