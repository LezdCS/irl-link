// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_credentials_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SeCredentialsDTO _$SeCredentialsDTOFromJson(Map<String, dynamic> json) {
  return _SeCredentialsDTO.fromJson(json);
}

/// @nodoc
mixin _$SeCredentialsDTO {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  String get scopes => throw _privateConstructorUsedError;

  /// Serializes this SeCredentialsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeCredentialsDTOCopyWith<SeCredentialsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeCredentialsDTOCopyWith<$Res> {
  factory $SeCredentialsDTOCopyWith(
          SeCredentialsDTO value, $Res Function(SeCredentialsDTO) then) =
      _$SeCredentialsDTOCopyWithImpl<$Res, SeCredentialsDTO>;
  @useResult
  $Res call(
      {String accessToken, String refreshToken, int expiresIn, String scopes});
}

/// @nodoc
class _$SeCredentialsDTOCopyWithImpl<$Res, $Val extends SeCredentialsDTO>
    implements $SeCredentialsDTOCopyWith<$Res> {
  _$SeCredentialsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeCredentialsDTOImplCopyWith<$Res>
    implements $SeCredentialsDTOCopyWith<$Res> {
  factory _$$SeCredentialsDTOImplCopyWith(_$SeCredentialsDTOImpl value,
          $Res Function(_$SeCredentialsDTOImpl) then) =
      __$$SeCredentialsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accessToken, String refreshToken, int expiresIn, String scopes});
}

/// @nodoc
class __$$SeCredentialsDTOImplCopyWithImpl<$Res>
    extends _$SeCredentialsDTOCopyWithImpl<$Res, _$SeCredentialsDTOImpl>
    implements _$$SeCredentialsDTOImplCopyWith<$Res> {
  __$$SeCredentialsDTOImplCopyWithImpl(_$SeCredentialsDTOImpl _value,
      $Res Function(_$SeCredentialsDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$SeCredentialsDTOImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeCredentialsDTOImpl implements _SeCredentialsDTO {
  const _$SeCredentialsDTOImpl(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.scopes});

  factory _$SeCredentialsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeCredentialsDTOImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int expiresIn;
  @override
  final String scopes;

  @override
  String toString() {
    return 'SeCredentialsDTO(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, scopes: $scopes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeCredentialsDTOImpl &&
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

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeCredentialsDTOImplCopyWith<_$SeCredentialsDTOImpl> get copyWith =>
      __$$SeCredentialsDTOImplCopyWithImpl<_$SeCredentialsDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeCredentialsDTOImplToJson(
      this,
    );
  }
}

abstract class _SeCredentialsDTO implements SeCredentialsDTO {
  const factory _SeCredentialsDTO(
      {required final String accessToken,
      required final String refreshToken,
      required final int expiresIn,
      required final String scopes}) = _$SeCredentialsDTOImpl;

  factory _SeCredentialsDTO.fromJson(Map<String, dynamic> json) =
      _$SeCredentialsDTOImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  int get expiresIn;
  @override
  String get scopes;

  /// Create a copy of SeCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeCredentialsDTOImplCopyWith<_$SeCredentialsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
