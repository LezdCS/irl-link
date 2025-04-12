// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tts_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TtsSettingsDTO {
  bool get ttsEnabled;
  String get language;
  List get prefixsToIgnore;
  List get prefixsToUseTtsOnly;
  double get volume;
  double get pitch;
  double get rate;
  Map<String, String> get voice;
  List get ttsUsersToIgnore;
  bool get ttsMuteViewerName;
  bool get ttsOnlyVip;
  bool get ttsOnlyMod;
  bool get ttsOnlySubscriber;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TtsSettingsDTOCopyWith<TtsSettingsDTO> get copyWith =>
      _$TtsSettingsDTOCopyWithImpl<TtsSettingsDTO>(
          this as TtsSettingsDTO, _$identity);

  /// Serializes this TtsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TtsSettingsDTO &&
            (identical(other.ttsEnabled, ttsEnabled) ||
                other.ttsEnabled == ttsEnabled) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality()
                .equals(other.prefixsToIgnore, prefixsToIgnore) &&
            const DeepCollectionEquality()
                .equals(other.prefixsToUseTtsOnly, prefixsToUseTtsOnly) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            const DeepCollectionEquality().equals(other.voice, voice) &&
            const DeepCollectionEquality()
                .equals(other.ttsUsersToIgnore, ttsUsersToIgnore) &&
            (identical(other.ttsMuteViewerName, ttsMuteViewerName) ||
                other.ttsMuteViewerName == ttsMuteViewerName) &&
            (identical(other.ttsOnlyVip, ttsOnlyVip) ||
                other.ttsOnlyVip == ttsOnlyVip) &&
            (identical(other.ttsOnlyMod, ttsOnlyMod) ||
                other.ttsOnlyMod == ttsOnlyMod) &&
            (identical(other.ttsOnlySubscriber, ttsOnlySubscriber) ||
                other.ttsOnlySubscriber == ttsOnlySubscriber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ttsEnabled,
      language,
      const DeepCollectionEquality().hash(prefixsToIgnore),
      const DeepCollectionEquality().hash(prefixsToUseTtsOnly),
      volume,
      pitch,
      rate,
      const DeepCollectionEquality().hash(voice),
      const DeepCollectionEquality().hash(ttsUsersToIgnore),
      ttsMuteViewerName,
      ttsOnlyVip,
      ttsOnlyMod,
      ttsOnlySubscriber);

  @override
  String toString() {
    return 'TtsSettingsDTO(ttsEnabled: $ttsEnabled, language: $language, prefixsToIgnore: $prefixsToIgnore, prefixsToUseTtsOnly: $prefixsToUseTtsOnly, volume: $volume, pitch: $pitch, rate: $rate, voice: $voice, ttsUsersToIgnore: $ttsUsersToIgnore, ttsMuteViewerName: $ttsMuteViewerName, ttsOnlyVip: $ttsOnlyVip, ttsOnlyMod: $ttsOnlyMod, ttsOnlySubscriber: $ttsOnlySubscriber)';
  }
}

/// @nodoc
abstract mixin class $TtsSettingsDTOCopyWith<$Res> {
  factory $TtsSettingsDTOCopyWith(
          TtsSettingsDTO value, $Res Function(TtsSettingsDTO) _then) =
      _$TtsSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {bool ttsEnabled,
      String language,
      List prefixsToIgnore,
      List prefixsToUseTtsOnly,
      double volume,
      double pitch,
      double rate,
      Map<String, String> voice,
      List ttsUsersToIgnore,
      bool ttsMuteViewerName,
      bool ttsOnlyVip,
      bool ttsOnlyMod,
      bool ttsOnlySubscriber});
}

