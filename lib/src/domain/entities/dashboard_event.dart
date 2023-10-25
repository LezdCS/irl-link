import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:irllink/src/core/utils/dashboard_events.dart';

enum DashboardActionsTypes {
  toggle,
  button,
  slider,
}

// ignore: must_be_immutable
class DashboardEvent extends Equatable {
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

  @override
  List<Object?> get props {
    return [
      title,
      color,
      dashboardActionsType,
      event,
      customValue,
    ];
  }

  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'event': event,
        'customValue': customValue,
      };

  @override
  bool get stringify => true;

  DashboardEvent copyWith({
    String? title,
    Color? color,
    DashboardActionsTypes? dashboardActionsType,
    SupportedEvents? event,
    dynamic customValue,
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
