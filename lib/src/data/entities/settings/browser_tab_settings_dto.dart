import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tab_settings_dto.freezed.dart';
part 'browser_tab_settings_dto.g.dart';

// Custom converter for boolean values stored as integers in SQLite
class BoolToIntConverter implements JsonConverter<bool, Object> {
  const BoolToIntConverter();

  @override
  bool fromJson(Object json) {
    if (json is bool) {
      return json;
    }
    if (json is int) {
      return json == 1;
    }
    if (json is String) {
      return json.toLowerCase() == 'true';
    }
    return false;
  }

  @override
  Object toJson(bool object) => object;
}

@freezed
abstract class BrowserTabDTO with _$BrowserTabDTO {
  const factory BrowserTabDTO({
    required String id,
    required String title,
    required String url,
    @BoolToIntConverter() required bool toggled,
    @JsonKey(name: 'is_ios_audio_source')
    @BoolToIntConverter()
    required bool iOSAudioSource,
  }) = _BrowserTabDTO;

  factory BrowserTabDTO.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabDTOFromJson(json);
}
