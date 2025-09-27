// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_overlay_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeOverlayDTO {
  @JsonKey(name: '_id')
  String get id;
  String get name;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeOverlayDTOCopyWith<SeOverlayDTO> get copyWith =>
      _$SeOverlayDTOCopyWithImpl<SeOverlayDTO>(
          this as SeOverlayDTO, _$identity);

  /// Serializes this SeOverlayDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeOverlayDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'SeOverlayDTO(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $SeOverlayDTOCopyWith<$Res> {
  factory $SeOverlayDTOCopyWith(
          SeOverlayDTO value, $Res Function(SeOverlayDTO) _then) =
      _$SeOverlayDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class _$SeOverlayDTOCopyWithImpl<$Res> implements $SeOverlayDTOCopyWith<$Res> {
  _$SeOverlayDTOCopyWithImpl(this._self, this._then);

  final SeOverlayDTO _self;
  final $Res Function(SeOverlayDTO) _then;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeOverlayDTO].
extension SeOverlayDTOPatterns on SeOverlayDTO {
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
    TResult Function(_SeOverlayDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO() when $default != null:
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
    TResult Function(_SeOverlayDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO():
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
    TResult? Function(_SeOverlayDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO() when $default != null:
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
    TResult Function(@JsonKey(name: '_id') String id, String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(@JsonKey(name: '_id') String id, String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO():
        return $default(_that.id, _that.name);
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
    TResult? Function(@JsonKey(name: '_id') String id, String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeOverlayDTO() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeOverlayDTO implements SeOverlayDTO {
  const _SeOverlayDTO(
      {@JsonKey(name: '_id') required this.id, required this.name});
  factory _SeOverlayDTO.fromJson(Map<String, dynamic> json) =>
      _$SeOverlayDTOFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeOverlayDTOCopyWith<_SeOverlayDTO> get copyWith =>
      __$SeOverlayDTOCopyWithImpl<_SeOverlayDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeOverlayDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeOverlayDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'SeOverlayDTO(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$SeOverlayDTOCopyWith<$Res>
    implements $SeOverlayDTOCopyWith<$Res> {
  factory _$SeOverlayDTOCopyWith(
          _SeOverlayDTO value, $Res Function(_SeOverlayDTO) _then) =
      __$SeOverlayDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class __$SeOverlayDTOCopyWithImpl<$Res>
    implements _$SeOverlayDTOCopyWith<$Res> {
  __$SeOverlayDTOCopyWithImpl(this._self, this._then);

  final _SeOverlayDTO _self;
  final $Res Function(_SeOverlayDTO) _then;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_SeOverlayDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
