import 'package:freezed_annotation/freezed_annotation.dart';

part 'se_overlay_dto.freezed.dart';
part 'se_overlay_dto.g.dart';

@freezed
abstract class SeOverlayDTO with _$SeOverlayDTO {
  const factory SeOverlayDTO({
    @JsonKey(name: '_id') required String id,
    required String name,
  }) = _SeOverlayDTO;

  factory SeOverlayDTO.fromJson(Map<String, dynamic> json) =>
      _$SeOverlayDTOFromJson(json);
}
