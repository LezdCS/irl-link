// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KickCategoryDTO _$KickCategoryDTOFromJson(Map<String, dynamic> json) =>
    _KickCategoryDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$KickCategoryDTOToJson(_KickCategoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
    };
