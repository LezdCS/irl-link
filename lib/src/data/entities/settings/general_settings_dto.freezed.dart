// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneralSettingsDTO {
  String get rtIrlPushKey;
  bool get allowChatEmotes;
  double get textSize;
  bool get displayTimestamp;
  bool get isDarkMode;
  bool get keepSpeakerOn;
  bool get displayViewerCount;
  Map<dynamic, dynamic> get appLanguage;
  List<double> get splitViewWeights;
  bool get rainModeActivated;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeneralSettingsDTOCopyWith<GeneralSettingsDTO> get copyWith =>
      _$GeneralSettingsDTOCopyWithImpl<GeneralSettingsDTO>(
          this as GeneralSettingsDTO, _$identity);

  /// Serializes this GeneralSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeneralSettingsDTO &&
            (identical(other.rtIrlPushKey, rtIrlPushKey) ||
                other.rtIrlPushKey == rtIrlPushKey) &&
            (identical(other.allowChatEmotes, allowChatEmotes) ||
                other.allowChatEmotes == allowChatEmotes) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.displayTimestamp, displayTimestamp) ||
                other.displayTimestamp == displayTimestamp) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.keepSpeakerOn, keepSpeakerOn) ||
                other.keepSpeakerOn == keepSpeakerOn) &&
            (identical(other.displayViewerCount, displayViewerCount) ||
                other.displayViewerCount == displayViewerCount) &&
            const DeepCollectionEquality()
                .equals(other.appLanguage, appLanguage) &&
            const DeepCollectionEquality()
                .equals(other.splitViewWeights, splitViewWeights) &&
            (identical(other.rainModeActivated, rainModeActivated) ||
                other.rainModeActivated == rainModeActivated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      rtIrlPushKey,
      allowChatEmotes,
      textSize,
      displayTimestamp,
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      const DeepCollectionEquality().hash(appLanguage),
      const DeepCollectionEquality().hash(splitViewWeights),
      rainModeActivated);

  @override
  String toString() {
    return 'GeneralSettingsDTO(rtIrlPushKey: $rtIrlPushKey, allowChatEmotes: $allowChatEmotes, textSize: $textSize, displayTimestamp: $displayTimestamp, isDarkMode: $isDarkMode, keepSpeakerOn: $keepSpeakerOn, displayViewerCount: $displayViewerCount, appLanguage: $appLanguage, splitViewWeights: $splitViewWeights, rainModeActivated: $rainModeActivated)';
  }
}

/// @nodoc
abstract mixin class $GeneralSettingsDTOCopyWith<$Res> {
  factory $GeneralSettingsDTOCopyWith(
          GeneralSettingsDTO value, $Res Function(GeneralSettingsDTO) _then) =
      _$GeneralSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {String rtIrlPushKey,
      bool allowChatEmotes,
      double textSize,
      bool displayTimestamp,
      bool isDarkMode,
      bool keepSpeakerOn,
      bool displayViewerCount,
      Map<dynamic, dynamic> appLanguage,
      List<double> splitViewWeights,
      bool rainModeActivated});
}

