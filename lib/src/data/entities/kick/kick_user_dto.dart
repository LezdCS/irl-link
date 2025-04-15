import 'package:freezed_annotation/freezed_annotation.dart';

part 'kick_user_dto.freezed.dart';
part 'kick_user_dto.g.dart';

@freezed
abstract class KickUserDTO with _$KickUserDTO {
  const factory KickUserDTO({
    required String id,
    required String username,
    required String bio,
    required String profilePicture,
    required String displayName,
  }) = _KickUserDTO;

  factory KickUserDTO.fromJson(Map<String, dynamic> json) =>
      _$KickUserDTOFromJson(json);
}
