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
  @JsonKey(name: 'user_id')
  int get userId;
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'profile_picture')
  String get profilePicture;

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
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, name, email, profilePicture);

  @override
  String toString() {
    return 'KickUserDTO(userId: $userId, name: $name, email: $email, profilePicture: $profilePicture)';
  }
}

/// @nodoc
abstract mixin class $KickUserDTOCopyWith<$Res> {
  factory $KickUserDTOCopyWith(
          KickUserDTO value, $Res Function(KickUserDTO) _then) =
      _$KickUserDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'profile_picture') String profilePicture});
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
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? profilePicture = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KickUserDTO implements KickUserDTO {
  const _KickUserDTO(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'profile_picture') required this.profilePicture});
  factory _KickUserDTO.fromJson(Map<String, dynamic> json) =>
      _$KickUserDTOFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'profile_picture')
  final String profilePicture;

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
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, name, email, profilePicture);

  @override
  String toString() {
    return 'KickUserDTO(userId: $userId, name: $name, email: $email, profilePicture: $profilePicture)';
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
      {@JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'profile_picture') String profilePicture});
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
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? profilePicture = null,
  }) {
    return _then(_KickUserDTO(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
