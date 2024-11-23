// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardEventDTO _$DashboardEventDTOFromJson(Map<String, dynamic> json) {
  return _DashboardEventDTO.fromJson(json);
}

/// @nodoc
mixin _$DashboardEventDTO {
  String get title => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;
  DashboardActionsTypes get dashboardActionsType =>
      throw _privateConstructorUsedError;
  SupportedEvents get event => throw _privateConstructorUsedError;
  dynamic get customValue => throw _privateConstructorUsedError;

  /// Serializes this DashboardEventDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardEventDTOCopyWith<DashboardEventDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventDTOCopyWith<$Res> {
  factory $DashboardEventDTOCopyWith(
          DashboardEventDTO value, $Res Function(DashboardEventDTO) then) =
      _$DashboardEventDTOCopyWithImpl<$Res, DashboardEventDTO>;
  @useResult
  $Res call(
      {String title,
      @ColorConverter() Color color,
      DashboardActionsTypes dashboardActionsType,
      SupportedEvents event,
      dynamic customValue});
}

/// @nodoc
class _$DashboardEventDTOCopyWithImpl<$Res, $Val extends DashboardEventDTO>
    implements $DashboardEventDTOCopyWith<$Res> {
  _$DashboardEventDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _value.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _value.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardEventDTOImplCopyWith<$Res>
    implements $DashboardEventDTOCopyWith<$Res> {
  factory _$$DashboardEventDTOImplCopyWith(_$DashboardEventDTOImpl value,
          $Res Function(_$DashboardEventDTOImpl) then) =
      __$$DashboardEventDTOImplCopyWithImpl<$Res>;
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
class __$$DashboardEventDTOImplCopyWithImpl<$Res>
    extends _$DashboardEventDTOCopyWithImpl<$Res, _$DashboardEventDTOImpl>
    implements _$$DashboardEventDTOImplCopyWith<$Res> {
  __$$DashboardEventDTOImplCopyWithImpl(_$DashboardEventDTOImpl _value,
      $Res Function(_$DashboardEventDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$DashboardEventDTOImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dashboardActionsType: null == dashboardActionsType
          ? _value.dashboardActionsType
          : dashboardActionsType // ignore: cast_nullable_to_non_nullable
              as DashboardActionsTypes,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SupportedEvents,
      customValue: freezed == customValue
          ? _value.customValue
          : customValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardEventDTOImpl implements _DashboardEventDTO {
  const _$DashboardEventDTOImpl(
      {this.title = 'None',
      @ColorConverter() required this.color,
      required this.dashboardActionsType,
      required this.event,
      required this.customValue});

  factory _$DashboardEventDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardEventDTOImplFromJson(json);

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
  @override
  final dynamic customValue;

  @override
  String toString() {
    return 'DashboardEventDTO(title: $title, color: $color, dashboardActionsType: $dashboardActionsType, event: $event, customValue: $customValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardEventDTOImpl &&
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

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardEventDTOImplCopyWith<_$DashboardEventDTOImpl> get copyWith =>
      __$$DashboardEventDTOImplCopyWithImpl<_$DashboardEventDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardEventDTOImplToJson(
      this,
    );
  }
}

abstract class _DashboardEventDTO implements DashboardEventDTO {
  const factory _DashboardEventDTO(
      {final String title,
      @ColorConverter() required final Color color,
      required final DashboardActionsTypes dashboardActionsType,
      required final SupportedEvents event,
      required final dynamic customValue}) = _$DashboardEventDTOImpl;

  factory _DashboardEventDTO.fromJson(Map<String, dynamic> json) =
      _$DashboardEventDTOImpl.fromJson;

  @override
  String get title;
  @override
  @ColorConverter()
  Color get color;
  @override
  DashboardActionsTypes get dashboardActionsType;
  @override
  SupportedEvents get event;
  @override
  dynamic get customValue;

  /// Create a copy of DashboardEventDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardEventDTOImplCopyWith<_$DashboardEventDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
