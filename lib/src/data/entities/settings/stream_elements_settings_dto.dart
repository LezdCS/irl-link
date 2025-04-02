import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_elements_settings_dto.freezed.dart';
part 'stream_elements_settings_dto.g.dart';

@freezed
abstract class StreamElementsSettingsDTO with _$StreamElementsSettingsDTO {
  const factory StreamElementsSettingsDTO({
    @Default(true) bool showFollowerActivity,
    @Default(true) bool showSubscriberActivity,
    @Default(true) bool showDonationActivity,
    @Default(true) bool showCheerActivity,
    @Default(true) bool showRaidActivity,
    @Default(true) bool showHostActivity,
    @Default(true) bool showMerchActivity,
    required String? jwt,
    required String? overlayToken,
    @Default([]) List<String> mutedOverlays,
  }) = _StreamElementsSettingsDTO;

  factory StreamElementsSettingsDTO.blank() =>
      const StreamElementsSettingsDTO(jwt: null, overlayToken: null);
  factory StreamElementsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$StreamElementsSettingsDTOFromJson(json);
}
