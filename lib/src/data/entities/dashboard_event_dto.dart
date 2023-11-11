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

  factory DashboardEventDTO.fromJson(Map<String, dynamic> map) {
    DashboardActionsTypes action = getActionFromString(map['dashboardActionsType']);
    SupportedEvents event = getEventFromString(map['event']);
    return DashboardEventDTO(
      title: map['title'] ?? "None",
      color: Color(map['color'] ?? '0xFF000000'),
      dashboardActionsType: action,
      event: event,
      customValue: map['customValue'],
    );
  }
}

// Get the action type from a string
DashboardActionsTypes getActionFromString(String actionAsString) {
  for (DashboardActionsTypes element in DashboardActionsTypes.values) {
    if (element.name == actionAsString) {
      return element;
    }
  }
  return DashboardActionsTypes.button;
}

// Get the event type from a string
SupportedEvents getEventFromString(String eventAsString) {
  for (SupportedEvents element in SupportedEvents.values) {
    if (element.name == eventAsString) {
      return element;
    }
  }
  return SupportedEvents.none;
}
