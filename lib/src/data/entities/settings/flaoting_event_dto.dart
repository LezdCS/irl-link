import 'package:flutter/material.dart';
import 'package:irllink/src/domain/entities/settings/floating_event.dart';

class FloatingEventDTO extends FloatingEvent {
  const FloatingEventDTO({
    required String? title,
    required DashboardActionsTypes dashboardActionsType,
    required Color color,
  }) : super(
          title: title,
          dashboardActionsType: dashboardActionsType,
          color: color,
        );

  Map toJson() => {
        'title': title,
        'dashboardActionsType': dashboardActionsType,
        'color': color,
      };

  factory FloatingEventDTO.fromJson(Map<String, dynamic> map) {
    return FloatingEventDTO(
      title: map['title'] ?? "None",
      dashboardActionsType:
          map['dashboardActionsType'] ?? DashboardActionsTypes.button,
      color: map['color'] ?? Colors.grey,
    );
  }
}
