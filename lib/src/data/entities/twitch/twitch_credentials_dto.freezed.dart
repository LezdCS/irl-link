// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_credentials_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TwitchCredentialsDTO _$TwitchCredentialsDTOFromJson(Map<String, dynamic> json) {
  return _TwitchCredentialsDTO.fromJson(json);
}

/// @nodoc
mixin _$TwitchCredentialsDTO {
  String get accessToken => throw _privateConstructorUsedError;
  String get idToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get expiresIn => throw _privateConstructorUsedError;
  TwitchDecodedIdTokenDTO get decodedIdToken =>
      throw _privateConstructorUsedError;
  TwitchUserDTO get twitchUser => throw _privateConstructorUsedError;
  String get scopes => throw _privateConstructorUsedError;

  /// Serializes this TwitchCredentialsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchCredentialsDTOCopyWith<TwitchCredentialsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchCredentialsDTOCopyWith<$Res> {
  factory $TwitchCredentialsDTOCopyWith(TwitchCredentialsDTO value,
          $Res Function(TwitchCredentialsDTO) then) =
      _$TwitchCredentialsDTOCopyWithImpl<$Res, TwitchCredentialsDTO>;
  @useResult
  $Res call(
      {String accessToken,
      String idToken,
      String refreshToken,
      String expiresIn,
      TwitchDecodedIdTokenDTO decodedIdToken,
      TwitchUserDTO twitchUser,
      String scopes});

  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken;
  $TwitchUserDTOCopyWith<$Res> get twitchUser;
}

/// @nodoc
class _$TwitchCredentialsDTOCopyWithImpl<$Res,
        $Val extends TwitchCredentialsDTO>
    implements $TwitchCredentialsDTOCopyWith<$Res> {
  _$TwitchCredentialsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? idToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? decodedIdToken = null,
    Object? twitchUser = null,
    Object? scopes = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      idToken: null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      decodedIdToken: null == decodedIdToken
          ? _value.decodedIdToken
          : decodedIdToken // ignore: cast_nullable_to_non_nullable
              as TwitchDecodedIdTokenDTO,
      twitchUser: null == twitchUser
          ? _value.twitchUser
          : twitchUser // ignore: cast_nullable_to_non_nullable
              as TwitchUserDTO,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken {
    return $TwitchDecodedIdTokenDTOCopyWith<$Res>(_value.decodedIdToken,
        (value) {
      return _then(_value.copyWith(decodedIdToken: value) as $Val);
    });
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchUserDTOCopyWith<$Res> get twitchUser {
    return $TwitchUserDTOCopyWith<$Res>(_value.twitchUser, (value) {
      return _then(_value.copyWith(twitchUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TwitchCredentialsDTOImplCopyWith<$Res>
    implements $TwitchCredentialsDTOCopyWith<$Res> {
  factory _$$TwitchCredentialsDTOImplCopyWith(_$TwitchCredentialsDTOImpl value,
          $Res Function(_$TwitchCredentialsDTOImpl) then) =
      __$$TwitchCredentialsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accessToken,
      String idToken,
      String refreshToken,
      String expiresIn,
      TwitchDecodedIdTokenDTO decodedIdToken,
      TwitchUserDTO twitchUser,
      String scopes});

  @override
  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken;
  @override
  $TwitchUserDTOCopyWith<$Res> get twitchUser;
}

/// @nodoc
class __$$TwitchCredentialsDTOImplCopyWithImpl<$Res>
    extends _$TwitchCredentialsDTOCopyWithImpl<$Res, _$TwitchCredentialsDTOImpl>
    implements _$$TwitchCredentialsDTOImplCopyWith<$Res> {
  __$$TwitchCredentialsDTOImplCopyWithImpl(_$TwitchCredentialsDTOImpl _value,
      $Res Function(_$TwitchCredentialsDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? idToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? decodedIdToken = null,
    Object? twitchUser = null,
    Object? scopes = null,
  }) {
    return _then(_$TwitchCredentialsDTOImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      idToken: null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      decodedIdToken: null == decodedIdToken
          ? _value.decodedIdToken
          : decodedIdToken // ignore: cast_nullable_to_non_nullable
              as TwitchDecodedIdTokenDTO,
      twitchUser: null == twitchUser
          ? _value.twitchUser
          : twitchUser // ignore: cast_nullable_to_non_nullable
              as TwitchUserDTO,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TwitchCredentialsDTOImpl implements _TwitchCredentialsDTO {
  const _$TwitchCredentialsDTOImpl(
      {required this.accessToken,
      required this.idToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.decodedIdToken,
      required this.twitchUser,
      required this.scopes});

  factory _$TwitchCredentialsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TwitchCredentialsDTOImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String idToken;
  @override
  final String refreshToken;
  @override
  final String expiresIn;
  @override
  final TwitchDecodedIdTokenDTO decodedIdToken;
  @override
  final TwitchUserDTO twitchUser;
  @override
  final String scopes;

  @override
  String toString() {
    return 'TwitchCredentialsDTO(accessToken: $accessToken, idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, decodedIdToken: $decodedIdToken, twitchUser: $twitchUser, scopes: $scopes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchCredentialsDTOImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.decodedIdToken, decodedIdToken) ||
                other.decodedIdToken == decodedIdToken) &&
            (identical(other.twitchUser, twitchUser) ||
                other.twitchUser == twitchUser) &&
            (identical(other.scopes, scopes) || other.scopes == scopes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, idToken,
      refreshToken, expiresIn, decodedIdToken, twitchUser, scopes);

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchCredentialsDTOImplCopyWith<_$TwitchCredentialsDTOImpl>
      get copyWith =>
          __$$TwitchCredentialsDTOImplCopyWithImpl<_$TwitchCredentialsDTOImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TwitchCredentialsDTOImplToJson(
      this,
    );
  }
}

abstract class _TwitchCredentialsDTO implements TwitchCredentialsDTO {
  const factory _TwitchCredentialsDTO(
      {required final String accessToken,
      required final String idToken,
      required final String refreshToken,
      required final String expiresIn,
      required final TwitchDecodedIdTokenDTO decodedIdToken,
      required final TwitchUserDTO twitchUser,
      required final String scopes}) = _$TwitchCredentialsDTOImpl;

  factory _TwitchCredentialsDTO.fromJson(Map<String, dynamic> json) =
      _$TwitchCredentialsDTOImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get idToken;
  @override
  String get refreshToken;
  @override
  String get expiresIn;
  @override
  TwitchDecodedIdTokenDTO get decodedIdToken;
  @override
  TwitchUserDTO get twitchUser;
  @override
  String get scopes;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchCredentialsDTOImplCopyWith<_$TwitchCredentialsDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}
