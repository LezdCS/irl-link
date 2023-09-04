import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';

// ignore: must_be_immutable
class FloatingEventDTO extends FloatingEvent {
  FloatingEventDTO({
    required String title,
    required Color color,
    required DashboardActionsTypes dashboardActionsType,
    required DashboardActionsProvider dashboardActionsProvider,
    required Function(dynamic v) action,
  }) : super(
          title: title,
          color: color,
          dashboardActionsType: dashboardActionsType,
          dashboardActionsProvider: dashboardActionsProvider,
          action: action,
        );

  @override
  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'dashboardActionsProvider': dashboardActionsProvider,
        'action': action,
      };

  factory FloatingEventDTO.fromJson(Map<String, dynamic> map) {
    return FloatingEventDTO(
      title: map['title'] ?? "None",
      color: map['color'] ?? Colors.grey,
      dashboardActionsType:
          map['dashboardActionsType'] ?? DashboardActionsTypes.button,
      dashboardActionsProvider:
          map['dashboardActionsProvider'] ?? DashboardActionsProvider.custom,
      action: map['action'] ?? () => {},
    );
  }
}
