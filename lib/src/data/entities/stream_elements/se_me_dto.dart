import 'package:freezed_annotation/freezed_annotation.dart';

part 'se_me_dto.freezed.dart';
part 'se_me_dto.g.dart';

@freezed
class SeMeDTO with _$SeMeDTO {
  const factory SeMeDTO({
    @JsonKey(name: '_id')
    required String id,
    required String avatar,
    required String username,
    required String displayName,
  }) = _SeMeDTO;

  factory SeMeDTO.fromJson(Map<String, dynamic> json) => _$SeMeDTOFromJson(json);
}
