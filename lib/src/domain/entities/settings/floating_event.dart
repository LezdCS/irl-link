import 'dart:ui';

import 'package:equatable/equatable.dart';

enum DashboardActionsTypes {
  toggle,
  button,
  slider,
}

enum DashboardActionsProvider {
  custom,
  twitch,
  obs,
  streamElements,
}

enum SupportedEvents {
  none,
  obsStreamStart,
  obsStreamStop,
  obsRecordToggle,
  twitchFollowerOnly,
  twitchSubOnly,
  twitchEmoteOnly,
  twitchSlowMode,
  twitchCreatePrediction,
  twitchLockPrediction,
  twitchEndPrediction,
  twitchCancelPrediction,
  twitchCreatePoll,
  twitchCancelPoll,
  twitchEndPoll,
}

// ignore: must_be_immutable
class FloatingEvent extends Equatable {
  final String title;
  final Color color;
  final DashboardActionsTypes dashboardActionsType;
  final SupportedEvents event;

  const FloatingEvent({
    required this.title,
    required this.color,
    required this.dashboardActionsType,
    required this.event,
  });

  @override
  List<Object?> get props {
    return [
      title,
      color,
      dashboardActionsType,
      event,
    ];
  }

  Map toJson() => {
        'title': title,
        'color': color,
        'dashboardActionsType': dashboardActionsType,
        'event': event,
      };

  @override
  bool get stringify => true;

  FloatingEvent copyWith({
    String? title,
    Color? color,
    DashboardActionsTypes? dashboardActionsType,
    SupportedEvents? event,
  }) {
    return FloatingEvent(
      title: title ?? this.title,
      color: color ?? this.color,
      dashboardActionsType: dashboardActionsType ?? this.dashboardActionsType,
      event: event ?? this.event,
    );
  }
}
