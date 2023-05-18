import 'dart:ui';

import 'package:equatable/equatable.dart';

enum DashboardActions {
  noAction,

  //obs
  obsStartStream,
  obsStopStream,
  obsStartRecording,
  obsStopRecording,
  obsToggleStream,
  obsToggleRecording,
  obsSourceMediaVolume,
  obsSwitchScene,
  // obsRefreshBrowserSource,
  // obsTriggerHotkey,
  // obsSwitchProfile,

  //twitch
  twitchChatOnlyFollow,
  twitchChatOnlySub,
  // twitchAddStreamMarker,
  // twitchCreateMoment,
  twitchChatSendMessage,

  //tts
  ttsEnabled,
  ttsVolume,
  ttsClearQueue
}

enum DashboardActionsTypes {
  toggle,
  button,
  slider,
}

class FloatingEvent extends Equatable {
  final String? title;
  final DashboardActionsTypes dashboardActionsType;
  final Color color;

  const FloatingEvent({
    this.title,
    required this.dashboardActionsType,
    required this.color,
  });

  @override
  List<Object?> get props {
    return [
      title,
      dashboardActionsType,
      color,
    ];
  }

  Map toJson() => {
    'title': title,
    'dashboardActionsType': dashboardActionsType,
    'color': color,
  };

  @override
  bool get stringify => true;

  FloatingEvent copyWith({
    String? title,
    DashboardActionsTypes? dashboardActionsType,
    Color? color,
  }) {
    return FloatingEvent(
      title: title ?? this.title,
      dashboardActionsType: dashboardActionsType ?? this.dashboardActionsType,
      color: color ?? this.color,
    );
  }
}
