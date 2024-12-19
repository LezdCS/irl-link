import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';

part 'dashboard_event_dto.freezed.dart';
part 'dashboard_event_dto.g.dart';

@freezed
class DashboardEventDTO with _$DashboardEventDTO {
  const factory DashboardEventDTO({
    @Default('None') String title,
    @ColorConverter() required Color color,
    required DashboardActionsTypes dashboardActionsType,
    required SupportedEvents event,
    // The customValue needs to be dynamic since it can be of different types
    // depending on the event type
    // ignore: avoid_annotating_with_dynamic
    required dynamic customValue,
  }) = _DashboardEventDTO;

  factory DashboardEventDTO.fromJson(Map<String, dynamic> json) =>
      _$DashboardEventDTOFromJson(json);
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) {
    return Color(json);
  }

  @override
  int toJson(Color color) {
    return (color.a.toInt() << 24) |
        (color.r.toInt() << 16) |
        (color.g.toInt() << 8) |
        color.b.toInt();
  }
}
