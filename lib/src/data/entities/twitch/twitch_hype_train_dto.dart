import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'twitch_hype_train_dto.freezed.dart';
part 'twitch_hype_train_dto.g.dart';

@freezed
class TwitchHypeTrainDTO with _$TwitchHypeTrainDTO {
  const factory TwitchHypeTrainDTO({
    required String id,
    required int total,
    required int progress,
    required int goal,
    required int level,
    required List<ContributionDTO> topContributions,
    required ContributionDTO? lastContribution,
    required DateTime endsAt,
  }) = _TwitchHypeTrainDTO;

  factory TwitchHypeTrainDTO.fromJson(Map<String, dynamic> map) {
    List<ContributionDTO> topContributions = [];

    ContributionDTO c;
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

@freezed
class ContributionDTO with _$ContributionDTO {
  const factory ContributionDTO({
    @JsonKey(name: 'user_id')
    required String userId,
    @JsonKey(name: 'user_login')
    required String userLogin,
    @JsonKey(name: 'user_name')
    required String userName,
    required String type,
    required int total,
  }) = _ContributionDTO;

  factory ContributionDTO.fromJson(Map<String, dynamic> json) => _$ContributionDTOFromJson(json);
}
