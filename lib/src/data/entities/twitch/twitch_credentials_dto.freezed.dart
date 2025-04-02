// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_credentials_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchCredentialsDTO {
  String get accessToken;
  String get idToken;
  String get refreshToken;
  String get expiresIn;
  @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO)
  TwitchDecodedIdTokenDTO get decodedIdToken;
  @JsonKey(fromJson: _stringToTwitchUserDTO)
  TwitchUserDTO get twitchUser;
  String get scopes;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchCredentialsDTOCopyWith<TwitchCredentialsDTO> get copyWith =>
      _$TwitchCredentialsDTOCopyWithImpl<TwitchCredentialsDTO>(
          this as TwitchCredentialsDTO, _$identity);

  /// Serializes this TwitchCredentialsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchCredentialsDTO &&
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

  @override
  String toString() {
    return 'TwitchCredentialsDTO(accessToken: $accessToken, idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, decodedIdToken: $decodedIdToken, twitchUser: $twitchUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class $TwitchCredentialsDTOCopyWith<$Res> {
  factory $TwitchCredentialsDTOCopyWith(TwitchCredentialsDTO value,
          $Res Function(TwitchCredentialsDTO) _then) =
      _$TwitchCredentialsDTOCopyWithImpl;
  @useResult
  $Res call(
      {String accessToken,
      String idToken,
      String refreshToken,
      String expiresIn,
      @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO)
      TwitchDecodedIdTokenDTO decodedIdToken,
      @JsonKey(fromJson: _stringToTwitchUserDTO) TwitchUserDTO twitchUser,
      String scopes});

  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken;
  $TwitchUserDTOCopyWith<$Res> get twitchUser;
}

/// @nodoc
class _$TwitchCredentialsDTOCopyWithImpl<$Res>
    implements $TwitchCredentialsDTOCopyWith<$Res> {
  _$TwitchCredentialsDTOCopyWithImpl(this._self, this._then);

  final TwitchCredentialsDTO _self;
  final $Res Function(TwitchCredentialsDTO) _then;

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
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      idToken: null == idToken
          ? _self.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      decodedIdToken: null == decodedIdToken
          ? _self.decodedIdToken
          : decodedIdToken // ignore: cast_nullable_to_non_nullable
              as TwitchDecodedIdTokenDTO,
      twitchUser: null == twitchUser
          ? _self.twitchUser
          : twitchUser // ignore: cast_nullable_to_non_nullable
              as TwitchUserDTO,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken {
    return $TwitchDecodedIdTokenDTOCopyWith<$Res>(_self.decodedIdToken,
        (value) {
      return _then(_self.copyWith(decodedIdToken: value));
    });
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchUserDTOCopyWith<$Res> get twitchUser {
    return $TwitchUserDTOCopyWith<$Res>(_self.twitchUser, (value) {
      return _then(_self.copyWith(twitchUser: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TwitchCredentialsDTO implements TwitchCredentialsDTO {
  const _TwitchCredentialsDTO(
      {required this.accessToken,
      required this.idToken,
      required this.refreshToken,
      required this.expiresIn,
      @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO)
      required this.decodedIdToken,
      @JsonKey(fromJson: _stringToTwitchUserDTO) required this.twitchUser,
      required this.scopes});
  factory _TwitchCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$TwitchCredentialsDTOFromJson(json);

  @override
  final String accessToken;
  @override
  final String idToken;
  @override
  final String refreshToken;
  @override
  final String expiresIn;
  @override
  @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO)
  final TwitchDecodedIdTokenDTO decodedIdToken;
  @override
  @JsonKey(fromJson: _stringToTwitchUserDTO)
  final TwitchUserDTO twitchUser;
  @override
  final String scopes;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchCredentialsDTOCopyWith<_TwitchCredentialsDTO> get copyWith =>
      __$TwitchCredentialsDTOCopyWithImpl<_TwitchCredentialsDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TwitchCredentialsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchCredentialsDTO &&
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

  @override
  String toString() {
    return 'TwitchCredentialsDTO(accessToken: $accessToken, idToken: $idToken, refreshToken: $refreshToken, expiresIn: $expiresIn, decodedIdToken: $decodedIdToken, twitchUser: $twitchUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class _$TwitchCredentialsDTOCopyWith<$Res>
    implements $TwitchCredentialsDTOCopyWith<$Res> {
  factory _$TwitchCredentialsDTOCopyWith(_TwitchCredentialsDTO value,
          $Res Function(_TwitchCredentialsDTO) _then) =
      __$TwitchCredentialsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String accessToken,
      String idToken,
      String refreshToken,
      String expiresIn,
      @JsonKey(fromJson: _stringToTwitchDecodedIdTokenDTO)
      TwitchDecodedIdTokenDTO decodedIdToken,
      @JsonKey(fromJson: _stringToTwitchUserDTO) TwitchUserDTO twitchUser,
      String scopes});

  @override
  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken;
  @override
  $TwitchUserDTOCopyWith<$Res> get twitchUser;
}

/// @nodoc
class __$TwitchCredentialsDTOCopyWithImpl<$Res>
    implements _$TwitchCredentialsDTOCopyWith<$Res> {
  __$TwitchCredentialsDTOCopyWithImpl(this._self, this._then);

  final _TwitchCredentialsDTO _self;
  final $Res Function(_TwitchCredentialsDTO) _then;

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? idToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? decodedIdToken = null,
    Object? twitchUser = null,
    Object? scopes = null,
  }) {
    return _then(_TwitchCredentialsDTO(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      idToken: null == idToken
          ? _self.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String,
      decodedIdToken: null == decodedIdToken
          ? _self.decodedIdToken
          : decodedIdToken // ignore: cast_nullable_to_non_nullable
              as TwitchDecodedIdTokenDTO,
      twitchUser: null == twitchUser
          ? _self.twitchUser
          : twitchUser // ignore: cast_nullable_to_non_nullable
              as TwitchUserDTO,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchDecodedIdTokenDTOCopyWith<$Res> get decodedIdToken {
    return $TwitchDecodedIdTokenDTOCopyWith<$Res>(_self.decodedIdToken,
        (value) {
      return _then(_self.copyWith(decodedIdToken: value));
    });
  }

  /// Create a copy of TwitchCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TwitchUserDTOCopyWith<$Res> get twitchUser {
    return $TwitchUserDTOCopyWith<$Res>(_self.twitchUser, (value) {
      return _then(_self.copyWith(twitchUser: value));
    });
  }
}

// dart format on
