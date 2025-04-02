// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_prediction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OutcomeDTO _$OutcomeDTOFromJson(Map<String, dynamic> json) => _OutcomeDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      users: (json['users'] as num?)?.toInt() ?? 0,
      channelPoints: (json['channel_points'] as num?)?.toInt() ?? 0,
      color: const ColorConverter().fromJson(json['color'] as String),
    );

Map<String, dynamic> _$OutcomeDTOToJson(_OutcomeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'users': instance.users,
      'channel_points': instance.channelPoints,
      'color': const ColorConverter().toJson(instance.color),
    };
