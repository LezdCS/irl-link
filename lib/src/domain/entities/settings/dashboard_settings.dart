import '../dashboard_event.dart';

class DashboardSettings {
  final List<DashboardEvent> userEvents;
  final bool activated;

  const DashboardSettings({
    required this.userEvents,
    required this.activated,
  });

  Map toJson() => {
        'userEvents': userEvents.map((e) => e.toJson()).toList(),
        'activated': activated,
      };

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
