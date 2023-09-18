import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';

class FloatingEventDTO extends FloatingEvent {
  const FloatingEventDTO({
    required String title,
    required Color color,
    required DashboardActionsTypes dashboardActionsType,
    required SupportedEvents event,
  }) : super(
          title: title,
          color: color,
          dashboardActionsType: dashboardActionsType,
          event: event,
        );

  @override
  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'event': event,
      };

  factory FloatingEventDTO.fromJson(Map<String, dynamic> map) {
    return FloatingEventDTO(
      title: map['title'] ?? "None",
      color: map['color'] ?? Colors.grey,
      dashboardActionsType:
          map['dashboardActionsType'] ?? DashboardActionsTypes.button,
      event: map['event'] ?? SupportedEvents.none,
    );
  }
}
