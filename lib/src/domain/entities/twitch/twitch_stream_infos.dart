import 'package:flutter/material.dart';

@immutable
class TwitchStreamInfos {
  final String? title;
  final int? viewerCount;
  final bool? isOnline;
  final Duration? startedAtDuration;
  final bool? isEmoteMode;
  final bool? isFollowerMode;
  final bool? isSlowMode;
  final int? slowModeWaitTime;
  final bool? isSubscriberMode;

  const TwitchStreamInfos({
    required this.title,
    required this.viewerCount,
    required this.isOnline,
    required this.startedAtDuration,
    required this.isEmoteMode,
    required this.isFollowerMode,
    required this.isSlowMode,
    required this.slowModeWaitTime,
    required this.isSubscriberMode,
  });

  const TwitchStreamInfos.defaultInfos({
    this.title = "",
    this.viewerCount = 0,
    this.isOnline = false,
    this.startedAtDuration = const Duration(minutes: 0),
    this.isEmoteMode = false,
    this.isFollowerMode = false,
    this.isSlowMode = false,
    this.slowModeWaitTime = 30,
    this.isSubscriberMode = false,
  });

  TwitchStreamInfos copyWith({
    String? title,
    int? viewerCount,
    bool? isOnline,
    Duration? startedAtDuration,
    bool? isEmoteMode,
    bool? isFollowerMode,
    bool? isSlowMode,
    int? slowModeWaitTime,
    bool? isSubscriberMode,
  }) =>
      TwitchStreamInfos(
        title: title ?? this.title,
        viewerCount: viewerCount ?? this.viewerCount,
        isOnline: isOnline ?? this.isOnline,
        startedAtDuration: startedAtDuration ?? this.startedAtDuration,
        isEmoteMode: isEmoteMode ?? this.isEmoteMode,
        isFollowerMode: isFollowerMode ?? this.isFollowerMode,
        isSubscriberMode: isSubscriberMode ?? this.isSubscriberMode,
        isSlowMode: isSlowMode ?? this.isSlowMode,
        slowModeWaitTime: slowModeWaitTime ?? this.slowModeWaitTime,
      );

  
}
