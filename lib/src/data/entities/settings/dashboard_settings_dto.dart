import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/data/entities/dashboard_event_dto.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';

class DashboardSettingsDTO extends DashboardSettings {
  const DashboardSettingsDTO({
    required super.userEvents,
    required super.activated,
  });

  Map<String, dynamic> toJson() {
    Mappr mappr = Mappr();
    List<Map<String, dynamic>> userEventsList = 
      userEvents.map((event) => 
      mappr.convert<DashboardEvent, DashboardEventDTO>(event).toJson()
      ).toList();

    return {
      'userEvents': userEventsList,
      'activated': activated,
    };
  }

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
