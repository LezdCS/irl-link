import 'dart:convert';

import 'package:irllink/src/domain/entities/settings/floating_dashboard_settings.dart';

import 'flaoting_event_dto.dart';

class FloatingDashboardSettingsDTO extends FloatingDashboardSettings {
  const FloatingDashboardSettingsDTO({
    required List<FloatingEventDTO> userEvents,
  }) : super(
          userEvents: userEvents,
        );

  @override
  Map toJson() => {
        'userEvents': jsonEncode(userEvents),
      };

  factory FloatingDashboardSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<FloatingEventDTO> userEvents = [];
    if (map['userEvents'] is! String) {
      map['userEvents'].forEach((element) {
        userEvents.add(FloatingEventDTO.fromJson(element));
      });
    }

    return FloatingDashboardSettingsDTO(
      userEvents: userEvents,
    );
  }
}
