// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kick_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KickUserDTO _$KickUserDTOFromJson(Map<String, dynamic> json) => _KickUserDTO(
      id: json['id'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String,
      profilePicture: json['profilePicture'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$KickUserDTOToJson(_KickUserDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'bio': instance.bio,
      'profilePicture': instance.profilePicture,
      'displayName': instance.displayName,
    };
