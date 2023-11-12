import 'package:equatable/equatable.dart';

import '../dashboard_event.dart';

class DashboardSettings extends Equatable {
  final List<DashboardEvent> userEvents;
  final bool activated;

  const DashboardSettings({
    required this.userEvents,
    required this.activated,
  });

  @override
  List<Object?> get props {
    return [
      userEvents,
      activated,
    ];
  }

  Map toJson() => {
        'userEvents': userEvents.map((e) => e.toJson()).toList(),
        'activated': activated,
      };

  @override
  bool get stringify => true;

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
