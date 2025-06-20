// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hidden_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HiddenUserDTO {
  String get id;
  String get username;
  Platform get platform;

  /// Create a copy of HiddenUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HiddenUserDTOCopyWith<HiddenUserDTO> get copyWith =>
      _$HiddenUserDTOCopyWithImpl<HiddenUserDTO>(
          this as HiddenUserDTO, _$identity);

  /// Serializes this HiddenUserDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HiddenUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, platform);

  @override
  String toString() {
    return 'HiddenUserDTO(id: $id, username: $username, platform: $platform)';
  }
}

/// @nodoc
abstract mixin class $HiddenUserDTOCopyWith<$Res> {
  factory $HiddenUserDTOCopyWith(
          HiddenUserDTO value, $Res Function(HiddenUserDTO) _then) =
      _$HiddenUserDTOCopyWithImpl;
  @useResult
  $Res call({String id, String username, Platform platform});
}

/// @nodoc
class _$HiddenUserDTOCopyWithImpl<$Res>
    implements $HiddenUserDTOCopyWith<$Res> {
  _$HiddenUserDTOCopyWithImpl(this._self, this._then);

  final HiddenUserDTO _self;
  final $Res Function(HiddenUserDTO) _then;

  /// Create a copy of HiddenUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? platform = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HiddenUserDTO implements HiddenUserDTO {
  const _HiddenUserDTO(
      {required this.id, required this.username, required this.platform});
  factory _HiddenUserDTO.fromJson(Map<String, dynamic> json) =>
      _$HiddenUserDTOFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final Platform platform;

  /// Create a copy of HiddenUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HiddenUserDTOCopyWith<_HiddenUserDTO> get copyWith =>
      __$HiddenUserDTOCopyWithImpl<_HiddenUserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HiddenUserDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HiddenUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, platform);

  @override
  String toString() {
    return 'HiddenUserDTO(id: $id, username: $username, platform: $platform)';
  }
}

/// @nodoc
abstract mixin class _$HiddenUserDTOCopyWith<$Res>
    implements $HiddenUserDTOCopyWith<$Res> {
  factory _$HiddenUserDTOCopyWith(
          _HiddenUserDTO value, $Res Function(_HiddenUserDTO) _then) =
      __$HiddenUserDTOCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String username, Platform platform});
}

/// @nodoc
class __$HiddenUserDTOCopyWithImpl<$Res>
    implements _$HiddenUserDTOCopyWith<$Res> {
  __$HiddenUserDTOCopyWithImpl(this._self, this._then);

  final _HiddenUserDTO _self;
  final $Res Function(_HiddenUserDTO) _then;

  /// Create a copy of HiddenUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? platform = null,
  }) {
    return _then(_HiddenUserDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
    ));
  }
}

// dart format on
