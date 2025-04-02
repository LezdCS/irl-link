// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_events_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatEventsSettingsDTO _$ChatEventsSettingsDTOFromJson(
        Map<String, dynamic> json) =>
    _ChatEventsSettingsDTO(
      firstsMessages: json['firstsMessages'] as bool? ?? true,
      subscriptions: json['subscriptions'] as bool? ?? true,
      bitsDonations: json['bitsDonations'] as bool? ?? true,
      announcements: json['announcements'] as bool? ?? true,
      incomingRaids: json['incomingRaids'] as bool? ?? true,
      redemptions: json['redemptions'] as bool? ?? true,
    );

Map<String, dynamic> _$ChatEventsSettingsDTOToJson(
        _ChatEventsSettingsDTO instance) =>
    <String, dynamic>{
      'firstsMessages': instance.firstsMessages,
      'subscriptions': instance.subscriptions,
      'bitsDonations': instance.bitsDonations,
      'announcements': instance.announcements,
      'incomingRaids': instance.incomingRaids,
      'redemptions': instance.redemptions,
    };
