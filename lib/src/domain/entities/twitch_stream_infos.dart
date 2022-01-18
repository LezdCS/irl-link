import 'package:equatable/equatable.dart';

class TwitchStreamInfos extends Equatable {
  final String title;
  final String viewerCount;

  const TwitchStreamInfos({
    required this.title,
    required this.viewerCount,
  });

  Map toJson() => {
    'title': title,
    'viewerCount': viewerCount,
  };

  @override
  List<Object?> get props {
    return [
      title,
      viewerCount,
    ];
  }

  @override
  bool get stringify => true;
}
