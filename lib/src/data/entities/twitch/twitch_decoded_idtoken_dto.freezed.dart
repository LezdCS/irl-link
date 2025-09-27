// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_decoded_idtoken_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchDecodedIdTokenDTO {
  String get preferredUsername;
  String get profilePicture;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchDecodedIdTokenDTOCopyWith<TwitchDecodedIdTokenDTO> get copyWith =>
      _$TwitchDecodedIdTokenDTOCopyWithImpl<TwitchDecodedIdTokenDTO>(
          this as TwitchDecodedIdTokenDTO, _$identity);

  /// Serializes this TwitchDecodedIdTokenDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchDecodedIdTokenDTO &&
            (identical(other.preferredUsername, preferredUsername) ||
                other.preferredUsername == preferredUsername) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, preferredUsername, profilePicture);

  @override
  String toString() {
    return 'TwitchDecodedIdTokenDTO(preferredUsername: $preferredUsername, profilePicture: $profilePicture)';
  }
}

/// @nodoc
abstract mixin class $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  factory $TwitchDecodedIdTokenDTOCopyWith(TwitchDecodedIdTokenDTO value,
          $Res Function(TwitchDecodedIdTokenDTO) _then) =
      _$TwitchDecodedIdTokenDTOCopyWithImpl;
  @useResult
  $Res call({String preferredUsername, String profilePicture});
}

/// @nodoc
class _$TwitchDecodedIdTokenDTOCopyWithImpl<$Res>
    implements $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  _$TwitchDecodedIdTokenDTOCopyWithImpl(this._self, this._then);

  final TwitchDecodedIdTokenDTO _self;
  final $Res Function(TwitchDecodedIdTokenDTO) _then;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredUsername = null,
    Object? profilePicture = null,
  }) {
    return _then(_self.copyWith(
      preferredUsername: null == preferredUsername
          ? _self.preferredUsername
          : preferredUsername // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TwitchDecodedIdTokenDTO].
extension TwitchDecodedIdTokenDTOPatterns on TwitchDecodedIdTokenDTO {
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
    TResult Function(_TwitchDecodedIdTokenDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO() when $default != null:
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
    TResult Function(_TwitchDecodedIdTokenDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO():
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
    TResult? Function(_TwitchDecodedIdTokenDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO() when $default != null:
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
    TResult Function(String preferredUsername, String profilePicture)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO() when $default != null:
        return $default(_that.preferredUsername, _that.profilePicture);
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
    TResult Function(String preferredUsername, String profilePicture) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO():
        return $default(_that.preferredUsername, _that.profilePicture);
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
    TResult? Function(String preferredUsername, String profilePicture)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchDecodedIdTokenDTO() when $default != null:
        return $default(_that.preferredUsername, _that.profilePicture);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TwitchDecodedIdTokenDTO implements TwitchDecodedIdTokenDTO {
  const _TwitchDecodedIdTokenDTO(
      {required this.preferredUsername, required this.profilePicture});
  factory _TwitchDecodedIdTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TwitchDecodedIdTokenDTOFromJson(json);

  @override
  final String preferredUsername;
  @override
  final String profilePicture;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchDecodedIdTokenDTOCopyWith<_TwitchDecodedIdTokenDTO> get copyWith =>
      __$TwitchDecodedIdTokenDTOCopyWithImpl<_TwitchDecodedIdTokenDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TwitchDecodedIdTokenDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchDecodedIdTokenDTO &&
            (identical(other.preferredUsername, preferredUsername) ||
                other.preferredUsername == preferredUsername) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, preferredUsername, profilePicture);

  @override
  String toString() {
    return 'TwitchDecodedIdTokenDTO(preferredUsername: $preferredUsername, profilePicture: $profilePicture)';
  }
}

/// @nodoc
abstract mixin class _$TwitchDecodedIdTokenDTOCopyWith<$Res>
    implements $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  factory _$TwitchDecodedIdTokenDTOCopyWith(_TwitchDecodedIdTokenDTO value,
          $Res Function(_TwitchDecodedIdTokenDTO) _then) =
      __$TwitchDecodedIdTokenDTOCopyWithImpl;
  @override
  @useResult
  $Res call({String preferredUsername, String profilePicture});
}

/// @nodoc
class __$TwitchDecodedIdTokenDTOCopyWithImpl<$Res>
    implements _$TwitchDecodedIdTokenDTOCopyWith<$Res> {
  __$TwitchDecodedIdTokenDTOCopyWithImpl(this._self, this._then);

  final _TwitchDecodedIdTokenDTO _self;
  final $Res Function(_TwitchDecodedIdTokenDTO) _then;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? preferredUsername = null,
    Object? profilePicture = null,
  }) {
    return _then(_TwitchDecodedIdTokenDTO(
      preferredUsername: null == preferredUsername
          ? _self.preferredUsername
          : preferredUsername // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
