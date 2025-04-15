// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickUserDTO {
  String get id;
  String get username;
  String get bio;
  String get profilePicture;
  String get displayName;

  /// Create a copy of KickUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickUserDTOCopyWith<KickUserDTO> get copyWith =>
      _$KickUserDTOCopyWithImpl<KickUserDTO>(this as KickUserDTO, _$identity);

  /// Serializes this KickUserDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, bio, profilePicture, displayName);

  @override
  String toString() {
    return 'KickUserDTO(id: $id, username: $username, bio: $bio, profilePicture: $profilePicture, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class $KickUserDTOCopyWith<$Res> {
  factory $KickUserDTOCopyWith(
          KickUserDTO value, $Res Function(KickUserDTO) _then) =
      _$KickUserDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String username,
      String bio,
      String profilePicture,
      String displayName});
}

/// @nodoc
class _$KickUserDTOCopyWithImpl<$Res> implements $KickUserDTOCopyWith<$Res> {
  _$KickUserDTOCopyWithImpl(this._self, this._then);

  final KickUserDTO _self;
  final $Res Function(KickUserDTO) _then;

  /// Create a copy of KickUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? bio = null,
    Object? profilePicture = null,
    Object? displayName = null,
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
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KickUserDTO implements KickUserDTO {
  const _KickUserDTO(
      {required this.id,
      required this.username,
      required this.bio,
      required this.profilePicture,
      required this.displayName});
  factory _KickUserDTO.fromJson(Map<String, dynamic> json) =>
      _$KickUserDTOFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String bio;
  @override
  final String profilePicture;
  @override
  final String displayName;

  /// Create a copy of KickUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickUserDTOCopyWith<_KickUserDTO> get copyWith =>
      __$KickUserDTOCopyWithImpl<_KickUserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KickUserDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, bio, profilePicture, displayName);

  @override
  String toString() {
    return 'KickUserDTO(id: $id, username: $username, bio: $bio, profilePicture: $profilePicture, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class _$KickUserDTOCopyWith<$Res>
    implements $KickUserDTOCopyWith<$Res> {
  factory _$KickUserDTOCopyWith(
          _KickUserDTO value, $Res Function(_KickUserDTO) _then) =
      __$KickUserDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String bio,
      String profilePicture,
      String displayName});
}

/// @nodoc
class __$KickUserDTOCopyWithImpl<$Res> implements _$KickUserDTOCopyWith<$Res> {
  __$KickUserDTOCopyWithImpl(this._self, this._then);

  final _KickUserDTO _self;
  final $Res Function(_KickUserDTO) _then;

  /// Create a copy of KickUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? bio = null,
    Object? profilePicture = null,
    Object? displayName = null,
  }) {
    return _then(_KickUserDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
