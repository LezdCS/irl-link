import '../dashboard_event.dart';
import 'package:flutter/material.dart';

@immutable
class DashboardSettings {
  final List<DashboardEvent> userEvents;
  final bool activated;

  const DashboardSettings({
    required this.userEvents,
    required this.activated,
  });

  DashboardSettings copyWith({
    List<DashboardEvent>? userEvents,
    bool? activated,
  }) {
    return DashboardSettings(
      userEvents: userEvents ?? this.userEvents,
      activated: activated ?? this.activated,
    );
  }
}
