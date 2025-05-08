import 'package:freezed_annotation/freezed_annotation.dart';

part 'kick_category_dto.freezed.dart';
part 'kick_category_dto.g.dart';

@freezed
abstract class KickCategoryDTO with _$KickCategoryDTO {
  const factory KickCategoryDTO({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'thumbnail') required String thumbnail,
  }) = _KickCategoryDTO;

  factory KickCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$KickCategoryDTOFromJson(json);
}
