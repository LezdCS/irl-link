// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardEventDTO {
  String get title;
  @ColorConverter()
  Color get color;
  DashboardActionsTypes get dashboardActionsType;
  SupportedEvents
      get event; // The customValue needs to be dynamic since it can be of different types
// depending on the event type
// ignore: avoid_annotating_with_dynamic
  dynamic get customValue;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardEventDTOCopyWith<DashboardEventDTO> get copyWith =>
      _$DashboardEventDTOCopyWithImpl<DashboardEventDTO>(
          this as DashboardEventDTO, _$identity);

  /// Serializes this DashboardEventDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardEventDTO &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dashboardActionsType, dashboardActionsType) ||
                other.dashboardActionsType == dashboardActionsType) &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality()
                .equals(other.customValue, customValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      color,
      dashboardActionsType,
      event,
      const DeepCollectionEquality().hash(customValue));

  @override
  String toString() {
    return 'DashboardEventDTO(title: $title, color: $color, dashboardActionsType: $dashboardActionsType, event: $event, customValue: $customValue)';
  }
}

/// @nodoc
abstract mixin class $DashboardEventDTOCopyWith<$Res> {
  factory $DashboardEventDTOCopyWith(
          DashboardEventDTO value, $Res Function(DashboardEventDTO) _then) =
      _$DashboardEventDTOCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      @ColorConverter() Color color,
      DashboardActionsTypes dashboardActionsType,
      SupportedEvents event,
      dynamic customValue});
}

/// @nodoc
class _$DashboardEventDTOCopyWithImpl<$Res>
    implements $DashboardEventDTOCopyWith<$Res> {
  _$DashboardEventDTOCopyWithImpl(this._self, this._then);

  final DashboardEventDTO _self;
  final $Res Function(DashboardEventDTO) _then;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? color = null,
    Object? dashboardActionsType = null,
    Object? event = null,
    Object? customValue = freezed,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _self.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _self.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardEventDTO implements DashboardEventDTO {
  const _DashboardEventDTO(
      {this.title = 'None',
      @ColorConverter() required this.color,
      required this.dashboardActionsType,
      required this.event,
      required this.customValue});
  factory _DashboardEventDTO.fromJson(Map<String, dynamic> json) =>
      _$DashboardEventDTOFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @ColorConverter()
  final Color color;
  @override
  final DashboardActionsTypes dashboardActionsType;
  @override
  final SupportedEvents event;
// The customValue needs to be dynamic since it can be of different types
// depending on the event type
// ignore: avoid_annotating_with_dynamic
  @override
  final dynamic customValue;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardEventDTOCopyWith<_DashboardEventDTO> get copyWith =>
      __$DashboardEventDTOCopyWithImpl<_DashboardEventDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardEventDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardEventDTO &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dashboardActionsType, dashboardActionsType) ||
                other.dashboardActionsType == dashboardActionsType) &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality()
                .equals(other.customValue, customValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      color,
      dashboardActionsType,
      event,
      const DeepCollectionEquality().hash(customValue));

  @override
  String toString() {
    return 'DashboardEventDTO(title: $title, color: $color, dashboardActionsType: $dashboardActionsType, event: $event, customValue: $customValue)';
  }
}

/// @nodoc
abstract mixin class _$DashboardEventDTOCopyWith<$Res>
    implements $DashboardEventDTOCopyWith<$Res> {
  factory _$DashboardEventDTOCopyWith(
          _DashboardEventDTO value, $Res Function(_DashboardEventDTO) _then) =
      __$DashboardEventDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      @ColorConverter() Color color,
      DashboardActionsTypes dashboardActionsType,
      SupportedEvents event,
      dynamic customValue});
}

/// @nodoc
class __$DashboardEventDTOCopyWithImpl<$Res>
    implements _$DashboardEventDTOCopyWith<$Res> {
  __$DashboardEventDTOCopyWithImpl(this._self, this._then);

  final _DashboardEventDTO _self;
  final $Res Function(_DashboardEventDTO) _then;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? color = null,
    Object? dashboardActionsType = null,
    Object? event = null,
    Object? customValue = freezed,
  }) {
    return _then(_DashboardEventDTO(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _self.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _self.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
