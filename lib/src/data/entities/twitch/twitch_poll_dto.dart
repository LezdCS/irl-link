import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';

part 'twitch_poll_dto.freezed.dart';
part 'twitch_poll_dto.g.dart';

@freezed
class TwitchPollDTO with _$TwitchPollDTO {
  const factory TwitchPollDTO({
    required String id,
    required String title,
    required List<ChoiceDTO> choices,
    required int totalVotes,
    required PollStatus status,
    required DateTime endsAt,
  }) = _TwitchPollDTO;

  factory TwitchPollDTO.fromJson(Map<String, dynamic> map) {
    List<ChoiceDTO> choices = [];
    int totalVotes = 0;
    PollStatus status = PollStatus.active;

    ChoiceDTO c;
    map['choices'].forEach((choice) => {
          c = ChoiceDTO.fromJson(choice),
          choices.add(c),
          totalVotes += c.votes,
        });

    switch (map["status"]) {
      case "completed":
        status = PollStatus.completed;
        break;
      default:
        status = PollStatus.active;
    }

    DateFormat df = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime endsAt = df.parse(map['ends_at'] ?? map['ended_at']);

    return TwitchPollDTO(
      id: map['id'],
      title: map['title'],
      choices: choices,
      totalVotes: totalVotes,
      status: status,
      endsAt: endsAt,
    );
  }
}

@freezed
class ChoiceDTO with _$ChoiceDTO {
  const factory ChoiceDTO({
    required String id,
    required String title,
    @Default(0) int votes,
  }) = _ChoiceDTO;

  factory ChoiceDTO.fromJson(Map<String, dynamic> json) => _$ChoiceDTOFromJson(json);
}
