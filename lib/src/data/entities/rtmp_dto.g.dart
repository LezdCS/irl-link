// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rtmp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RtmpDTO _$RtmpDTOFromJson(Map<String, dynamic> json) => _RtmpDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      url: json['url'] as String,
      key: json['key'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RtmpDTOToJson(_RtmpDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'key': instance.key,
      'createdAt': instance.createdAt.toIso8601String(),
    };
