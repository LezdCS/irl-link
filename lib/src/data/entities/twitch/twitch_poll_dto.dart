import 'package:intl/intl.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';

class TwitchPollDTO extends TwitchPoll {
  const TwitchPollDTO({
    required super.id,
    required super.title,
    required super.choices,
    required super.totalVotes,
    required super.status,
    required super.endsAt,
  });

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'totalVotes': totalVotes,
        'status': status,
        'endsAt': endsAt,
      };

  factory TwitchPollDTO.fromJson(Map<String, dynamic> map) {
    List<Choice> choices = [];
    int totalVotes = 0;
    PollStatus status = PollStatus.active;

    Choice c;
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

class ChoiceDTO extends Choice {
  const ChoiceDTO({
    required super.id,
    required super.title,
    required super.votes,
  });

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'votes': votes,
      };

  factory ChoiceDTO.fromJson(Map<String, dynamic> map) {
    return ChoiceDTO(
      id: map['id'],
      title: map['title'],
      votes: map['votes'] ?? 0,
    );
  }
}
