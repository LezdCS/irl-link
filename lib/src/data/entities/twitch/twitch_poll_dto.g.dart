// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_poll_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChoiceDTO _$ChoiceDTOFromJson(Map<String, dynamic> json) => _ChoiceDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      votes: (json['votes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ChoiceDTOToJson(_ChoiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'votes': instance.votes,
    };