/// @nodoc
class _$TtsSettingsDTOCopyWithImpl<$Res>
    implements $TtsSettingsDTOCopyWith<$Res> {
  _$TtsSettingsDTOCopyWithImpl(this._self, this._then);

  final TtsSettingsDTO _self;
  final $Res Function(TtsSettingsDTO) _then;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttsEnabled = null,
    Object? language = null,
    Object? prefixsToIgnore = null,
    Object? prefixsToUseTtsOnly = null,
    Object? volume = null,
    Object? pitch = null,
    Object? rate = null,
    Object? voice = null,
    Object? ttsUsersToIgnore = null,
    Object? ttsMuteViewerName = null,
    Object? ttsOnlyVip = null,
    Object? ttsOnlyMod = null,
    Object? ttsOnlySubscriber = null,
  }) {
    return _then(_self.copyWith(
      ttsEnabled: null == ttsEnabled
          ? _self.ttsEnabled
          : ttsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      prefixsToIgnore: null == prefixsToIgnore
          ? _self.prefixsToIgnore
          : prefixsToIgnore // ignore: cast_nullable_to_non_nullable
              as List,
      prefixsToUseTtsOnly: null == prefixsToUseTtsOnly
          ? _self.prefixsToUseTtsOnly
          : prefixsToUseTtsOnly // ignore: cast_nullable_to_non_nullable
              as List,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      voice: null == voice
          ? _self.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      ttsUsersToIgnore: null == ttsUsersToIgnore
          ? _self.ttsUsersToIgnore
          : ttsUsersToIgnore // ignore: cast_nullable_to_non_nullable
              as List,
      ttsMuteViewerName: null == ttsMuteViewerName
          ? _self.ttsMuteViewerName
          : ttsMuteViewerName // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyVip: null == ttsOnlyVip
          ? _self.ttsOnlyVip
          : ttsOnlyVip // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyMod: null == ttsOnlyMod
          ? _self.ttsOnlyMod
          : ttsOnlyMod // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlySubscriber: null == ttsOnlySubscriber
          ? _self.ttsOnlySubscriber
          : ttsOnlySubscriber // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TtsSettingsDTO extends TtsSettingsDTO {
  _TtsSettingsDTO(
      {this.ttsEnabled = false,
      this.language = "en-US",
      final List prefixsToIgnore = const [],
      final List prefixsToUseTtsOnly = const [],
      this.volume = 1,
      this.pitch = 1,
      this.rate = 0.5,
      final Map<String, String> voice = const {
        "name": "en-us-x-sfg-local",
        "locale": "en-US"
      },
      final List ttsUsersToIgnore = const [],
      this.ttsMuteViewerName = false,
      this.ttsOnlyVip = false,
      this.ttsOnlyMod = false,
      this.ttsOnlySubscriber = false})
      : _prefixsToIgnore = prefixsToIgnore,
        _prefixsToUseTtsOnly = prefixsToUseTtsOnly,
        _voice = voice,
        _ttsUsersToIgnore = ttsUsersToIgnore,
        super._();
  factory _TtsSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$TtsSettingsDTOFromJson(json);

  @override
  @JsonKey()
  final bool ttsEnabled;
  @override
  @JsonKey()
  final String language;
  final List _prefixsToIgnore;
  @override
  @JsonKey()
  List get prefixsToIgnore {
    if (_prefixsToIgnore is EqualUnmodifiableListView) return _prefixsToIgnore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefixsToIgnore);
  }

  final List _prefixsToUseTtsOnly;
  @override
  @JsonKey()
  List get prefixsToUseTtsOnly {
    if (_prefixsToUseTtsOnly is EqualUnmodifiableListView)
      return _prefixsToUseTtsOnly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefixsToUseTtsOnly);
  }

  @override
  @JsonKey()
  final double volume;
  @override
  @JsonKey()
  final double pitch;
  @override
  @JsonKey()
  final double rate;
  final Map<String, String> _voice;
  @override
  @JsonKey()
  Map<String, String> get voice {
    if (_voice is EqualUnmodifiableMapView) return _voice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_voice);
  }

  final List _ttsUsersToIgnore;
  @override
  @JsonKey()
  List get ttsUsersToIgnore {
    if (_ttsUsersToIgnore is EqualUnmodifiableListView)
      return _ttsUsersToIgnore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ttsUsersToIgnore);
  }

  @override
  @JsonKey()
  final bool ttsMuteViewerName;
  @override
  @JsonKey()
  final bool ttsOnlyVip;
  @override
  @JsonKey()
  final bool ttsOnlyMod;
  @override
  @JsonKey()
  final bool ttsOnlySubscriber;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TtsSettingsDTOCopyWith<_TtsSettingsDTO> get copyWith =>
      __$TtsSettingsDTOCopyWithImpl<_TtsSettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TtsSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TtsSettingsDTO &&
            (identical(other.ttsEnabled, ttsEnabled) ||
                other.ttsEnabled == ttsEnabled) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality()
                .equals(other._prefixsToIgnore, _prefixsToIgnore) &&
            const DeepCollectionEquality()
                .equals(other._prefixsToUseTtsOnly, _prefixsToUseTtsOnly) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            const DeepCollectionEquality().equals(other._voice, _voice) &&
            const DeepCollectionEquality()
                .equals(other._ttsUsersToIgnore, _ttsUsersToIgnore) &&
            (identical(other.ttsMuteViewerName, ttsMuteViewerName) ||
                other.ttsMuteViewerName == ttsMuteViewerName) &&
            (identical(other.ttsOnlyVip, ttsOnlyVip) ||
                other.ttsOnlyVip == ttsOnlyVip) &&
            (identical(other.ttsOnlyMod, ttsOnlyMod) ||
                other.ttsOnlyMod == ttsOnlyMod) &&
            (identical(other.ttsOnlySubscriber, ttsOnlySubscriber) ||
                other.ttsOnlySubscriber == ttsOnlySubscriber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ttsEnabled,
      language,
      const DeepCollectionEquality().hash(_prefixsToIgnore),
      const DeepCollectionEquality().hash(_prefixsToUseTtsOnly),
      volume,
      pitch,
      rate,
      const DeepCollectionEquality().hash(_voice),
      const DeepCollectionEquality().hash(_ttsUsersToIgnore),
      ttsMuteViewerName,
      ttsOnlyVip,
      ttsOnlyMod,
      ttsOnlySubscriber);

  @override
  String toString() {
    return 'TtsSettingsDTO(ttsEnabled: $ttsEnabled, language: $language, prefixsToIgnore: $prefixsToIgnore, prefixsToUseTtsOnly: $prefixsToUseTtsOnly, volume: $volume, pitch: $pitch, rate: $rate, voice: $voice, ttsUsersToIgnore: $ttsUsersToIgnore, ttsMuteViewerName: $ttsMuteViewerName, ttsOnlyVip: $ttsOnlyVip, ttsOnlyMod: $ttsOnlyMod, ttsOnlySubscriber: $ttsOnlySubscriber)';
  }
}

