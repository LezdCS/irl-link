// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_hype_train_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContributionDTO _$ContributionDTOFromJson(Map<String, dynamic> json) =>
    _ContributionDTO(
      userId: json['user_id'] as String,
      userLogin: json['user_login'] as String,
      userName: json['user_name'] as String,
      type: json['type'] as String,
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$ContributionDTOToJson(_ContributionDTO instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_login': instance.userLogin,
      'user_name': instance.userName,
      'type': instance.type,
      'total': instance.total,
    };
