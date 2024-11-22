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
    required customValue,
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
  int toJson(Color object) {
    return object.value;
  }
}
