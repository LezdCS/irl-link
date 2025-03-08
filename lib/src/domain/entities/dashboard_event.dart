import 'package:flutter/material.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';

enum DashboardActionsTypes {
  toggle,
  button,
  slider,
}

// Function returning a string based on the action type
String getDashboardActionTypeString(DashboardActionsTypes actionType) {
  switch (actionType) {
    case DashboardActionsTypes.toggle:
      return 'Toggle';
    case DashboardActionsTypes.button:
      return 'Button';
    case DashboardActionsTypes.slider:
      return 'Slider';
  }
}

@immutable
class DashboardEvent {
  final String title;
  final Color color;
  final DashboardActionsTypes dashboardActionsType;
  final SupportedEvents event;
  final dynamic customValue;

  const DashboardEvent({
    required this.title,
    required this.color,
    required this.dashboardActionsType,
    required this.event,
    required this.customValue,
  });

  DashboardEvent copyWith({
    String? title,
    Color? color,
    DashboardActionsTypes? dashboardActionsType,
    SupportedEvents? event,
    customValue,
  }) {
    return DashboardEvent(
      title: title ?? this.title,
      color: color ?? this.color,
      dashboardActionsType: dashboardActionsType ?? this.dashboardActionsType,
      event: event ?? this.event,
      customValue: customValue ?? this.customValue,
    );
  }
}
