// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_me_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeMeDTO {
  @JsonKey(name: '_id')
  String get id;
  String get avatar;
  String get username;
  String get displayName;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeMeDTOCopyWith<SeMeDTO> get copyWith =>
      _$SeMeDTOCopyWithImpl<SeMeDTO>(this as SeMeDTO, _$identity);

  /// Serializes this SeMeDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeMeDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, avatar, username, displayName);

  @override
  String toString() {
    return 'SeMeDTO(id: $id, avatar: $avatar, username: $username, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class $SeMeDTOCopyWith<$Res> {
  factory $SeMeDTOCopyWith(SeMeDTO value, $Res Function(SeMeDTO) _then) =
      _$SeMeDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String avatar,
      String username,
      String displayName});
}

/// @nodoc
class _$SeMeDTOCopyWithImpl<$Res> implements $SeMeDTOCopyWith<$Res> {
  _$SeMeDTOCopyWithImpl(this._self, this._then);

  final SeMeDTO _self;
  final $Res Function(SeMeDTO) _then;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatar = null,
    Object? username = null,
    Object? displayName = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeMeDTO].
extension SeMeDTOPatterns on SeMeDTO {
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
    TResult Function(_SeMeDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO() when $default != null:
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
    TResult Function(_SeMeDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO():
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
    TResult? Function(_SeMeDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO() when $default != null:
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
    TResult Function(@JsonKey(name: '_id') String id, String avatar,
            String username, String displayName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO() when $default != null:
        return $default(
            _that.id, _that.avatar, _that.username, _that.displayName);
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
    TResult Function(@JsonKey(name: '_id') String id, String avatar,
            String username, String displayName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO():
        return $default(
            _that.id, _that.avatar, _that.username, _that.displayName);
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
    TResult? Function(@JsonKey(name: '_id') String id, String avatar,
            String username, String displayName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeMeDTO() when $default != null:
        return $default(
            _that.id, _that.avatar, _that.username, _that.displayName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeMeDTO implements SeMeDTO {
  const _SeMeDTO(
      {@JsonKey(name: '_id') required this.id,
      required this.avatar,
      required this.username,
      required this.displayName});
  factory _SeMeDTO.fromJson(Map<String, dynamic> json) =>
      _$SeMeDTOFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String avatar;
  @override
  final String username;
  @override
  final String displayName;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeMeDTOCopyWith<_SeMeDTO> get copyWith =>
      __$SeMeDTOCopyWithImpl<_SeMeDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeMeDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeMeDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, avatar, username, displayName);

  @override
  String toString() {
    return 'SeMeDTO(id: $id, avatar: $avatar, username: $username, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class _$SeMeDTOCopyWith<$Res> implements $SeMeDTOCopyWith<$Res> {
  factory _$SeMeDTOCopyWith(_SeMeDTO value, $Res Function(_SeMeDTO) _then) =
      __$SeMeDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String avatar,
      String username,
      String displayName});
}

/// @nodoc
class __$SeMeDTOCopyWithImpl<$Res> implements _$SeMeDTOCopyWith<$Res> {
  __$SeMeDTOCopyWithImpl(this._self, this._then);

  final _SeMeDTO _self;
  final $Res Function(_SeMeDTO) _then;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? avatar = null,
    Object? username = null,
    Object? displayName = null,
  }) {
    return _then(_SeMeDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
