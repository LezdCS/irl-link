// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KickUserDTO _$KickUserDTOFromJson(Map<String, dynamic> json) => _KickUserDTO(
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profile_picture'] as String,
    );

Map<String, dynamic> _$KickUserDTOToJson(_KickUserDTO instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'profile_picture': instance.profilePicture,
    };
