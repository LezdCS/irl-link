// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_credentials_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickCredentialsDTO {
  String get accessToken;
  String get refreshToken;
  int get expiresIn;
  KickUserDTO get kickUser;
  String get scopes;

  /// Create a copy of KickCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickCredentialsDTOCopyWith<KickCredentialsDTO> get copyWith =>
      _$KickCredentialsDTOCopyWithImpl<KickCredentialsDTO>(
          this as KickCredentialsDTO, _$identity);

  /// Serializes this KickCredentialsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickCredentialsDTO &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, accessToken, refreshToken, expiresIn, kickUser, scopes);

  @override
  String toString() {
    return 'KickCredentialsDTO(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, kickUser: $kickUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class $KickCredentialsDTOCopyWith<$Res> {
  factory $KickCredentialsDTOCopyWith(
          KickCredentialsDTO value, $Res Function(KickCredentialsDTO) _then) =
      _$KickCredentialsDTOCopyWithImpl;
  @useResult
  $Res call(
      {String accessToken,
      String refreshToken,
      int expiresIn,
      KickUserDTO kickUser,
      String scopes});

  $KickUserDTOCopyWith<$Res> get kickUser;
}

/// @nodoc
class _$KickCredentialsDTOCopyWithImpl<$Res>
    implements $KickCredentialsDTOCopyWith<$Res> {
  _$KickCredentialsDTOCopyWithImpl(this._self, this._then);

  final KickCredentialsDTO _self;
  final $Res Function(KickCredentialsDTO) _then;

  /// Create a copy of KickCredentialsDTO
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
              as int,
      kickUser: null == kickUser
          ? _self.kickUser
          : kickUser // ignore: cast_nullable_to_non_nullable
              as KickUserDTO,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickUserDTOCopyWith<$Res> get kickUser {
    return $KickUserDTOCopyWith<$Res>(_self.kickUser, (value) {
      return _then(_self.copyWith(kickUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [KickCredentialsDTO].
extension KickCredentialsDTOPatterns on KickCredentialsDTO {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_KickCredentialsDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_KickCredentialsDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_KickCredentialsDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String accessToken, String refreshToken, int expiresIn,
            KickUserDTO kickUser, String scopes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO() when $default != null:
        return $default(_that.accessToken, _that.refreshToken, _that.expiresIn,
            _that.kickUser, _that.scopes);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String accessToken, String refreshToken, int expiresIn,
            KickUserDTO kickUser, String scopes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO():
        return $default(_that.accessToken, _that.refreshToken, _that.expiresIn,
            _that.kickUser, _that.scopes);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String accessToken, String refreshToken, int expiresIn,
            KickUserDTO kickUser, String scopes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCredentialsDTO() when $default != null:
        return $default(_that.accessToken, _that.refreshToken, _that.expiresIn,
            _that.kickUser, _that.scopes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _KickCredentialsDTO implements KickCredentialsDTO {
  const _KickCredentialsDTO(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.kickUser,
      required this.scopes});
  factory _KickCredentialsDTO.fromJson(Map<String, dynamic> json) =>
      _$KickCredentialsDTOFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int expiresIn;
  @override
  final KickUserDTO kickUser;
  @override
  final String scopes;

  /// Create a copy of KickCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickCredentialsDTOCopyWith<_KickCredentialsDTO> get copyWith =>
      __$KickCredentialsDTOCopyWithImpl<_KickCredentialsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KickCredentialsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickCredentialsDTO &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, accessToken, refreshToken, expiresIn, kickUser, scopes);

  @override
  String toString() {
    return 'KickCredentialsDTO(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, kickUser: $kickUser, scopes: $scopes)';
  }
}

/// @nodoc
abstract mixin class _$KickCredentialsDTOCopyWith<$Res>
    implements $KickCredentialsDTOCopyWith<$Res> {
  factory _$KickCredentialsDTOCopyWith(
          _KickCredentialsDTO value, $Res Function(_KickCredentialsDTO) _then) =
      __$KickCredentialsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String accessToken,
      String refreshToken,
      int expiresIn,
      KickUserDTO kickUser,
      String scopes});

  @override
  $KickUserDTOCopyWith<$Res> get kickUser;
}

/// @nodoc
class __$KickCredentialsDTOCopyWithImpl<$Res>
    implements _$KickCredentialsDTOCopyWith<$Res> {
  __$KickCredentialsDTOCopyWithImpl(this._self, this._then);

  final _KickCredentialsDTO _self;
  final $Res Function(_KickCredentialsDTO) _then;

  /// Create a copy of KickCredentialsDTO
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
    return _then(_KickCredentialsDTO(
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
      kickUser: null == kickUser
          ? _self.kickUser
          : kickUser // ignore: cast_nullable_to_non_nullable
              as KickUserDTO,
      scopes: null == scopes
          ? _self.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickCredentialsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickUserDTOCopyWith<$Res> get kickUser {
    return $KickUserDTOCopyWith<$Res>(_self.kickUser, (value) {
      return _then(_self.copyWith(kickUser: value));
    });
  }
}

// dart format on
