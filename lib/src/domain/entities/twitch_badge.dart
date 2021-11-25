import 'package:equatable/equatable.dart';

class TwitchBadge extends Equatable {
  final String setId;
  final String versionId;
  final String imageUrl1x;
  final String imageUrl2x;
  final String imageUrl4x;

  const TwitchBadge({
    required this.setId,
    required this.versionId,
    required this.imageUrl1x,
    required this.imageUrl2x,
    required this.imageUrl4x,
  });

  @override
  List<Object?> get props {
    return [
      setId,
      versionId,
      imageUrl1x,
      imageUrl2x,
      imageUrl4x,
    ];
  }
}
