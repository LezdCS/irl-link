import 'package:freezed_annotation/freezed_annotation.dart';

part 'obs_settings_dto.freezed.dart';
part 'obs_settings_dto.g.dart';

@freezed
abstract class ObsSettingsDTO with _$ObsSettingsDTO {
  const factory ObsSettingsDTO({
    required String url,
    required String password,
    @JsonKey(name: 'is_connected') required bool isConnected,
  }) = _ObsSettingsDTO;

  factory ObsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ObsSettingsDTOFromJson(json);
}
