import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';

class SeMeDTO extends SeMe {
  const SeMeDTO({
    required super.id,
    required super.avatar,
    required super.username,
    required super.displayName,
  });

  Map toJson() => {
        'id': id,
        'avatar': avatar,
        'username': username,
        'displayName': displayName,
      };

  factory SeMeDTO.fromJson(Map<String, dynamic> map) {
    return SeMeDTO(
      id: map['_id'] as String,
      avatar: map['avatar'] as String,
      username: map['username'] as String,
      displayName: map['displayName'] as String,
    );
  }
}
