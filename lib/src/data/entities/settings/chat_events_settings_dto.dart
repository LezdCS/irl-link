import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_events_settings_dto.freezed.dart';
part 'chat_events_settings_dto.g.dart';

@freezed
class ChatEventsSettingsDTO with _$ChatEventsSettingsDTO {

  factory ChatEventsSettingsDTO({
    @Default(true) bool firstsMessages,
    @Default(true) bool subscriptions,
    @Default(true) bool bitsDonations,
    @Default(true) bool announcements,
    @Default(true) bool incomingRaids,
    @Default(true) bool redemptions,
  }) = _ChatEventsSettingsDTO;
  ChatEventsSettingsDTO._();

  factory ChatEventsSettingsDTO.blank() => ChatEventsSettingsDTO();
  factory ChatEventsSettingsDTO.fromJson(Map<String, dynamic> json) => _$ChatEventsSettingsDTOFromJson(json);
}
