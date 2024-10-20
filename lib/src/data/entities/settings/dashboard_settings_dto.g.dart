// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSettingsDTOImpl _$$DashboardSettingsDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSettingsDTOImpl(
      userEvents: (json['userEvents'] as List<dynamic>)
          .map((e) => DashboardEventDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      activated: json['activated'] as bool,
    );

Map<String, dynamic> _$$DashboardSettingsDTOImplToJson(
        _$DashboardSettingsDTOImpl instance) =>
    <String, dynamic>{
      'userEvents': instance.userEvents,
      'activated': instance.activated,
    };
