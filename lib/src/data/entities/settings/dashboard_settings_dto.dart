import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';

import '../dashboard_event_dto.dart';

class DashboardSettingsDTO extends DashboardSettings {
  const DashboardSettingsDTO({
    required List<DashboardEventDTO> userEvents,
  }) : super(
          userEvents: userEvents,
        );

  factory DashboardSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<DashboardEventDTO> userEvents = [];
    map['userEvents'].forEach((element) {
      userEvents.add(DashboardEventDTO.fromJson(element));
    });

    return DashboardSettingsDTO(
      userEvents: userEvents,
    );
  }
}