/// @nodoc
class _$GeneralSettingsDTOCopyWithImpl<$Res>
    implements $GeneralSettingsDTOCopyWith<$Res> {
  _$GeneralSettingsDTOCopyWithImpl(this._self, this._then);

  final GeneralSettingsDTO _self;
  final $Res Function(GeneralSettingsDTO) _then;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rtIrlPushKey = null,
    Object? allowChatEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? isDarkMode = null,
    Object? keepSpeakerOn = null,
    Object? displayViewerCount = null,
    Object? appLanguage = null,
    Object? splitViewWeights = null,
    Object? rainModeActivated = null,
  }) {
    return _then(_self.copyWith(
      rtIrlPushKey: null == rtIrlPushKey
          ? _self.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      allowChatEmotes: null == allowChatEmotes
          ? _self.allowChatEmotes
          : allowChatEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _self.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _self.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _self.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      keepSpeakerOn: null == keepSpeakerOn
          ? _self.keepSpeakerOn
          : keepSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      displayViewerCount: null == displayViewerCount
          ? _self.displayViewerCount
          : displayViewerCount // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _self.appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      splitViewWeights: null == splitViewWeights
          ? _self.splitViewWeights
          : splitViewWeights // ignore: cast_nullable_to_non_nullable
              as List<double>,
      rainModeActivated: null == rainModeActivated
          ? _self.rainModeActivated
          : rainModeActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [GeneralSettingsDTO].
extension GeneralSettingsDTOPatterns on GeneralSettingsDTO {
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
    TResult Function(_GeneralSettingsDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO() when $default != null:
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
    TResult Function(_GeneralSettingsDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO():
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
    TResult? Function(_GeneralSettingsDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO() when $default != null:
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
            String rtIrlPushKey,
            bool allowChatEmotes,
            double textSize,
            bool displayTimestamp,
            bool isDarkMode,
            bool keepSpeakerOn,
            bool displayViewerCount,
            Map<dynamic, dynamic> appLanguage,
            List<double> splitViewWeights,
            bool rainModeActivated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO() when $default != null:
        return $default(
            _that.rtIrlPushKey,
            _that.allowChatEmotes,
            _that.textSize,
            _that.displayTimestamp,
            _that.isDarkMode,
            _that.keepSpeakerOn,
            _that.displayViewerCount,
            _that.appLanguage,
            _that.splitViewWeights,
            _that.rainModeActivated);
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
            String rtIrlPushKey,
            bool allowChatEmotes,
            double textSize,
            bool displayTimestamp,
            bool isDarkMode,
            bool keepSpeakerOn,
            bool displayViewerCount,
            Map<dynamic, dynamic> appLanguage,
            List<double> splitViewWeights,
            bool rainModeActivated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO():
        return $default(
            _that.rtIrlPushKey,
            _that.allowChatEmotes,
            _that.textSize,
            _that.displayTimestamp,
            _that.isDarkMode,
            _that.keepSpeakerOn,
            _that.displayViewerCount,
            _that.appLanguage,
            _that.splitViewWeights,
            _that.rainModeActivated);
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
            String rtIrlPushKey,
            bool allowChatEmotes,
            double textSize,
            bool displayTimestamp,
            bool isDarkMode,
            bool keepSpeakerOn,
            bool displayViewerCount,
            Map<dynamic, dynamic> appLanguage,
            List<double> splitViewWeights,
            bool rainModeActivated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralSettingsDTO() when $default != null:
        return $default(
            _that.rtIrlPushKey,
            _that.allowChatEmotes,
            _that.textSize,
            _that.displayTimestamp,
            _that.isDarkMode,
            _that.keepSpeakerOn,
            _that.displayViewerCount,
            _that.appLanguage,
            _that.splitViewWeights,
            _that.rainModeActivated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GeneralSettingsDTO extends GeneralSettingsDTO {
  const _GeneralSettingsDTO(
      {this.rtIrlPushKey = "",
      this.allowChatEmotes = true,
      this.textSize = 19,
      this.displayTimestamp = false,
      this.isDarkMode = true,
      this.keepSpeakerOn = true,
      this.displayViewerCount = true,
      final Map<dynamic, dynamic> appLanguage = const {
        "languageCode": "en",
        "countryCode": "US"
      },
      final List<double> splitViewWeights = const [0.5, 0.5],
      this.rainModeActivated = false})
      : _appLanguage = appLanguage,
        _splitViewWeights = splitViewWeights,
        super._();
  factory _GeneralSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingsDTOFromJson(json);

  @override
  @JsonKey()
  final String rtIrlPushKey;
  @override
  @JsonKey()
  final bool allowChatEmotes;
  @override
  @JsonKey()
  final double textSize;
  @override
  @JsonKey()
  final bool displayTimestamp;
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final bool keepSpeakerOn;
  @override
  @JsonKey()
  final bool displayViewerCount;
  final Map<dynamic, dynamic> _appLanguage;
  @override
  @JsonKey()
  Map<dynamic, dynamic> get appLanguage {
    if (_appLanguage is EqualUnmodifiableMapView) return _appLanguage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_appLanguage);
  }

  final List<double> _splitViewWeights;
  @override
  @JsonKey()
  List<double> get splitViewWeights {
    if (_splitViewWeights is EqualUnmodifiableListView)
      return _splitViewWeights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_splitViewWeights);
  }

  @override
  @JsonKey()
  final bool rainModeActivated;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeneralSettingsDTOCopyWith<_GeneralSettingsDTO> get copyWith =>
      __$GeneralSettingsDTOCopyWithImpl<_GeneralSettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeneralSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeneralSettingsDTO &&
            (identical(other.rtIrlPushKey, rtIrlPushKey) ||
                other.rtIrlPushKey == rtIrlPushKey) &&
            (identical(other.allowChatEmotes, allowChatEmotes) ||
                other.allowChatEmotes == allowChatEmotes) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.displayTimestamp, displayTimestamp) ||
                other.displayTimestamp == displayTimestamp) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.keepSpeakerOn, keepSpeakerOn) ||
                other.keepSpeakerOn == keepSpeakerOn) &&
            (identical(other.displayViewerCount, displayViewerCount) ||
                other.displayViewerCount == displayViewerCount) &&
            const DeepCollectionEquality()
                .equals(other._appLanguage, _appLanguage) &&
            const DeepCollectionEquality()
                .equals(other._splitViewWeights, _splitViewWeights) &&
            (identical(other.rainModeActivated, rainModeActivated) ||
                other.rainModeActivated == rainModeActivated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      rtIrlPushKey,
      allowChatEmotes,
      textSize,
      displayTimestamp,
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      const DeepCollectionEquality().hash(_appLanguage),
      const DeepCollectionEquality().hash(_splitViewWeights),
      rainModeActivated);

  @override
  String toString() {
    return 'GeneralSettingsDTO(rtIrlPushKey: $rtIrlPushKey, allowChatEmotes: $allowChatEmotes, textSize: $textSize, displayTimestamp: $displayTimestamp, isDarkMode: $isDarkMode, keepSpeakerOn: $keepSpeakerOn, displayViewerCount: $displayViewerCount, appLanguage: $appLanguage, splitViewWeights: $splitViewWeights, rainModeActivated: $rainModeActivated)';
  }
}

/// @nodoc
abstract mixin class _$GeneralSettingsDTOCopyWith<$Res>
    implements $GeneralSettingsDTOCopyWith<$Res> {
  factory _$GeneralSettingsDTOCopyWith(
          _GeneralSettingsDTO value, $Res Function(_GeneralSettingsDTO) _then) =
      __$GeneralSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String rtIrlPushKey,
      bool allowChatEmotes,
      double textSize,
      bool displayTimestamp,
      bool isDarkMode,
      bool keepSpeakerOn,
      bool displayViewerCount,
      Map<dynamic, dynamic> appLanguage,
      List<double> splitViewWeights,
      bool rainModeActivated});
}

