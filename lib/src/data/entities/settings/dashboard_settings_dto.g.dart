// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardSettingsDTO _$DashboardSettingsDTOFromJson(
        Map<String, dynamic> json) =>
    _DashboardSettingsDTO(
      userEvents: (json['userEvents'] as List<dynamic>?)
              ?.map(
                  (e) => DashboardEventDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activated: json['activated'] as bool? ?? true,
    );

Map<String, dynamic> _$DashboardSettingsDTOToJson(
        _DashboardSettingsDTO instance) =>
    <String, dynamic>{
      'userEvents': instance.userEvents,
      'activated': instance.activated,
    };
