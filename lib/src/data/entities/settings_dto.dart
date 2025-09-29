import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';

part 'settings_dto.freezed.dart';
part 'settings_dto.g.dart';

@freezed
abstract class SettingsDTO with _$SettingsDTO {
  const factory SettingsDTO({
    //CHAT SETTINGS
    required ChatEventsSettingsDTO chatEventsSettings,
  }) = _SettingsDTO;

  factory SettingsDTO.blank() => SettingsDTO(
        chatEventsSettings: ChatEventsSettingsDTO.blank(),
      );
  factory SettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsDTOFromJson(json);
}
