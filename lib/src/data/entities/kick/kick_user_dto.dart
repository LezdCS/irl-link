import 'package:freezed_annotation/freezed_annotation.dart';

part 'kick_user_dto.freezed.dart';
part 'kick_user_dto.g.dart';

@freezed
abstract class KickUserDTO with _$KickUserDTO {
  const factory KickUserDTO({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'profile_picture') required String profilePicture,
  }) = _KickUserDTO;

  factory KickUserDTO.fromJson(Map<String, dynamic> json) =>
      _$KickUserDTOFromJson(json);
}
