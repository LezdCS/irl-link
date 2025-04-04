import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/dashboard_event_dto.dart';

part 'dashboard_settings_dto.freezed.dart';
part 'dashboard_settings_dto.g.dart';

@freezed
abstract class DashboardSettingsDTO with _$DashboardSettingsDTO {
  factory DashboardSettingsDTO({
    @Default([]) List<DashboardEventDTO> userEvents,
    @Default(true) bool activated,
  }) = _DashboardSettingsDTO;
  DashboardSettingsDTO._();

  factory DashboardSettingsDTO.blank() => DashboardSettingsDTO();
  factory DashboardSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$DashboardSettingsDTOFromJson(json);
}
