import 'package:freezed_annotation/freezed_annotation.dart';

part 'rtmp_dto.freezed.dart';
part 'rtmp_dto.g.dart';

@freezed
abstract class RtmpDTO with _$RtmpDTO {
  const factory RtmpDTO({
    required int id,
    required String name,
    required String url,
    required String key,
    required DateTime createdAt,
  }) = _RtmpDTO;

  factory RtmpDTO.fromJson(Map<String, dynamic> json) =>
      _$RtmpDTOFromJson(json);
}
