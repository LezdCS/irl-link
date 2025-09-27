// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserTabDTO {
  String get id;
  String get title;
  String get url;
  @BoolToIntConverter()
  bool get toggled;
  @JsonKey(name: 'is_ios_audio_source')
  @BoolToIntConverter()
  bool get iOSAudioSource;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserTabDTOCopyWith<BrowserTabDTO> get copyWith =>
      _$BrowserTabDTOCopyWithImpl<BrowserTabDTO>(
          this as BrowserTabDTO, _$identity);

  /// Serializes this BrowserTabDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrowserTabDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.toggled, toggled) || other.toggled == toggled) &&
            (identical(other.iOSAudioSource, iOSAudioSource) ||
                other.iOSAudioSource == iOSAudioSource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, url, toggled, iOSAudioSource);

  @override
  String toString() {
    return 'BrowserTabDTO(id: $id, title: $title, url: $url, toggled: $toggled, iOSAudioSource: $iOSAudioSource)';
  }
}

/// @nodoc
abstract mixin class $BrowserTabDTOCopyWith<$Res> {
  factory $BrowserTabDTOCopyWith(
          BrowserTabDTO value, $Res Function(BrowserTabDTO) _then) =
      _$BrowserTabDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String url,
      @BoolToIntConverter() bool toggled,
      @JsonKey(name: 'is_ios_audio_source')
      @BoolToIntConverter()
      bool iOSAudioSource});
}

/// @nodoc
class _$BrowserTabDTOCopyWithImpl<$Res>
    implements $BrowserTabDTOCopyWith<$Res> {
  _$BrowserTabDTOCopyWithImpl(this._self, this._then);

  final BrowserTabDTO _self;
  final $Res Function(BrowserTabDTO) _then;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? toggled = null,
    Object? iOSAudioSource = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      toggled: null == toggled
          ? _self.toggled
          : toggled // ignore: cast_nullable_to_non_nullable
              as bool,
      iOSAudioSource: null == iOSAudioSource
          ? _self.iOSAudioSource
          : iOSAudioSource // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrowserTabDTO].
extension BrowserTabDTOPatterns on BrowserTabDTO {
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
    TResult Function(_BrowserTabDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO() when $default != null:
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
    TResult Function(_BrowserTabDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO():
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
    TResult? Function(_BrowserTabDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO() when $default != null:
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
            String id,
            String title,
            String url,
            @BoolToIntConverter() bool toggled,
            @JsonKey(name: 'is_ios_audio_source')
            @BoolToIntConverter()
            bool iOSAudioSource)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.toggled,
            _that.iOSAudioSource);
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
            String id,
            String title,
            String url,
            @BoolToIntConverter() bool toggled,
            @JsonKey(name: 'is_ios_audio_source')
            @BoolToIntConverter()
            bool iOSAudioSource)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO():
        return $default(_that.id, _that.title, _that.url, _that.toggled,
            _that.iOSAudioSource);
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
            String id,
            String title,
            String url,
            @BoolToIntConverter() bool toggled,
            @JsonKey(name: 'is_ios_audio_source')
            @BoolToIntConverter()
            bool iOSAudioSource)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowserTabDTO() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.toggled,
            _that.iOSAudioSource);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserTabDTO implements BrowserTabDTO {
  const _BrowserTabDTO(
      {required this.id,
      required this.title,
      required this.url,
      @BoolToIntConverter() required this.toggled,
      @JsonKey(name: 'is_ios_audio_source')
      @BoolToIntConverter()
      required this.iOSAudioSource});
  factory _BrowserTabDTO.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabDTOFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String url;
  @override
  @BoolToIntConverter()
  final bool toggled;
  @override
  @JsonKey(name: 'is_ios_audio_source')
  @BoolToIntConverter()
  final bool iOSAudioSource;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserTabDTOCopyWith<_BrowserTabDTO> get copyWith =>
      __$BrowserTabDTOCopyWithImpl<_BrowserTabDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserTabDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrowserTabDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.toggled, toggled) || other.toggled == toggled) &&
            (identical(other.iOSAudioSource, iOSAudioSource) ||
                other.iOSAudioSource == iOSAudioSource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, url, toggled, iOSAudioSource);

  @override
  String toString() {
    return 'BrowserTabDTO(id: $id, title: $title, url: $url, toggled: $toggled, iOSAudioSource: $iOSAudioSource)';
  }
}

/// @nodoc
abstract mixin class _$BrowserTabDTOCopyWith<$Res>
    implements $BrowserTabDTOCopyWith<$Res> {
  factory _$BrowserTabDTOCopyWith(
          _BrowserTabDTO value, $Res Function(_BrowserTabDTO) _then) =
      __$BrowserTabDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String url,
      @BoolToIntConverter() bool toggled,
      @JsonKey(name: 'is_ios_audio_source')
      @BoolToIntConverter()
      bool iOSAudioSource});
}

/// @nodoc
class __$BrowserTabDTOCopyWithImpl<$Res>
    implements _$BrowserTabDTOCopyWith<$Res> {
  __$BrowserTabDTOCopyWithImpl(this._self, this._then);

  final _BrowserTabDTO _self;
  final $Res Function(_BrowserTabDTO) _then;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? toggled = null,
    Object? iOSAudioSource = null,
  }) {
    return _then(_BrowserTabDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      toggled: null == toggled
          ? _self.toggled
          : toggled // ignore: cast_nullable_to_non_nullable
              as bool,
      iOSAudioSource: null == iOSAudioSource
          ? _self.iOSAudioSource
          : iOSAudioSource // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
