// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatSettingsDTOImpl _$$ChatSettingsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatSettingsDTOImpl(
      permanentFirstGroup: json['permanentFirstGroup'] == null
          ? const ChatGroupDTO(id: "permanentFirstGroup", channels: [])
          : _permanentGroupFromJson(json['permanentFirstGroup']),
      chatGroups: (json['chatGroups'] as List<dynamic>?)
              ?.map((e) => ChatGroupDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hideDeletedMessages: json['hideDeletedMessages'] as bool? ?? true,
    );

Map<String, dynamic> _$$ChatSettingsDTOImplToJson(
        _$ChatSettingsDTOImpl instance) =>
    <String, dynamic>{
      'permanentFirstGroup': instance.permanentFirstGroup,
      'chatGroups': instance.chatGroups,
      'hideDeletedMessages': instance.hideDeletedMessages,
    };

_$ChatGroupDTOImpl _$$ChatGroupDTOImplFromJson(Map<String, dynamic> json) =>
    _$ChatGroupDTOImpl(
      id: json['id'] as String,
      channels: (json['channels'] as List<dynamic>)
          .map((e) => ChannelDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatGroupDTOImplToJson(_$ChatGroupDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channels': instance.channels,
    };

_$ChannelDTOImpl _$$ChannelDTOImplFromJson(Map<String, dynamic> json) =>
    _$ChannelDTOImpl(
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      channel: json['channel'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$$ChannelDTOImplToJson(_$ChannelDTOImpl instance) =>
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
