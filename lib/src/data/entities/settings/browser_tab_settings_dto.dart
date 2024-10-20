import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'browser_tab_settings_dto.freezed.dart';
part 'browser_tab_settings_dto.g.dart';

@freezed
class BrowserTabSettingsDTO with _$BrowserTabSettingsDTO {
  const factory BrowserTabSettingsDTO({
    @Default([]) List<BrowserTabDTO> tabs,
  }) = _BrowserTabSettingsDTO;

  factory BrowserTabSettingsDTO.fromJson(Map<String, dynamic> json) => _$BrowserTabSettingsDTOFromJson(json);
}

@freezed
class BrowserTabDTO with _$BrowserTabDTO {
  const factory BrowserTabDTO({
    @JsonKey(fromJson: _idFromJson)
    required String id,
    required String title,
    required String url,
    required bool toggled,
    required bool iOSAudioSource,
  }) = _BrowserTabDTO;

  factory BrowserTabDTO.fromJson(Map<String, dynamic> json) => _$BrowserTabDTOFromJson(json);

}

// we used not to have id in the BrowserTab entity, this is to prevent braking from the previous versions
String _idFromJson(dynamic id) {
  return id ?? const Uuid().v4();
}
