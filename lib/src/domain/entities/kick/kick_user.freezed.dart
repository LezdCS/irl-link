// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickUser {
  String get id;
  String get username;
  String get bio;
  String get profilePicture;
  String get displayName;

  /// Create a copy of KickUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickUserCopyWith<KickUser> get copyWith =>
      _$KickUserCopyWithImpl<KickUser>(this as KickUser, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, bio, profilePicture, displayName);

  @override
  String toString() {
    return 'KickUser(id: $id, username: $username, bio: $bio, profilePicture: $profilePicture, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class $KickUserCopyWith<$Res> {
  factory $KickUserCopyWith(KickUser value, $Res Function(KickUser) _then) =
      _$KickUserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String username,
      String bio,
      String profilePicture,
      String displayName});
}

/// @nodoc
class _$KickUserCopyWithImpl<$Res> implements $KickUserCopyWith<$Res> {
  _$KickUserCopyWithImpl(this._self, this._then);

  final KickUser _self;
  final $Res Function(KickUser) _then;

  /// Create a copy of KickUser
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

class _KickUser implements KickUser {
  const _KickUser(
      {required this.id,
      required this.username,
      required this.bio,
      required this.profilePicture,
      required this.displayName});

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

  /// Create a copy of KickUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickUserCopyWith<_KickUser> get copyWith =>
      __$KickUserCopyWithImpl<_KickUser>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, bio, profilePicture, displayName);

  @override
  String toString() {
    return 'KickUser(id: $id, username: $username, bio: $bio, profilePicture: $profilePicture, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class _$KickUserCopyWith<$Res>
    implements $KickUserCopyWith<$Res> {
  factory _$KickUserCopyWith(_KickUser value, $Res Function(_KickUser) _then) =
      __$KickUserCopyWithImpl;
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
class __$KickUserCopyWithImpl<$Res> implements _$KickUserCopyWith<$Res> {
  __$KickUserCopyWithImpl(this._self, this._then);

  final _KickUser _self;
  final $Res Function(_KickUser) _then;

  /// Create a copy of KickUser
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
    return _then(_KickUser(
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
