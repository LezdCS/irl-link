// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tts_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TtsSettingsDTO _$TtsSettingsDTOFromJson(Map<String, dynamic> json) {
  return _TtsSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$TtsSettingsDTO {
  bool get ttsEnabled => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  List<dynamic> get prefixsToIgnore => throw _privateConstructorUsedError;
  List<dynamic> get prefixsToUseTtsOnly => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  double get pitch => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  Map<String, String> get voice => throw _privateConstructorUsedError;
  List<dynamic> get ttsUsersToIgnore => throw _privateConstructorUsedError;
  bool get ttsMuteViewerName => throw _privateConstructorUsedError;
  bool get ttsOnlyVip => throw _privateConstructorUsedError;
  bool get ttsOnlyMod => throw _privateConstructorUsedError;
  bool get ttsOnlySubscriber => throw _privateConstructorUsedError;

  /// Serializes this TtsSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TtsSettingsDTOCopyWith<TtsSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TtsSettingsDTOCopyWith<$Res> {
  factory $TtsSettingsDTOCopyWith(
          TtsSettingsDTO value, $Res Function(TtsSettingsDTO) then) =
      _$TtsSettingsDTOCopyWithImpl<$Res, TtsSettingsDTO>;
  @useResult
  $Res call(
      {bool ttsEnabled,
      String language,
      List<dynamic> prefixsToIgnore,
      List<dynamic> prefixsToUseTtsOnly,
      double volume,
      double pitch,
      double rate,
      Map<String, String> voice,
      List<dynamic> ttsUsersToIgnore,
      bool ttsMuteViewerName,
      bool ttsOnlyVip,
      bool ttsOnlyMod,
      bool ttsOnlySubscriber});
}

/// @nodoc
class _$TtsSettingsDTOCopyWithImpl<$Res, $Val extends TtsSettingsDTO>
    implements $TtsSettingsDTOCopyWith<$Res> {
  _$TtsSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      ttsEnabled: null == ttsEnabled
          ? _value.ttsEnabled
          : ttsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      prefixsToIgnore: null == prefixsToIgnore
          ? _value.prefixsToIgnore
          : prefixsToIgnore // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      prefixsToUseTtsOnly: null == prefixsToUseTtsOnly
          ? _value.prefixsToUseTtsOnly
          : prefixsToUseTtsOnly // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      voice: null == voice
          ? _value.voice
          : voice // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      ttsUsersToIgnore: null == ttsUsersToIgnore
          ? _value.ttsUsersToIgnore
          : ttsUsersToIgnore // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      ttsMuteViewerName: null == ttsMuteViewerName
          ? _value.ttsMuteViewerName
          : ttsMuteViewerName // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyVip: null == ttsOnlyVip
          ? _value.ttsOnlyVip
          : ttsOnlyVip // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyMod: null == ttsOnlyMod
          ? _value.ttsOnlyMod
          : ttsOnlyMod // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlySubscriber: null == ttsOnlySubscriber
          ? _value.ttsOnlySubscriber
          : ttsOnlySubscriber // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TtsSettingsDTOImplCopyWith<$Res>
    implements $TtsSettingsDTOCopyWith<$Res> {
  factory _$$TtsSettingsDTOImplCopyWith(_$TtsSettingsDTOImpl value,
          $Res Function(_$TtsSettingsDTOImpl) then) =
      __$$TtsSettingsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool ttsEnabled,
      String language,
      List<dynamic> prefixsToIgnore,
      List<dynamic> prefixsToUseTtsOnly,
      double volume,
      double pitch,
      double rate,
      Map<String, String> voice,
      List<dynamic> ttsUsersToIgnore,
      bool ttsMuteViewerName,
      bool ttsOnlyVip,
      bool ttsOnlyMod,
      bool ttsOnlySubscriber});
}

