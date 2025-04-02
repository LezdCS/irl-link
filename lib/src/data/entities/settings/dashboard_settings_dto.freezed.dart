// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardSettingsDTO {
  List<DashboardEventDTO> get userEvents;
  bool get activated;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardSettingsDTOCopyWith<DashboardSettingsDTO> get copyWith =>
      _$DashboardSettingsDTOCopyWithImpl<DashboardSettingsDTO>(
          this as DashboardSettingsDTO, _$identity);

  /// Serializes this DashboardSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardSettingsDTO &&
            const DeepCollectionEquality()
                .equals(other.userEvents, userEvents) &&
            (identical(other.activated, activated) ||
                other.activated == activated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(userEvents), activated);

  @override
  String toString() {
    return 'DashboardSettingsDTO(userEvents: $userEvents, activated: $activated)';
  }
}

/// @nodoc
abstract mixin class $DashboardSettingsDTOCopyWith<$Res> {
  factory $DashboardSettingsDTOCopyWith(DashboardSettingsDTO value,
          $Res Function(DashboardSettingsDTO) _then) =
      _$DashboardSettingsDTOCopyWithImpl;
  @useResult
  $Res call({List<DashboardEventDTO> userEvents, bool activated});
}

/// @nodoc
class _$DashboardSettingsDTOCopyWithImpl<$Res>
    implements $DashboardSettingsDTOCopyWith<$Res> {
  _$DashboardSettingsDTOCopyWithImpl(this._self, this._then);

  final DashboardSettingsDTO _self;
  final $Res Function(DashboardSettingsDTO) _then;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEvents = null,
    Object? activated = null,
  }) {
    return _then(_self.copyWith(
      userEvents: null == userEvents
          ? _self.userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<DashboardEventDTO>,
      activated: null == activated
          ? _self.activated
          : activated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardSettingsDTO extends DashboardSettingsDTO {
  _DashboardSettingsDTO(
      {final List<DashboardEventDTO> userEvents = const [],
      this.activated = true})
      : _userEvents = userEvents,
        super._();
  factory _DashboardSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$DashboardSettingsDTOFromJson(json);

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

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardSettingsDTOCopyWith<_DashboardSettingsDTO> get copyWith =>
      __$DashboardSettingsDTOCopyWithImpl<_DashboardSettingsDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardSettingsDTO &&
            const DeepCollectionEquality()
                .equals(other._userEvents, _userEvents) &&
            (identical(other.activated, activated) ||
                other.activated == activated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userEvents), activated);

  @override
  String toString() {
    return 'DashboardSettingsDTO(userEvents: $userEvents, activated: $activated)';
  }
}

/// @nodoc
abstract mixin class _$DashboardSettingsDTOCopyWith<$Res>
    implements $DashboardSettingsDTOCopyWith<$Res> {
  factory _$DashboardSettingsDTOCopyWith(_DashboardSettingsDTO value,
          $Res Function(_DashboardSettingsDTO) _then) =
      __$DashboardSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call({List<DashboardEventDTO> userEvents, bool activated});
}

/// @nodoc
class __$DashboardSettingsDTOCopyWithImpl<$Res>
    implements _$DashboardSettingsDTOCopyWith<$Res> {
  __$DashboardSettingsDTOCopyWithImpl(this._self, this._then);

  final _DashboardSettingsDTO _self;
  final $Res Function(_DashboardSettingsDTO) _then;

  /// Create a copy of DashboardSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userEvents = null,
    Object? activated = null,
  }) {
    return _then(_DashboardSettingsDTO(
      userEvents: null == userEvents
          ? _self._userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<DashboardEventDTO>,
      activated: null == activated
          ? _self.activated
          : activated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
