// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardSettingsDTO _$DashboardSettingsDTOFromJson(Map<String, dynamic> json) {
  return _DashboardSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$DashboardSettingsDTO {
  List<DashboardEventDTO> get userEvents => throw _privateConstructorUsedError;
  bool get activated => throw _privateConstructorUsedError;

  /// Serializes this DashboardSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSettingsDTOCopyWith<DashboardSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSettingsDTOCopyWith<$Res> {
  factory $DashboardSettingsDTOCopyWith(DashboardSettingsDTO value,
          $Res Function(DashboardSettingsDTO) then) =
      _$DashboardSettingsDTOCopyWithImpl<$Res, DashboardSettingsDTO>;
  @useResult
  $Res call({List<DashboardEventDTO> userEvents, bool activated});
}

/// @nodoc
class _$DashboardSettingsDTOCopyWithImpl<$Res,
        $Val extends DashboardSettingsDTO>
    implements $DashboardSettingsDTOCopyWith<$Res> {
  _$DashboardSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEvents = null,
    Object? activated = null,
  }) {
    return _then(_value.copyWith(
      userEvents: null == userEvents
          ? _value.userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<DashboardEventDTO>,
      activated: null == activated
          ? _value.activated
          : activated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSettingsDTOImplCopyWith<$Res>
    implements $DashboardSettingsDTOCopyWith<$Res> {
  factory _$$DashboardSettingsDTOImplCopyWith(_$DashboardSettingsDTOImpl value,
          $Res Function(_$DashboardSettingsDTOImpl) then) =
      __$$DashboardSettingsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DashboardEventDTO> userEvents, bool activated});
}

/// @nodoc
class __$$DashboardSettingsDTOImplCopyWithImpl<$Res>
    extends _$DashboardSettingsDTOCopyWithImpl<$Res, _$DashboardSettingsDTOImpl>
    implements _$$DashboardSettingsDTOImplCopyWith<$Res> {
  __$$DashboardSettingsDTOImplCopyWithImpl(_$DashboardSettingsDTOImpl _value,
      $Res Function(_$DashboardSettingsDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEvents = null,
    Object? activated = null,
  }) {
    return _then(_$DashboardSettingsDTOImpl(
      userEvents: null == userEvents
          ? _value._userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<DashboardEventDTO>,
      activated: null == activated
          ? _value.activated
          : activated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSettingsDTOImpl extends _DashboardSettingsDTO {
  _$DashboardSettingsDTOImpl(
      {final List<DashboardEventDTO> userEvents = const [],
      this.activated = true})
      : _userEvents = userEvents,
        super._();

  factory _$DashboardSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSettingsDTOImplFromJson(json);

  final List<DashboardEventDTO> _userEvents;
  @override
  @JsonKey()
  List<DashboardEventDTO> get userEvents {
    if (_userEvents is EqualUnmodifiableListView) return _userEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userEvents);
  }

  @override
  @JsonKey()
  final bool activated;

  @override
  String toString() {
    return 'DashboardSettingsDTO(userEvents: $userEvents, activated: $activated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSettingsDTOImpl &&
            const DeepCollectionEquality()
                .equals(other._userEvents, _userEvents) &&
            (identical(other.activated, activated) ||
                other.activated == activated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userEvents), activated);

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSettingsDTOImplCopyWith<_$DashboardSettingsDTOImpl>
      get copyWith =>
          __$$DashboardSettingsDTOImplCopyWithImpl<_$DashboardSettingsDTOImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _DashboardSettingsDTO extends DashboardSettingsDTO {
  factory _DashboardSettingsDTO(
      {final List<DashboardEventDTO> userEvents,
      final bool activated}) = _$DashboardSettingsDTOImpl;
  _DashboardSettingsDTO._() : super._();

  factory _DashboardSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$DashboardSettingsDTOImpl.fromJson;

  @override
  List<DashboardEventDTO> get userEvents;
  @override
  bool get activated;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSettingsDTOImplCopyWith<_$DashboardSettingsDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}
