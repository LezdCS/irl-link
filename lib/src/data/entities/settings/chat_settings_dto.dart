import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

part 'chat_settings_dto.freezed.dart';
part 'chat_settings_dto.g.dart';

@freezed
abstract class ChatSettingsDTO with _$ChatSettingsDTO {
  factory ChatSettingsDTO({
    @Default(true) bool hideDeletedMessages,
  }) = _ChatSettingsDTO;
  ChatSettingsDTO._();

  factory ChatSettingsDTO.blank() => ChatSettingsDTO();
  factory ChatSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatSettingsDTOFromJson(json);
}

@freezed
abstract class ChatGroupDTO with _$ChatGroupDTO {
  const factory ChatGroupDTO({
    required String id,
    required List<ChannelDTO> channels,
  }) = _ChatGroupDTO;

  factory ChatGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupDTOFromJson(json);
}

@freezed
abstract class ChannelDTO with _$ChannelDTO {
  const factory ChannelDTO({
    required Platform platform,
    required String channel,
  }) = _ChannelDTO;

  factory ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);
}
