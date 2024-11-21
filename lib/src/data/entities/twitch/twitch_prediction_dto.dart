import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';

part 'twitch_prediction_dto.freezed.dart';
part 'twitch_prediction_dto.g.dart';

@freezed
class TwitchPredictionDTO with _$TwitchPredictionDTO {
  const factory TwitchPredictionDTO({
    required String id,
    required String title,
    required String winningOutcomeId,
    required int totalUsers,
    required List<OutcomeDTO> outcomes,
    required PredictionStatus status,
    required DateTime remainingTime,
  }) = _TwitchPredictionDTO;

  factory TwitchPredictionDTO.fromJson(Map<String, dynamic> map) {
    List<OutcomeDTO> outcomes = [];
    int totalUsers = 0;
    PredictionStatus status = PredictionStatus.active;

    OutcomeDTO o;
    map['outcomes'].forEach((outcome) => {
          o = OutcomeDTO.fromJson(outcome),
          outcomes.add(o),
          totalUsers += o.users,
        },);

    if (map['locked_at'] != null) {
      status = PredictionStatus.locked;
    }

    switch (map["status"]) {
      case "resolved":
        status = PredictionStatus.resolved;
        break;
      case "canceled":
        status = PredictionStatus.canceled;
        break;
    }

    DateFormat df = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime endsAt =
        df.parse(map['locks_at'] ?? map['locked_at'] ?? map['ended_at']);

    return TwitchPredictionDTO(
      id: map['id'],
      title: map['title'],
      outcomes: outcomes,
      totalUsers: totalUsers,
      winningOutcomeId: map["winning_outcome_id"] ?? '',
      status: status,
      remainingTime: endsAt,
    );
  }
}

@freezed
class OutcomeDTO with _$OutcomeDTO {
  const factory OutcomeDTO({
    required String id,
    required String title,
    @Default(0) int users,
    @JsonKey(name: 'channel_points')
    @Default(0) int channelPoints,
    @ColorConverter() required Color color,
  }) = _OutcomeDTO;

  factory OutcomeDTO.fromJson(Map<String, dynamic> json) => _$OutcomeDTOFromJson(json);
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String color) {
    switch (color) {
      case "pink":
        return Colors.pink;
      case "blue":
        return Colors.blue;
      default:
        return Colors.blue; // Default to blue
    }
  }

  @override
  String toJson(Color color) {
    if (color == Colors.pink) {
      return "pink";
    } else if (color == Colors.blue) {
      return "blue";
    } else {
      return "blue"; // Default to blue if no match
    }
  }
}