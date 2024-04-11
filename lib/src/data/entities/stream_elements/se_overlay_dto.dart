import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';

class SeOverlayDTO extends SeOverlay {
  const SeOverlayDTO({
    required super.id,
    required super.name,
  });

  Map toJson() => {
        'id': id,
        'name': name,
      };

  factory SeOverlayDTO.fromJson(Map<String, dynamic> map) {
    return SeOverlayDTO(
      id: map['_id'] as String,
      name: map['name'] as String,
    );
  }
}
