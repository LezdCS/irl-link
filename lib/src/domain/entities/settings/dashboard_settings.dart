import 'package:equatable/equatable.dart';

import '../dashboard_event.dart';

class DashboardSettings extends Equatable {
  final List<DashboardEvent> userEvents;

  const DashboardSettings({
    required this.userEvents,
  });

  @override
  List<Object?> get props {
    return [
      userEvents,
    ];
  }

  Map toJson() => {
        'userEvents': userEvents,
      };

  @override
  bool get stringify => true;

  DashboardSettings copyWith({
    List<DashboardEvent>? userEvents,
  }) {
    return DashboardSettings(
      userEvents: userEvents ?? this.userEvents,
    );
  }
}