/// @nodoc
class __$GeneralSettingsDTOCopyWithImpl<$Res>
    implements _$GeneralSettingsDTOCopyWith<$Res> {
  __$GeneralSettingsDTOCopyWithImpl(this._self, this._then);

  final _GeneralSettingsDTO _self;
  final $Res Function(_GeneralSettingsDTO) _then;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rtIrlPushKey = null,
    Object? allowChatEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? isDarkMode = null,
    Object? keepSpeakerOn = null,
    Object? displayViewerCount = null,
    Object? appLanguage = null,
    Object? splitViewWeights = null,
    Object? rainModeActivated = null,
  }) {
    return _then(_GeneralSettingsDTO(
      rtIrlPushKey: null == rtIrlPushKey
          ? _self.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      allowChatEmotes: null == allowChatEmotes
          ? _self.allowChatEmotes
          : allowChatEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _self.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _self.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _self.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      keepSpeakerOn: null == keepSpeakerOn
          ? _self.keepSpeakerOn
          : keepSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      displayViewerCount: null == displayViewerCount
          ? _self.displayViewerCount
          : displayViewerCount // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _self._appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      splitViewWeights: null == splitViewWeights
          ? _self._splitViewWeights
          : splitViewWeights // ignore: cast_nullable_to_non_nullable
              as List<double>,
      rainModeActivated: null == rainModeActivated
          ? _self.rainModeActivated
          : rainModeActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
