// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickCategoryDTO {
  @JsonKey(name: 'id')
  int get id;
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'thumbnail')
  String get thumbnail;

  /// Create a copy of KickCategoryDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickCategoryDTOCopyWith<KickCategoryDTO> get copyWith =>
      _$KickCategoryDTOCopyWithImpl<KickCategoryDTO>(
          this as KickCategoryDTO, _$identity);

  /// Serializes this KickCategoryDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickCategoryDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, thumbnail);

  @override
  String toString() {
    return 'KickCategoryDTO(id: $id, name: $name, thumbnail: $thumbnail)';
  }
}

/// @nodoc
abstract mixin class $KickCategoryDTOCopyWith<$Res> {
  factory $KickCategoryDTOCopyWith(
          KickCategoryDTO value, $Res Function(KickCategoryDTO) _then) =
      _$KickCategoryDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'thumbnail') String thumbnail});
}

/// @nodoc
class _$KickCategoryDTOCopyWithImpl<$Res>
    implements $KickCategoryDTOCopyWith<$Res> {
  _$KickCategoryDTOCopyWithImpl(this._self, this._then);

  final KickCategoryDTO _self;
  final $Res Function(KickCategoryDTO) _then;

  /// Create a copy of KickCategoryDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnail = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [KickCategoryDTO].
extension KickCategoryDTOPatterns on KickCategoryDTO {
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
    TResult Function(_KickCategoryDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO() when $default != null:
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
    TResult Function(_KickCategoryDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO():
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
    TResult? Function(_KickCategoryDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO() when $default != null:
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
    TResult Function(
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'thumbnail') String thumbnail)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO() when $default != null:
        return $default(_that.id, _that.name, _that.thumbnail);
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
    TResult Function(
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'thumbnail') String thumbnail)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO():
        return $default(_that.id, _that.name, _that.thumbnail);
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
    TResult? Function(
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'thumbnail') String thumbnail)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KickCategoryDTO() when $default != null:
        return $default(_that.id, _that.name, _that.thumbnail);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _KickCategoryDTO implements KickCategoryDTO {
  const _KickCategoryDTO(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'thumbnail') required this.thumbnail});
  factory _KickCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$KickCategoryDTOFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  /// Create a copy of KickCategoryDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickCategoryDTOCopyWith<_KickCategoryDTO> get copyWith =>
      __$KickCategoryDTOCopyWithImpl<_KickCategoryDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KickCategoryDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickCategoryDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, thumbnail);

  @override
  String toString() {
    return 'KickCategoryDTO(id: $id, name: $name, thumbnail: $thumbnail)';
  }
}

/// @nodoc
abstract mixin class _$KickCategoryDTOCopyWith<$Res>
    implements $KickCategoryDTOCopyWith<$Res> {
  factory _$KickCategoryDTOCopyWith(
          _KickCategoryDTO value, $Res Function(_KickCategoryDTO) _then) =
      __$KickCategoryDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'thumbnail') String thumbnail});
}

/// @nodoc
class __$KickCategoryDTOCopyWithImpl<$Res>
    implements _$KickCategoryDTOCopyWith<$Res> {
  __$KickCategoryDTOCopyWithImpl(this._self, this._then);

  final _KickCategoryDTO _self;
  final $Res Function(_KickCategoryDTO) _then;

  /// Create a copy of KickCategoryDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnail = null,
  }) {
    return _then(_KickCategoryDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
