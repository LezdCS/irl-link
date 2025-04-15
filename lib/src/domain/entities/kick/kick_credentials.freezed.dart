// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_credentials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickCredentials {
  String get accessToken;
  String get refreshToken;
  String get expiresIn;
  KickUser get kickUser;
  String get scopes;

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickCredentialsCopyWith<KickCredentials> get copyWith =>
      _$KickCredentialsCopyWithImpl<KickCredentials>(
          this as KickCredentials, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickCredentials &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.kickUser, kickUser) ||
                other.kickUser == kickUser) &&
            (identical(other.scopes, scopes) || other.scopes == scopes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, accessToken, refreshToken, expiresIn, kickUser, scopes);

  @override
  String toString() {
    return 'KickCredentials(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, kickUser: $kickUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class $KickCredentialsCopyWith<$Res> {
  factory $KickCredentialsCopyWith(
          KickCredentials value, $Res Function(KickCredentials) _then) =
      _$KickCredentialsCopyWithImpl;
  @useResult
  $Res call(
      {String accessToken,
      String refreshToken,
      String expiresIn,
      KickUser kickUser,
      String scopes});

  $KickUserCopyWith<$Res> get kickUser;
}

/// @nodoc
class _$KickCredentialsCopyWithImpl<$Res>
    implements $KickCredentialsCopyWith<$Res> {
  _$KickCredentialsCopyWithImpl(this._self, this._then);

  final KickCredentials _self;
  final $Res Function(KickCredentials) _then;

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? kickUser = null,
    Object? scopes = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      kickUser: null == kickUser
          ? _self.kickUser
          : kickUser // ignore: cast_nullable_to_non_nullable
              as KickUser,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickUserCopyWith<$Res> get kickUser {
    return $KickUserCopyWith<$Res>(_self.kickUser, (value) {
      return _then(_self.copyWith(kickUser: value));
    });
  }
}

/// @nodoc

class _KickCredentials implements KickCredentials {
  const _KickCredentials(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.kickUser,
      required this.scopes});

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String expiresIn;
  @override
  final KickUser kickUser;
  @override
  final String scopes;

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickCredentialsCopyWith<_KickCredentials> get copyWith =>
      __$KickCredentialsCopyWithImpl<_KickCredentials>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickCredentials &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.kickUser, kickUser) ||
                other.kickUser == kickUser) &&
            (identical(other.scopes, scopes) || other.scopes == scopes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, accessToken, refreshToken, expiresIn, kickUser, scopes);

  @override
  String toString() {
    return 'KickCredentials(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, kickUser: $kickUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class _$KickCredentialsCopyWith<$Res>
    implements $KickCredentialsCopyWith<$Res> {
  factory _$KickCredentialsCopyWith(
          _KickCredentials value, $Res Function(_KickCredentials) _then) =
      __$KickCredentialsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String accessToken,
      String refreshToken,
      String expiresIn,
      KickUser kickUser,
      String scopes});

  @override
  $KickUserCopyWith<$Res> get kickUser;
}

/// @nodoc
class __$KickCredentialsCopyWithImpl<$Res>
    implements _$KickCredentialsCopyWith<$Res> {
  __$KickCredentialsCopyWithImpl(this._self, this._then);

  final _KickCredentials _self;
  final $Res Function(_KickCredentials) _then;

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? kickUser = null,
    Object? scopes = null,
  }) {
    return _then(_KickCredentials(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      kickUser: null == kickUser
          ? _self.kickUser
          : kickUser // ignore: cast_nullable_to_non_nullable
              as KickUser,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickCredentials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickUserCopyWith<$Res> get kickUser {
    return $KickUserCopyWith<$Res>(_self.kickUser, (value) {
      return _then(_self.copyWith(kickUser: value));
    });
  }
}

// dart format on
