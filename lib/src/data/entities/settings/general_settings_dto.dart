import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_settings_dto.freezed.dart';
part 'general_settings_dto.g.dart';

@freezed
class GeneralSettingsDTO with _$GeneralSettingsDTO {
  const factory GeneralSettingsDTO({
    @Default(true) bool isDarkMode,
    @Default(true) bool keepSpeakerOn,
    @Default(true) bool displayViewerCount,
    @Default({"languageCode": "en", "countryCode": "US"}) Map<dynamic, dynamic> appLanguage,
    @Default([0.5, 0.5]) List<double> splitViewWeights,
  }) = _GeneralSettingsDTO;
  const GeneralSettingsDTO._();

  factory GeneralSettingsDTO.blank() => const GeneralSettingsDTO();
  factory GeneralSettingsDTO.fromJson(Map<String, dynamic> json) => _$GeneralSettingsDTOFromJson(json);
}
