import 'dart:ui';

import 'package:equatable/equatable.dart';

enum DashboardActionsTypes {
  toggle,
  button,
  slider,
}

enum DashboardActionsProvider {
  custom,
  twitch,
  obs,
  streamElements,
}

// ignore: must_be_immutable
class FloatingEvent extends Equatable {
  final String title;
  final Color color;
  final DashboardActionsTypes dashboardActionsType;
  final DashboardActionsProvider dashboardActionsProvider;
  Function(dynamic v)? action;

  FloatingEvent({
    required this.title,
    required this.color,
    required this.dashboardActionsType,
    required this.dashboardActionsProvider,
    this.action,
  });

  @override
  List<Object?> get props {
    return [
      title,
      color,
      dashboardActionsType,
      dashboardActionsProvider,
      action,
    ];
  }

  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'dashboardActionsProvider': dashboardActionsProvider,
        'action': action,
      };

  @override
  bool get stringify => true;

  FloatingEvent copyWith({
    String? title,
    Color? color,
    DashboardActionsTypes? dashboardActionsType,
    DashboardActionsProvider? dashboardActionsProvider,
    Function(dynamic v)? action,
  }) {
    return FloatingEvent(
      title: title ?? this.title,
      color: color ?? this.color,
      dashboardActionsType: dashboardActionsType ?? this.dashboardActionsType,
      dashboardActionsProvider: dashboardActionsProvider ?? this.dashboardActionsProvider,
      action: action ?? this.action,
    );
  }
}
