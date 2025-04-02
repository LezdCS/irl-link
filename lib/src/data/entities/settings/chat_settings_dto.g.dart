// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatSettingsDTO _$ChatSettingsDTOFromJson(Map<String, dynamic> json) =>
    _ChatSettingsDTO(
      permanentFirstGroup: json['permanentFirstGroup'] == null
          ? const ChatGroupDTO(id: "permanentFirstGroup", channels: [])
          : _permanentGroupFromJson(json['permanentFirstGroup']),
      chatGroups: (json['chatGroups'] as List<dynamic>?)
              ?.map((e) => ChatGroupDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hideDeletedMessages: json['hideDeletedMessages'] as bool? ?? true,
    );

Map<String, dynamic> _$ChatSettingsDTOToJson(_ChatSettingsDTO instance) =>
    <String, dynamic>{
      'permanentFirstGroup': instance.permanentFirstGroup,
      'chatGroups': instance.chatGroups,
      'hideDeletedMessages': instance.hideDeletedMessages,
    };

_ChatGroupDTO _$ChatGroupDTOFromJson(Map<String, dynamic> json) =>
    _ChatGroupDTO(
      id: json['id'] as String,
      channels: (json['channels'] as List<dynamic>)
          .map((e) => ChannelDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatGroupDTOToJson(_ChatGroupDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channels': instance.channels,
    };

_ChannelDTO _$ChannelDTOFromJson(Map<String, dynamic> json) => _ChannelDTO(
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      channel: json['channel'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$ChannelDTOToJson(_ChannelDTO instance) =>
    <String, dynamic>{
      'platform': _$PlatformEnumMap[instance.platform]!,
      'channel': instance.channel,
      'enabled': instance.enabled,
    };

const _$PlatformEnumMap = {
  Platform.twitch: 'twitch',
  Platform.kick: 'kick',
  Platform.youtube: 'youtube',
};
