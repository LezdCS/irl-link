// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatSettingsDTO {
  bool get hideDeletedMessages;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatSettingsDTOCopyWith<ChatSettingsDTO> get copyWith =>
      _$ChatSettingsDTOCopyWithImpl<ChatSettingsDTO>(
          this as ChatSettingsDTO, _$identity);

  /// Serializes this ChatSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatSettingsDTO &&
            (identical(other.hideDeletedMessages, hideDeletedMessages) ||
                other.hideDeletedMessages == hideDeletedMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hideDeletedMessages);

  @override
  String toString() {
    return 'ChatSettingsDTO(hideDeletedMessages: $hideDeletedMessages)';
  }
}

/// @nodoc
abstract mixin class $ChatSettingsDTOCopyWith<$Res> {
  factory $ChatSettingsDTOCopyWith(
          ChatSettingsDTO value, $Res Function(ChatSettingsDTO) _then) =
      _$ChatSettingsDTOCopyWithImpl;
  @useResult
  $Res call({bool hideDeletedMessages});
}

/// @nodoc
class _$ChatSettingsDTOCopyWithImpl<$Res>
    implements $ChatSettingsDTOCopyWith<$Res> {
  _$ChatSettingsDTOCopyWithImpl(this._self, this._then);

  final ChatSettingsDTO _self;
  final $Res Function(ChatSettingsDTO) _then;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hideDeletedMessages = null,
  }) {
    return _then(_self.copyWith(
      hideDeletedMessages: null == hideDeletedMessages
          ? _self.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChatSettingsDTO].
extension ChatSettingsDTOPatterns on ChatSettingsDTO {
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
    TResult Function(_ChatSettingsDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO() when $default != null:
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
    TResult Function(_ChatSettingsDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO():
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
    TResult? Function(_ChatSettingsDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO() when $default != null:
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
    TResult Function(bool hideDeletedMessages)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO() when $default != null:
        return $default(_that.hideDeletedMessages);
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
    TResult Function(bool hideDeletedMessages) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO():
        return $default(_that.hideDeletedMessages);
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
    TResult? Function(bool hideDeletedMessages)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatSettingsDTO() when $default != null:
        return $default(_that.hideDeletedMessages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChatSettingsDTO extends ChatSettingsDTO {
  _ChatSettingsDTO({this.hideDeletedMessages = true}) : super._();
  factory _ChatSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatSettingsDTOFromJson(json);

  @override
  @JsonKey()
  final bool hideDeletedMessages;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatSettingsDTOCopyWith<_ChatSettingsDTO> get copyWith =>
      __$ChatSettingsDTOCopyWithImpl<_ChatSettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatSettingsDTO &&
            (identical(other.hideDeletedMessages, hideDeletedMessages) ||
                other.hideDeletedMessages == hideDeletedMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hideDeletedMessages);

  @override
  String toString() {
    return 'ChatSettingsDTO(hideDeletedMessages: $hideDeletedMessages)';
  }
}

/// @nodoc
abstract mixin class _$ChatSettingsDTOCopyWith<$Res>
    implements $ChatSettingsDTOCopyWith<$Res> {
  factory _$ChatSettingsDTOCopyWith(
          _ChatSettingsDTO value, $Res Function(_ChatSettingsDTO) _then) =
      __$ChatSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call({bool hideDeletedMessages});
}

/// @nodoc
class __$ChatSettingsDTOCopyWithImpl<$Res>
    implements _$ChatSettingsDTOCopyWith<$Res> {
  __$ChatSettingsDTOCopyWithImpl(this._self, this._then);

  final _ChatSettingsDTO _self;
  final $Res Function(_ChatSettingsDTO) _then;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hideDeletedMessages = null,
  }) {
    return _then(_ChatSettingsDTO(
      hideDeletedMessages: null == hideDeletedMessages
          ? _self.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ChatGroupDTO {
  String get id;
  List<ChannelDTO> get channels;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatGroupDTOCopyWith<ChatGroupDTO> get copyWith =>
      _$ChatGroupDTOCopyWithImpl<ChatGroupDTO>(
          this as ChatGroupDTO, _$identity);

  /// Serializes this ChatGroupDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatGroupDTO &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.channels, channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(channels));

  @override
  String toString() {
    return 'ChatGroupDTO(id: $id, channels: $channels)';
  }
}

/// @nodoc
abstract mixin class $ChatGroupDTOCopyWith<$Res> {
  factory $ChatGroupDTOCopyWith(
          ChatGroupDTO value, $Res Function(ChatGroupDTO) _then) =
      _$ChatGroupDTOCopyWithImpl;
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class _$ChatGroupDTOCopyWithImpl<$Res> implements $ChatGroupDTOCopyWith<$Res> {
  _$ChatGroupDTOCopyWithImpl(this._self, this._then);

  final ChatGroupDTO _self;
  final $Res Function(ChatGroupDTO) _then;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChatGroupDTO].
extension ChatGroupDTOPatterns on ChatGroupDTO {
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
    TResult Function(_ChatGroupDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO() when $default != null:
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
    TResult Function(_ChatGroupDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO():
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
    TResult? Function(_ChatGroupDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO() when $default != null:
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
    TResult Function(String id, List<ChannelDTO> channels)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO() when $default != null:
        return $default(_that.id, _that.channels);
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
    TResult Function(String id, List<ChannelDTO> channels) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO():
        return $default(_that.id, _that.channels);
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
    TResult? Function(String id, List<ChannelDTO> channels)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupDTO() when $default != null:
        return $default(_that.id, _that.channels);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChatGroupDTO implements ChatGroupDTO {
  const _ChatGroupDTO(
      {required this.id, required final List<ChannelDTO> channels})
      : _channels = channels;
  factory _ChatGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupDTOFromJson(json);

  @override
  final String id;
  final List<ChannelDTO> _channels;
  @override
  List<ChannelDTO> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatGroupDTOCopyWith<_ChatGroupDTO> get copyWith =>
      __$ChatGroupDTOCopyWithImpl<_ChatGroupDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatGroupDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatGroupDTO &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._channels, _channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_channels));

  @override
  String toString() {
    return 'ChatGroupDTO(id: $id, channels: $channels)';
  }
}

/// @nodoc
abstract mixin class _$ChatGroupDTOCopyWith<$Res>
    implements $ChatGroupDTOCopyWith<$Res> {
  factory _$ChatGroupDTOCopyWith(
          _ChatGroupDTO value, $Res Function(_ChatGroupDTO) _then) =
      __$ChatGroupDTOCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class __$ChatGroupDTOCopyWithImpl<$Res>
    implements _$ChatGroupDTOCopyWith<$Res> {
  __$ChatGroupDTOCopyWithImpl(this._self, this._then);

  final _ChatGroupDTO _self;
  final $Res Function(_ChatGroupDTO) _then;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_ChatGroupDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// @nodoc
mixin _$ChannelDTO {
  Platform get platform;
  String get channel;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChannelDTOCopyWith<ChannelDTO> get copyWith =>
      _$ChannelDTOCopyWithImpl<ChannelDTO>(this as ChannelDTO, _$identity);

  /// Serializes this ChannelDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChannelDTO &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, channel);

  @override
  String toString() {
    return 'ChannelDTO(platform: $platform, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class $ChannelDTOCopyWith<$Res> {
  factory $ChannelDTOCopyWith(
          ChannelDTO value, $Res Function(ChannelDTO) _then) =
      _$ChannelDTOCopyWithImpl;
  @useResult
  $Res call({Platform platform, String channel});
}

/// @nodoc
class _$ChannelDTOCopyWithImpl<$Res> implements $ChannelDTOCopyWith<$Res> {
  _$ChannelDTOCopyWithImpl(this._self, this._then);

  final ChannelDTO _self;
  final $Res Function(ChannelDTO) _then;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? channel = null,
  }) {
    return _then(_self.copyWith(
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChannelDTO].
extension ChannelDTOPatterns on ChannelDTO {
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
    TResult Function(_ChannelDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO() when $default != null:
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
    TResult Function(_ChannelDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO():
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
    TResult? Function(_ChannelDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO() when $default != null:
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
    TResult Function(Platform platform, String channel)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO() when $default != null:
        return $default(_that.platform, _that.channel);
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
    TResult Function(Platform platform, String channel) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO():
        return $default(_that.platform, _that.channel);
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
    TResult? Function(Platform platform, String channel)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelDTO() when $default != null:
        return $default(_that.platform, _that.channel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelDTO implements ChannelDTO {
  const _ChannelDTO({required this.platform, required this.channel});
  factory _ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);

  @override
  final Platform platform;
  @override
  final String channel;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChannelDTOCopyWith<_ChannelDTO> get copyWith =>
      __$ChannelDTOCopyWithImpl<_ChannelDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChannelDTO &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, channel);

  @override
  String toString() {
    return 'ChannelDTO(platform: $platform, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class _$ChannelDTOCopyWith<$Res>
    implements $ChannelDTOCopyWith<$Res> {
  factory _$ChannelDTOCopyWith(
          _ChannelDTO value, $Res Function(_ChannelDTO) _then) =
      __$ChannelDTOCopyWithImpl;
  @override
  @useResult
  $Res call({Platform platform, String channel});
}

/// @nodoc
class __$ChannelDTOCopyWithImpl<$Res> implements _$ChannelDTOCopyWith<$Res> {
  __$ChannelDTOCopyWithImpl(this._self, this._then);

  final _ChannelDTO _self;
  final $Res Function(_ChannelDTO) _then;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? platform = null,
    Object? channel = null,
  }) {
    return _then(_ChannelDTO(
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
