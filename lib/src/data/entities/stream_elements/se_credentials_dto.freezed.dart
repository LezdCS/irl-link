// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_credentials_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeCredentialsDTO {
  @JsonKey(name: 'access_token')
  String get accessToken;
  @JsonKey(name: 'refresh_token')
  String get refreshToken;
  @JsonKey(name: 'expires_in')
  int get expiresIn;
  @JsonKey(name: 'scopes')
  String get scopes;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeCredentialsDTOCopyWith<SeCredentialsDTO> get copyWith =>
      _$SeCredentialsDTOCopyWithImpl<SeCredentialsDTO>(
          this as SeCredentialsDTO, _$identity);

  /// Serializes this SeCredentialsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeCredentialsDTO &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.scopes, scopes) || other.scopes == scopes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresIn, scopes);

  @override
  String toString() {
    return 'SeCredentialsDTO(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class $SeCredentialsDTOCopyWith<$Res> {
  factory $SeCredentialsDTOCopyWith(
          SeCredentialsDTO value, $Res Function(SeCredentialsDTO) _then) =
      _$SeCredentialsDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'expires_in') int expiresIn,
      @JsonKey(name: 'scopes') String scopes});
}

/// @nodoc
class _$SeCredentialsDTOCopyWithImpl<$Res>
    implements $SeCredentialsDTOCopyWith<$Res> {
  _$SeCredentialsDTOCopyWithImpl(this._self, this._then);

  final SeCredentialsDTO _self;
  final $Res Function(SeCredentialsDTO) _then;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
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
              as int,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SeCredentialsDTO implements SeCredentialsDTO {
  const _SeCredentialsDTO(
      {@JsonKey(name: 'access_token') required this.accessToken,
      @JsonKey(name: 'refresh_token') required this.refreshToken,
      @JsonKey(name: 'expires_in') required this.expiresIn,
      @JsonKey(name: 'scopes') required this.scopes});
  factory _SeCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$SeCredentialsDTOFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @override
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  @override
  @JsonKey(name: 'scopes')
  final String scopes;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeCredentialsDTOCopyWith<_SeCredentialsDTO> get copyWith =>
      __$SeCredentialsDTOCopyWithImpl<_SeCredentialsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeCredentialsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeCredentialsDTO &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.scopes, scopes) || other.scopes == scopes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresIn, scopes);

  @override
  String toString() {
    return 'SeCredentialsDTO(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class _$SeCredentialsDTOCopyWith<$Res>
    implements $SeCredentialsDTOCopyWith<$Res> {
  factory _$SeCredentialsDTOCopyWith(
          _SeCredentialsDTO value, $Res Function(_SeCredentialsDTO) _then) =
      __$SeCredentialsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'expires_in') int expiresIn,
      @JsonKey(name: 'scopes') String scopes});
}

/// @nodoc
class __$SeCredentialsDTOCopyWithImpl<$Res>
    implements _$SeCredentialsDTOCopyWith<$Res> {
  __$SeCredentialsDTOCopyWithImpl(this._self, this._then);

  final _SeCredentialsDTO _self;
  final $Res Function(_SeCredentialsDTO) _then;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? scopes = null,
  }) {
    return _then(_SeCredentialsDTO(
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
              as int,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
