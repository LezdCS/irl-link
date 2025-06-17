import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;

part 'hidden_user_dto.freezed.dart';
part 'hidden_user_dto.g.dart';

@freezed
abstract class HiddenUserDTO with _$HiddenUserDTO {
  const factory HiddenUserDTO({
    required String id,
    required String username,
    required Platform platform,
  }) = _HiddenUserDTO;

  factory HiddenUserDTO.fromJson(Map<String, dynamic> json) =>
      _$HiddenUserDTOFromJson(json);
}
