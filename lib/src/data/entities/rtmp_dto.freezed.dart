// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rtmp_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RtmpDTO {
  int get id;
  String get name;
  String get url;
  String get key;
  DateTime get createdAt;

  /// Create a copy of RtmpDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RtmpDTOCopyWith<RtmpDTO> get copyWith =>
      _$RtmpDTOCopyWithImpl<RtmpDTO>(this as RtmpDTO, _$identity);

  /// Serializes this RtmpDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RtmpDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, url, key, createdAt);

  @override
  String toString() {
    return 'RtmpDTO(id: $id, name: $name, url: $url, key: $key, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $RtmpDTOCopyWith<$Res> {
  factory $RtmpDTOCopyWith(RtmpDTO value, $Res Function(RtmpDTO) _then) =
      _$RtmpDTOCopyWithImpl;
  @useResult
  $Res call({int id, String name, String url, String key, DateTime createdAt});
}

/// @nodoc
class _$RtmpDTOCopyWithImpl<$Res> implements $RtmpDTOCopyWith<$Res> {
  _$RtmpDTOCopyWithImpl(this._self, this._then);

  final RtmpDTO _self;
  final $Res Function(RtmpDTO) _then;

  /// Create a copy of RtmpDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? key = null,
    Object? createdAt = null,
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
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [RtmpDTO].
extension RtmpDTOPatterns on RtmpDTO {
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
    TResult Function(_RtmpDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO() when $default != null:
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
    TResult Function(_RtmpDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO():
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
    TResult? Function(_RtmpDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO() when $default != null:
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
            int id, String name, String url, String key, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO() when $default != null:
        return $default(
            _that.id, _that.name, _that.url, _that.key, _that.createdAt);
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
            int id, String name, String url, String key, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO():
        return $default(
            _that.id, _that.name, _that.url, _that.key, _that.createdAt);
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
            int id, String name, String url, String key, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RtmpDTO() when $default != null:
        return $default(
            _that.id, _that.name, _that.url, _that.key, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RtmpDTO implements RtmpDTO {
  const _RtmpDTO(
      {required this.id,
      required this.name,
      required this.url,
      required this.key,
      required this.createdAt});
  factory _RtmpDTO.fromJson(Map<String, dynamic> json) =>
      _$RtmpDTOFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String url;
  @override
  final String key;
  @override
  final DateTime createdAt;

  /// Create a copy of RtmpDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RtmpDTOCopyWith<_RtmpDTO> get copyWith =>
      __$RtmpDTOCopyWithImpl<_RtmpDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RtmpDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RtmpDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, url, key, createdAt);

  @override
  String toString() {
    return 'RtmpDTO(id: $id, name: $name, url: $url, key: $key, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$RtmpDTOCopyWith<$Res> implements $RtmpDTOCopyWith<$Res> {
  factory _$RtmpDTOCopyWith(_RtmpDTO value, $Res Function(_RtmpDTO) _then) =
      __$RtmpDTOCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, String url, String key, DateTime createdAt});
}

/// @nodoc
class __$RtmpDTOCopyWithImpl<$Res> implements _$RtmpDTOCopyWith<$Res> {
  __$RtmpDTOCopyWithImpl(this._self, this._then);

  final _RtmpDTO _self;
  final $Res Function(_RtmpDTO) _then;

  /// Create a copy of RtmpDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? key = null,
    Object? createdAt = null,
  }) {
    return _then(_RtmpDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