/// @nodoc
abstract mixin class _$TtsSettingsDTOCopyWith<$Res>
    implements $TtsSettingsDTOCopyWith<$Res> {
  factory _$TtsSettingsDTOCopyWith(
          _TtsSettingsDTO value, $Res Function(_TtsSettingsDTO) _then) =
      __$TtsSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool ttsEnabled,
      String language,
      List prefixsToIgnore,
      List prefixsToUseTtsOnly,
      double volume,
      double pitch,
      double rate,
      Map<String, String> voice,
      List ttsUsersToIgnore,
      bool ttsMuteViewerName,
      bool ttsOnlyVip,
      bool ttsOnlyMod,
      bool ttsOnlySubscriber});
}

/// @nodoc
class __$TtsSettingsDTOCopyWithImpl<$Res>
    implements _$TtsSettingsDTOCopyWith<$Res> {
  __$TtsSettingsDTOCopyWithImpl(this._self, this._then);

  final _TtsSettingsDTO _self;
  final $Res Function(_TtsSettingsDTO) _then;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ttsEnabled = null,
    Object? language = null,
    Object? prefixsToIgnore = null,
    Object? prefixsToUseTtsOnly = null,
    Object? volume = null,
    Object? pitch = null,
    Object? rate = null,
    Object? voice = null,
    Object? ttsUsersToIgnore = null,
    Object? ttsMuteViewerName = null,
    Object? ttsOnlyVip = null,
    Object? ttsOnlyMod = null,
    Object? ttsOnlySubscriber = null,
  }) {
    return _then(_TtsSettingsDTO(
      ttsEnabled: null == ttsEnabled
          ? _self.ttsEnabled
          : ttsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      prefixsToIgnore: null == prefixsToIgnore
          ? _self._prefixsToIgnore
          : prefixsToIgnore // ignore: cast_nullable_to_non_nullable
              as List,
      prefixsToUseTtsOnly: null == prefixsToUseTtsOnly
          ? _self._prefixsToUseTtsOnly
          : prefixsToUseTtsOnly // ignore: cast_nullable_to_non_nullable
              as List,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      voice: null == voice
          ? _self._voice
          : voice // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      ttsUsersToIgnore: null == ttsUsersToIgnore
          ? _self._ttsUsersToIgnore
          : ttsUsersToIgnore // ignore: cast_nullable_to_non_nullable
              as List,
      ttsMuteViewerName: null == ttsMuteViewerName
          ? _self.ttsMuteViewerName
          : ttsMuteViewerName // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyVip: null == ttsOnlyVip
          ? _self.ttsOnlyVip
          : ttsOnlyVip // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyMod: null == ttsOnlyMod
          ? _self.ttsOnlyMod
          : ttsOnlyMod // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlySubscriber: null == ttsOnlySubscriber
          ? _self.ttsOnlySubscriber
          : ttsOnlySubscriber // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
