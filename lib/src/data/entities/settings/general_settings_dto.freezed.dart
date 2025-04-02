// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  bool get isDarkMode;
  bool get keepSpeakerOn;
  bool get displayViewerCount;
  Map<dynamic, dynamic> get appLanguage;
  List<double> get splitViewWeights;

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
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.keepSpeakerOn, keepSpeakerOn) ||
                other.keepSpeakerOn == keepSpeakerOn) &&
            (identical(other.displayViewerCount, displayViewerCount) ||
                other.displayViewerCount == displayViewerCount) &&
            const DeepCollectionEquality()
                .equals(other.appLanguage, appLanguage) &&
            const DeepCollectionEquality()
                .equals(other.splitViewWeights, splitViewWeights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      const DeepCollectionEquality().hash(appLanguage),
      const DeepCollectionEquality().hash(splitViewWeights));

  @override
  String toString() {
    return 'GeneralSettingsDTO(isDarkMode: $isDarkMode, keepSpeakerOn: $keepSpeakerOn, displayViewerCount: $displayViewerCount, appLanguage: $appLanguage, splitViewWeights: $splitViewWeights)';
  }
}

/// @nodoc
abstract mixin class $GeneralSettingsDTOCopyWith<$Res> {
  factory $GeneralSettingsDTOCopyWith(
          GeneralSettingsDTO value, $Res Function(GeneralSettingsDTO) _then) =
      _$GeneralSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {bool isDarkMode,
      bool keepSpeakerOn,
      bool displayViewerCount,
      Map<dynamic, dynamic> appLanguage,
      List<double> splitViewWeights});
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
    Object? isDarkMode = null,
    Object? keepSpeakerOn = null,
    Object? displayViewerCount = null,
    Object? appLanguage = null,
    Object? splitViewWeights = null,
  }) {
    return _then(_self.copyWith(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GeneralSettingsDTO extends GeneralSettingsDTO {
  const _GeneralSettingsDTO(
      {this.isDarkMode = true,
      this.keepSpeakerOn = true,
      this.displayViewerCount = true,
      final Map<dynamic, dynamic> appLanguage = const {
        "languageCode": "en",
        "countryCode": "US"
      },
      final List<double> splitViewWeights = const [0.5, 0.5]})
      : _appLanguage = appLanguage,
        _splitViewWeights = splitViewWeights,
        super._();
  factory _GeneralSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingsDTOFromJson(json);

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
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.keepSpeakerOn, keepSpeakerOn) ||
                other.keepSpeakerOn == keepSpeakerOn) &&
            (identical(other.displayViewerCount, displayViewerCount) ||
                other.displayViewerCount == displayViewerCount) &&
            const DeepCollectionEquality()
                .equals(other._appLanguage, _appLanguage) &&
            const DeepCollectionEquality()
                .equals(other._splitViewWeights, _splitViewWeights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isDarkMode,
      keepSpeakerOn,
      displayViewerCount,
      const DeepCollectionEquality().hash(_appLanguage),
      const DeepCollectionEquality().hash(_splitViewWeights));

  @override
  String toString() {
    return 'GeneralSettingsDTO(isDarkMode: $isDarkMode, keepSpeakerOn: $keepSpeakerOn, displayViewerCount: $displayViewerCount, appLanguage: $appLanguage, splitViewWeights: $splitViewWeights)';
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
      {bool isDarkMode,
      bool keepSpeakerOn,
      bool displayViewerCount,
      Map<dynamic, dynamic> appLanguage,
      List<double> splitViewWeights});
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
    Object? isDarkMode = null,
    Object? keepSpeakerOn = null,
    Object? displayViewerCount = null,
    Object? appLanguage = null,
    Object? splitViewWeights = null,
  }) {
    return _then(_GeneralSettingsDTO(
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
    ));
  }
}

// dart format on
