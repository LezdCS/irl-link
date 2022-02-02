import 'package:equatable/equatable.dart';

class TwitchStreamInfos extends Equatable {
  final String title;
  final int viewerCount;
  final bool isOnline;

  const TwitchStreamInfos({
    required this.title,
    required this.viewerCount,
    required this.isOnline,
  });

  Map toJson() => {
        'title': title,
        'viewerCount': viewerCount,
        'isOnline': isOnline,
      };

  @override
  List<Object?> get props {
    return [title, viewerCount, isOnline];
  }

  @override
  bool get stringify => true;
}
