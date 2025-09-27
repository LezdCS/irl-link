// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitchUserDTO {
  String get id;
  String get login;
  @JsonKey(name: 'display_name')
  String get displayName;
  @JsonKey(name: 'broadcaster_type')
  String get broadcasterType;
  String get description;
  @JsonKey(name: 'profile_image_url')
  String get profileImageUrl;
  @JsonKey(name: 'view_count', fromJson: _stringToInt)
  int get viewCount;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TwitchUserDTOCopyWith<TwitchUserDTO> get copyWith =>
      _$TwitchUserDTOCopyWithImpl<TwitchUserDTO>(
          this as TwitchUserDTO, _$identity);

  /// Serializes this TwitchUserDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TwitchUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.broadcasterType, broadcasterType) ||
                other.broadcasterType == broadcasterType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, login, displayName,
      broadcasterType, description, profileImageUrl, viewCount);

  @override
  String toString() {
    return 'TwitchUserDTO(id: $id, login: $login, displayName: $displayName, broadcasterType: $broadcasterType, description: $description, profileImageUrl: $profileImageUrl, viewCount: $viewCount)';
  }
}

/// @nodoc
abstract mixin class $TwitchUserDTOCopyWith<$Res> {
  factory $TwitchUserDTOCopyWith(
          TwitchUserDTO value, $Res Function(TwitchUserDTO) _then) =
      _$TwitchUserDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String login,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'broadcaster_type') String broadcasterType,
      String description,
      @JsonKey(name: 'profile_image_url') String profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount});
}

/// @nodoc
class _$TwitchUserDTOCopyWithImpl<$Res>
    implements $TwitchUserDTOCopyWith<$Res> {
  _$TwitchUserDTOCopyWithImpl(this._self, this._then);

  final TwitchUserDTO _self;
  final $Res Function(TwitchUserDTO) _then;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? displayName = null,
    Object? broadcasterType = null,
    Object? description = null,
    Object? profileImageUrl = null,
    Object? viewCount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _self.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterType: null == broadcasterType
          ? _self.broadcasterType
          : broadcasterType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _self.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TwitchUserDTO].
extension TwitchUserDTOPatterns on TwitchUserDTO {
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
    TResult Function(_TwitchUserDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO() when $default != null:
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
    TResult Function(_TwitchUserDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO():
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
    TResult? Function(_TwitchUserDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO() when $default != null:
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
            String login,
            @JsonKey(name: 'display_name') String displayName,
            @JsonKey(name: 'broadcaster_type') String broadcasterType,
            String description,
            @JsonKey(name: 'profile_image_url') String profileImageUrl,
            @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO() when $default != null:
        return $default(
            _that.id,
            _that.login,
            _that.displayName,
            _that.broadcasterType,
            _that.description,
            _that.profileImageUrl,
            _that.viewCount);
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
            String login,
            @JsonKey(name: 'display_name') String displayName,
            @JsonKey(name: 'broadcaster_type') String broadcasterType,
            String description,
            @JsonKey(name: 'profile_image_url') String profileImageUrl,
            @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO():
        return $default(
            _that.id,
            _that.login,
            _that.displayName,
            _that.broadcasterType,
            _that.description,
            _that.profileImageUrl,
            _that.viewCount);
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
            String login,
            @JsonKey(name: 'display_name') String displayName,
            @JsonKey(name: 'broadcaster_type') String broadcasterType,
            String description,
            @JsonKey(name: 'profile_image_url') String profileImageUrl,
            @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TwitchUserDTO() when $default != null:
        return $default(
            _that.id,
            _that.login,
            _that.displayName,
            _that.broadcasterType,
            _that.description,
            _that.profileImageUrl,
            _that.viewCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TwitchUserDTO implements TwitchUserDTO {
  const _TwitchUserDTO(
      {required this.id,
      required this.login,
      @JsonKey(name: 'display_name') required this.displayName,
      @JsonKey(name: 'broadcaster_type') required this.broadcasterType,
      required this.description,
      @JsonKey(name: 'profile_image_url') required this.profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt)
      required this.viewCount});
  factory _TwitchUserDTO.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserDTOFromJson(json);

  @override
  final String id;
  @override
  final String login;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'broadcaster_type')
  final String broadcasterType;
  @override
  final String description;
  @override
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;
  @override
  @JsonKey(name: 'view_count', fromJson: _stringToInt)
  final int viewCount;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TwitchUserDTOCopyWith<_TwitchUserDTO> get copyWith =>
      __$TwitchUserDTOCopyWithImpl<_TwitchUserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TwitchUserDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TwitchUserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.broadcasterType, broadcasterType) ||
                other.broadcasterType == broadcasterType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, login, displayName,
      broadcasterType, description, profileImageUrl, viewCount);

  @override
  String toString() {
    return 'TwitchUserDTO(id: $id, login: $login, displayName: $displayName, broadcasterType: $broadcasterType, description: $description, profileImageUrl: $profileImageUrl, viewCount: $viewCount)';
  }
}

/// @nodoc
abstract mixin class _$TwitchUserDTOCopyWith<$Res>
    implements $TwitchUserDTOCopyWith<$Res> {
  factory _$TwitchUserDTOCopyWith(
          _TwitchUserDTO value, $Res Function(_TwitchUserDTO) _then) =
      __$TwitchUserDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String login,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'broadcaster_type') String broadcasterType,
      String description,
      @JsonKey(name: 'profile_image_url') String profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount});
}

/// @nodoc
class __$TwitchUserDTOCopyWithImpl<$Res>
    implements _$TwitchUserDTOCopyWith<$Res> {
  __$TwitchUserDTOCopyWithImpl(this._self, this._then);

  final _TwitchUserDTO _self;
  final $Res Function(_TwitchUserDTO) _then;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? displayName = null,
    Object? broadcasterType = null,
    Object? description = null,
    Object? profileImageUrl = null,
    Object? viewCount = null,
  }) {
    return _then(_TwitchUserDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _self.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterType: null == broadcasterType
          ? _self.broadcasterType
          : broadcasterType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _self.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