/// @nodoc
class __$$TtsSettingsDTOImplCopyWithImpl<$Res>
    extends _$TtsSettingsDTOCopyWithImpl<$Res, _$TtsSettingsDTOImpl>
    implements _$$TtsSettingsDTOImplCopyWith<$Res> {
  __$$TtsSettingsDTOImplCopyWithImpl(
      _$TtsSettingsDTOImpl _value, $Res Function(_$TtsSettingsDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$TtsSettingsDTOImpl(
      ttsEnabled: null == ttsEnabled
          ? _value.ttsEnabled
          : ttsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      prefixsToIgnore: null == prefixsToIgnore
          ? _value._prefixsToIgnore
          : prefixsToIgnore // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      prefixsToUseTtsOnly: null == prefixsToUseTtsOnly
          ? _value._prefixsToUseTtsOnly
          : prefixsToUseTtsOnly // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      voice: null == voice
          ? _value._voice
          : voice // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      ttsUsersToIgnore: null == ttsUsersToIgnore
          ? _value._ttsUsersToIgnore
          : ttsUsersToIgnore // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      ttsMuteViewerName: null == ttsMuteViewerName
          ? _value.ttsMuteViewerName
          : ttsMuteViewerName // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyVip: null == ttsOnlyVip
          ? _value.ttsOnlyVip
          : ttsOnlyVip // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlyMod: null == ttsOnlyMod
          ? _value.ttsOnlyMod
          : ttsOnlyMod // ignore: cast_nullable_to_non_nullable
              as bool,
      ttsOnlySubscriber: null == ttsOnlySubscriber
          ? _value.ttsOnlySubscriber
          : ttsOnlySubscriber // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TtsSettingsDTOImpl implements _TtsSettingsDTO {
  const _$TtsSettingsDTOImpl(
      {this.ttsEnabled = false,
      this.language = "en-US",
      final List<dynamic> prefixsToIgnore = const [],
      final List<dynamic> prefixsToUseTtsOnly = const [],
      this.volume = 1,
      this.pitch = 1,
      this.rate = 0.5,
      final Map<String, String> voice = const {
        "name": "en-us-x-sfg-local",
        "locale": "en-US"
      },
      final List<dynamic> ttsUsersToIgnore = const [],
      this.ttsMuteViewerName = false,
      this.ttsOnlyVip = false,
      this.ttsOnlyMod = false,
      this.ttsOnlySubscriber = false})
      : _prefixsToIgnore = prefixsToIgnore,
        _prefixsToUseTtsOnly = prefixsToUseTtsOnly,
        _voice = voice,
        _ttsUsersToIgnore = ttsUsersToIgnore;

  factory _$TtsSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TtsSettingsDTOImplFromJson(json);

  @override
  @JsonKey()
  final bool ttsEnabled;
  @override
  @JsonKey()
  final String language;
  final List<dynamic> _prefixsToIgnore;
  @override
  @JsonKey()
  List<dynamic> get prefixsToIgnore {
    if (_prefixsToIgnore is EqualUnmodifiableListView) return _prefixsToIgnore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prefixsToIgnore);
  }

  final List<dynamic> _prefixsToUseTtsOnly;
  @override
  @JsonKey()
  List<dynamic> get prefixsToUseTtsOnly {
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

  final List<dynamic> _ttsUsersToIgnore;
  @override
  @JsonKey()
  List<dynamic> get ttsUsersToIgnore {
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

  @override
  String toString() {
    return 'TtsSettingsDTO(ttsEnabled: $ttsEnabled, language: $language, prefixsToIgnore: $prefixsToIgnore, prefixsToUseTtsOnly: $prefixsToUseTtsOnly, volume: $volume, pitch: $pitch, rate: $rate, voice: $voice, ttsUsersToIgnore: $ttsUsersToIgnore, ttsMuteViewerName: $ttsMuteViewerName, ttsOnlyVip: $ttsOnlyVip, ttsOnlyMod: $ttsOnlyMod, ttsOnlySubscriber: $ttsOnlySubscriber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TtsSettingsDTOImpl &&
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

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TtsSettingsDTOImplCopyWith<_$TtsSettingsDTOImpl> get copyWith =>
      __$$TtsSettingsDTOImplCopyWithImpl<_$TtsSettingsDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TtsSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _TtsSettingsDTO implements TtsSettingsDTO {
  const factory _TtsSettingsDTO(
      {final bool ttsEnabled,
      final String language,
      final List<dynamic> prefixsToIgnore,
      final List<dynamic> prefixsToUseTtsOnly,
      final double volume,
      final double pitch,
      final double rate,
      final Map<String, String> voice,
      final List<dynamic> ttsUsersToIgnore,
      final bool ttsMuteViewerName,
      final bool ttsOnlyVip,
      final bool ttsOnlyMod,
      final bool ttsOnlySubscriber}) = _$TtsSettingsDTOImpl;

  factory _TtsSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$TtsSettingsDTOImpl.fromJson;

  @override
  bool get ttsEnabled;
  @override
  String get language;
  @override
  List<dynamic> get prefixsToIgnore;
  @override
  List<dynamic> get prefixsToUseTtsOnly;
  @override
  double get volume;
  @override
  double get pitch;
  @override
  double get rate;
  @override
  Map<String, String> get voice;
  @override
  List<dynamic> get ttsUsersToIgnore;
  @override
  bool get ttsMuteViewerName;
  @override
  bool get ttsOnlyVip;
  @override
  bool get ttsOnlyMod;
  @override
  bool get ttsOnlySubscriber;

  /// Create a copy of TtsSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TtsSettingsDTOImplCopyWith<_$TtsSettingsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
