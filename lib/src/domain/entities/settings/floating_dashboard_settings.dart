import 'package:equatable/equatable.dart';

import 'floating_event.dart';

class FloatingDashboardSettings extends Equatable {
  final List<FloatingEvent> userEvents;

  const FloatingDashboardSettings({
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

  FloatingDashboardSettings copyWith({
    List<FloatingEvent>? userEvents,
  }) {
    return FloatingDashboardSettings(
      userEvents: userEvents ?? this.userEvents,
    );
  }
}
