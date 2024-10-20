// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardEventDTOImpl _$$DashboardEventDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardEventDTOImpl(
      title: json['title'] as String? ?? 'None',
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      dashboardActionsType: $enumDecode(
          _$DashboardActionsTypesEnumMap, json['dashboardActionsType']),
      event: $enumDecode(_$SupportedEventsEnumMap, json['event']),
      customValue: json['customValue'],
    );

Map<String, dynamic> _$$DashboardEventDTOImplToJson(
        _$DashboardEventDTOImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': const ColorConverter().toJson(instance.color),
      'dashboardActionsType':
          _$DashboardActionsTypesEnumMap[instance.dashboardActionsType]!,
      'event': _$SupportedEventsEnumMap[instance.event]!,
      'customValue': instance.customValue,
    };

const _$DashboardActionsTypesEnumMap = {
  DashboardActionsTypes.toggle: 'toggle',
  DashboardActionsTypes.button: 'button',
  DashboardActionsTypes.slider: 'slider',
};

const _$SupportedEventsEnumMap = {
  SupportedEvents.none: 'none',
  SupportedEvents.obsStreamStart: 'obsStreamStart',
  SupportedEvents.obsStreamStop: 'obsStreamStop',
  SupportedEvents.obsRecordToggle: 'obsRecordToggle',
  SupportedEvents.twitchChatMessage: 'twitchChatMessage',
};