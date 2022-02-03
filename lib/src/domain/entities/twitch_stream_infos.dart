import 'package:equatable/equatable.dart';

class TwitchStreamInfos extends Equatable {
  final String? title;
  final int? viewerCount;
  final bool? isOnline;
  final bool? isEmoteMode;
  final bool? isFollowerMode;
  final bool? isSlowMode;
  final bool? isSubscriberMode;

  const TwitchStreamInfos({
    required this.title,
    required this.viewerCount,
    required this.isOnline,
    required this.isEmoteMode,
    required this.isFollowerMode,
    required this.isSlowMode,
    required this.isSubscriberMode,
  });

  TwitchStreamInfos.defaultInfos({
    this.title = "",
    this.viewerCount = 0,
    this.isOnline = false,
    this.isEmoteMode = false,
    this.isFollowerMode = false,
    this.isSlowMode = false,
    this.isSubscriberMode = false,
  });

  Map toJson() => {
        'title': title,
        'viewerCount': viewerCount,
        'isOnline': isOnline,
        'isEmoteMode': isEmoteMode,
        'isFollowerMode': isFollowerMode,
        'isSlowMode': isSlowMode,
        'isSubscriberMode': isSubscriberMode,
      };

  @override
  List<Object?> get props {
    return [
      title,
      viewerCount,
      isOnline,
      isEmoteMode,
      isFollowerMode,
      isSlowMode,
      isSubscriberMode
    ];
  }

  TwitchStreamInfos copyWith({
    String? title,
    int? viewerCount,
    bool? isOnline,
    bool? isEmoteMode,
    bool? isFollowerMode,
    bool? isSlowMode,
    bool? isSubscriberMode,
  }) =>
      TwitchStreamInfos(
        title: title ?? this.title,
        viewerCount: viewerCount ?? this.viewerCount,
        isOnline: isOnline ?? this.isOnline,
        isEmoteMode: isEmoteMode ?? this.isEmoteMode,
        isFollowerMode: isFollowerMode ?? this.isFollowerMode,
        isSubscriberMode: isSubscriberMode ?? this.isSubscriberMode,
        isSlowMode: isSlowMode ?? this.isSlowMode,
      );

  @override
  bool get stringify => true;
}
