import 'package:irllink/src/domain/entities/twitch_poll.dart';

class TwitchPollDTO extends TwitchPoll {
  const TwitchPollDTO({
    required String id,
    required String title,
    required List<Choice> choices,
    required int totalVotes,
    required PollStatus status,
  }) : super(
          id: id,
          title: title,
          choices: choices,
          totalVotes: totalVotes,
          status: status,
        );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'totalVotes': totalVotes,
        'status': status,
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
    return TwitchPollDTO(
      id: map['id'],
      title: map['title'],
      choices: choices,
      totalVotes: totalVotes,
      status: status,
    );
  }
}

class ChoiceDTO extends Choice {
  const ChoiceDTO({
    required String id,
    required String title,
    required int votes,
  }) : super(id: id, title: title, votes: votes);

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
      votes: map['votes'],
    );
  }
}
