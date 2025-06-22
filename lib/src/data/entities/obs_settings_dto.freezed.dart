// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'obs_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ObsSettingsDTO {
  String get url;
  String get password;
  @JsonKey(name: 'is_connected')
  bool get isConnected;

  /// Create a copy of ObsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ObsSettingsDTOCopyWith<ObsSettingsDTO> get copyWith =>
      _$ObsSettingsDTOCopyWithImpl<ObsSettingsDTO>(
          this as ObsSettingsDTO, _$identity);

  /// Serializes this ObsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ObsSettingsDTO &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, password, isConnected);

  @override
  String toString() {
    return 'ObsSettingsDTO(url: $url, password: $password, isConnected: $isConnected)';
  }
}

/// @nodoc
abstract mixin class $ObsSettingsDTOCopyWith<$Res> {
  factory $ObsSettingsDTOCopyWith(
          ObsSettingsDTO value, $Res Function(ObsSettingsDTO) _then) =
      _$ObsSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {String url,
      String password,
      @JsonKey(name: 'is_connected') bool isConnected});
}

/// @nodoc
class _$ObsSettingsDTOCopyWithImpl<$Res>
    implements $ObsSettingsDTOCopyWith<$Res> {
  _$ObsSettingsDTOCopyWithImpl(this._self, this._then);

  final ObsSettingsDTO _self;
  final $Res Function(ObsSettingsDTO) _then;

  /// Create a copy of ObsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? password = null,
    Object? isConnected = null,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ObsSettingsDTO implements ObsSettingsDTO {
  const _ObsSettingsDTO(
      {required this.url,
      required this.password,
      @JsonKey(name: 'is_connected') required this.isConnected});
  factory _ObsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ObsSettingsDTOFromJson(json);

  @override
  final String url;
  @override
  final String password;
  @override
  @JsonKey(name: 'is_connected')
  final bool isConnected;

  /// Create a copy of ObsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObsSettingsDTOCopyWith<_ObsSettingsDTO> get copyWith =>
      __$ObsSettingsDTOCopyWithImpl<_ObsSettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ObsSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObsSettingsDTO &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, password, isConnected);

  @override
  String toString() {
    return 'ObsSettingsDTO(url: $url, password: $password, isConnected: $isConnected)';
  }
}

/// @nodoc
abstract mixin class _$ObsSettingsDTOCopyWith<$Res>
    implements $ObsSettingsDTOCopyWith<$Res> {
  factory _$ObsSettingsDTOCopyWith(
          _ObsSettingsDTO value, $Res Function(_ObsSettingsDTO) _then) =
      __$ObsSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url,
      String password,
      @JsonKey(name: 'is_connected') bool isConnected});
}

/// @nodoc
class __$ObsSettingsDTOCopyWithImpl<$Res>
    implements _$ObsSettingsDTOCopyWith<$Res> {
  __$ObsSettingsDTOCopyWithImpl(this._self, this._then);

  final _ObsSettingsDTO _self;
  final $Res Function(_ObsSettingsDTO) _then;

  /// Create a copy of ObsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? password = null,
    Object? isConnected = null,
  }) {
    return _then(_ObsSettingsDTO(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
