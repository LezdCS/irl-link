// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsDTO {
//CHAT SETTINGS
  ChatEventsSettingsDTO get chatEventsSettings;
  ChatSettingsDTO get chatSettings; //GENERAL SETTINGS
  GeneralSettingsDTO get generalSettings;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsDTOCopyWith<SettingsDTO> get copyWith =>
      _$SettingsDTOCopyWithImpl<SettingsDTO>(this as SettingsDTO, _$identity);

  /// Serializes this SettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsDTO &&
            (identical(other.chatEventsSettings, chatEventsSettings) ||
                other.chatEventsSettings == chatEventsSettings) &&
            (identical(other.chatSettings, chatSettings) ||
                other.chatSettings == chatSettings) &&
            (identical(other.generalSettings, generalSettings) ||
                other.generalSettings == generalSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chatEventsSettings, chatSettings, generalSettings);

  @override
  String toString() {
    return 'SettingsDTO(chatEventsSettings: $chatEventsSettings, chatSettings: $chatSettings, generalSettings: $generalSettings)';
  }
}

/// @nodoc
abstract mixin class $SettingsDTOCopyWith<$Res> {
  factory $SettingsDTOCopyWith(
          SettingsDTO value, $Res Function(SettingsDTO) _then) =
      _$SettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings});

  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  $ChatSettingsDTOCopyWith<$Res> get chatSettings;
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
}

/// @nodoc
class _$SettingsDTOCopyWithImpl<$Res> implements $SettingsDTOCopyWith<$Res> {
  _$SettingsDTOCopyWithImpl(this._self, this._then);

  final SettingsDTO _self;
  final $Res Function(SettingsDTO) _then;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
  }) {
    return _then(_self.copyWith(
      chatEventsSettings: null == chatEventsSettings
          ? _self.chatEventsSettings
          : chatEventsSettings // ignore: cast_nullable_to_non_nullable
              as ChatEventsSettingsDTO,
      chatSettings: null == chatSettings
          ? _self.chatSettings
          : chatSettings // ignore: cast_nullable_to_non_nullable
              as ChatSettingsDTO,
      generalSettings: null == generalSettings
          ? _self.generalSettings
          : generalSettings // ignore: cast_nullable_to_non_nullable
              as GeneralSettingsDTO,
    ));
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings {
    return $ChatEventsSettingsDTOCopyWith<$Res>(_self.chatEventsSettings,
        (value) {
      return _then(_self.copyWith(chatEventsSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatSettingsDTOCopyWith<$Res> get chatSettings {
    return $ChatSettingsDTOCopyWith<$Res>(_self.chatSettings, (value) {
      return _then(_self.copyWith(chatSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings {
    return $GeneralSettingsDTOCopyWith<$Res>(_self.generalSettings, (value) {
      return _then(_self.copyWith(generalSettings: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SettingsDTO].
extension SettingsDTOPatterns on SettingsDTO {
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
    TResult Function(_SettingsDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO() when $default != null:
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
    TResult Function(_SettingsDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO():
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
    TResult? Function(_SettingsDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO() when $default != null:
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
    TResult Function(ChatEventsSettingsDTO chatEventsSettings,
            ChatSettingsDTO chatSettings, GeneralSettingsDTO generalSettings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO() when $default != null:
        return $default(_that.chatEventsSettings, _that.chatSettings,
            _that.generalSettings);
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
    TResult Function(ChatEventsSettingsDTO chatEventsSettings,
            ChatSettingsDTO chatSettings, GeneralSettingsDTO generalSettings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO():
        return $default(_that.chatEventsSettings, _that.chatSettings,
            _that.generalSettings);
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
    TResult? Function(ChatEventsSettingsDTO chatEventsSettings,
            ChatSettingsDTO chatSettings, GeneralSettingsDTO generalSettings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsDTO() when $default != null:
        return $default(_that.chatEventsSettings, _that.chatSettings,
            _that.generalSettings);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettingsDTO implements SettingsDTO {
  const _SettingsDTO(
      {required this.chatEventsSettings,
      required this.chatSettings,
      required this.generalSettings});
  factory _SettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsDTOFromJson(json);

//CHAT SETTINGS
  @override
  final ChatEventsSettingsDTO chatEventsSettings;
  @override
  final ChatSettingsDTO chatSettings;
//GENERAL SETTINGS
  @override
  final GeneralSettingsDTO generalSettings;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsDTOCopyWith<_SettingsDTO> get copyWith =>
      __$SettingsDTOCopyWithImpl<_SettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsDTO &&
            (identical(other.chatEventsSettings, chatEventsSettings) ||
                other.chatEventsSettings == chatEventsSettings) &&
            (identical(other.chatSettings, chatSettings) ||
                other.chatSettings == chatSettings) &&
            (identical(other.generalSettings, generalSettings) ||
                other.generalSettings == generalSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chatEventsSettings, chatSettings, generalSettings);

  @override
  String toString() {
    return 'SettingsDTO(chatEventsSettings: $chatEventsSettings, chatSettings: $chatSettings, generalSettings: $generalSettings)';
  }
}

/// @nodoc
abstract mixin class _$SettingsDTOCopyWith<$Res>
    implements $SettingsDTOCopyWith<$Res> {
  factory _$SettingsDTOCopyWith(
          _SettingsDTO value, $Res Function(_SettingsDTO) _then) =
      __$SettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings});

  @override
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  @override
  $ChatSettingsDTOCopyWith<$Res> get chatSettings;
  @override
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
}

/// @nodoc
class __$SettingsDTOCopyWithImpl<$Res> implements _$SettingsDTOCopyWith<$Res> {
  __$SettingsDTOCopyWithImpl(this._self, this._then);

  final _SettingsDTO _self;
  final $Res Function(_SettingsDTO) _then;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
  }) {
    return _then(_SettingsDTO(
      chatEventsSettings: null == chatEventsSettings
          ? _self.chatEventsSettings
          : chatEventsSettings // ignore: cast_nullable_to_non_nullable
              as ChatEventsSettingsDTO,
      chatSettings: null == chatSettings
          ? _self.chatSettings
          : chatSettings // ignore: cast_nullable_to_non_nullable
              as ChatSettingsDTO,
      generalSettings: null == generalSettings
          ? _self.generalSettings
          : generalSettings // ignore: cast_nullable_to_non_nullable
              as GeneralSettingsDTO,
    ));
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings {
    return $ChatEventsSettingsDTOCopyWith<$Res>(_self.chatEventsSettings,
        (value) {
      return _then(_self.copyWith(chatEventsSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatSettingsDTOCopyWith<$Res> get chatSettings {
    return $ChatSettingsDTOCopyWith<$Res>(_self.chatSettings, (value) {
      return _then(_self.copyWith(chatSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings {
    return $GeneralSettingsDTOCopyWith<$Res>(_self.generalSettings, (value) {
      return _then(_self.copyWith(generalSettings: value));
    });
  }
}

// dart format on
