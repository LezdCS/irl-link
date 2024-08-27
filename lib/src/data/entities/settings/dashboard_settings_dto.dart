import 'package:irllink/src/data/entities/dashboard_event_dto.dart';
import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';

class DashboardSettingsDTO extends DashboardSettings {
  const DashboardSettingsDTO({
    required List<DashboardEventDTO> super.userEvents,
    required super.activated,
  });

  factory DashboardSettingsDTO.fromJson(Map<String, dynamic> map) {
    List<DashboardEventDTO> userEvents = [];
    map['userEvents'].forEach((element) {
      userEvents.add(DashboardEventDTO.fromJson(element));
    });

    return DashboardSettingsDTO(
      userEvents: userEvents,
      activated: map['activated'],
    );
  }
}
