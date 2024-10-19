// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_poll_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceDTOImpl _$$ChoiceDTOImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceDTOImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      votes: (json['votes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChoiceDTOImplToJson(_$ChoiceDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'votes': instance.votes,
    };
