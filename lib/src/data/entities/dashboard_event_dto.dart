import 'package:flutter/material.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';

class DashboardEventDTO extends DashboardEvent {
  const DashboardEventDTO({
    required String title,
    required Color color,
    required DashboardActionsTypes dashboardActionsType,
    required SupportedEvents event,
    required dynamic customValue,
  }) : super(
          title: title,
          color: color,
          dashboardActionsType: dashboardActionsType,
          event: event,
          customValue: customValue,
        );

  @override
  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'event': event,
        'customValue': customValue,
      };

  factory DashboardEventDTO.fromJson(Map<String, dynamic> map) {
    return DashboardEventDTO(
      title: map['title'] ?? "None",
      color: map['color'] ?? Colors.grey,
      dashboardActionsType:
          map['dashboardActionsType'] ?? DashboardActionsTypes.button,
      event: map['event'] ?? SupportedEvents.none,
      customValue: map['customValue'],
    );
  }
}
