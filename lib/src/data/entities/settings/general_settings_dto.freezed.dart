// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeneralSettingsDTO _$GeneralSettingsDTOFromJson(Map<String, dynamic> json) {
  return _GeneralSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$GeneralSettingsDTO {
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get keepSpeakerOn => throw _privateConstructorUsedError;
  bool get displayViewerCount => throw _privateConstructorUsedError;
  Map<dynamic, dynamic> get appLanguage => throw _privateConstructorUsedError;
  List<double> get splitViewWeights => throw _privateConstructorUsedError;

  /// Serializes this GeneralSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneralSettingsDTOCopyWith<GeneralSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneralSettingsDTOCopyWith<$Res> {
  factory $GeneralSettingsDTOCopyWith(
          GeneralSettingsDTO value, $Res Function(GeneralSettingsDTO) then) =
      _$GeneralSettingsDTOCopyWithImpl<$Res, GeneralSettingsDTO>;
  @useResult
  $Res call(
      {bool isDarkMode,
      bool keepSpeakerOn,
      bool displayViewerCount,
      Map<dynamic, dynamic> appLanguage,
      List<double> splitViewWeights});
}

/// @nodoc
class _$GeneralSettingsDTOCopyWithImpl<$Res, $Val extends GeneralSettingsDTO>
    implements $GeneralSettingsDTOCopyWith<$Res> {
  _$GeneralSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      keepSpeakerOn: null == keepSpeakerOn
          ? _value.keepSpeakerOn
          : keepSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      displayViewerCount: null == displayViewerCount
          ? _value.displayViewerCount
          : displayViewerCount // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _value.appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      splitViewWeights: null == splitViewWeights
          ? _value.splitViewWeights
          : splitViewWeights // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneralSettingsDTOImplCopyWith<$Res>
    implements $GeneralSettingsDTOCopyWith<$Res> {
  factory _$$GeneralSettingsDTOImplCopyWith(_$GeneralSettingsDTOImpl value,
          $Res Function(_$GeneralSettingsDTOImpl) then) =
      __$$GeneralSettingsDTOImplCopyWithImpl<$Res>;
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
class __$$GeneralSettingsDTOImplCopyWithImpl<$Res>
    extends _$GeneralSettingsDTOCopyWithImpl<$Res, _$GeneralSettingsDTOImpl>
    implements _$$GeneralSettingsDTOImplCopyWith<$Res> {
  __$$GeneralSettingsDTOImplCopyWithImpl(_$GeneralSettingsDTOImpl _value,
      $Res Function(_$GeneralSettingsDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$GeneralSettingsDTOImpl(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      keepSpeakerOn: null == keepSpeakerOn
          ? _value.keepSpeakerOn
          : keepSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      displayViewerCount: null == displayViewerCount
          ? _value.displayViewerCount
          : displayViewerCount // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _value._appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      splitViewWeights: null == splitViewWeights
          ? _value._splitViewWeights
          : splitViewWeights // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneralSettingsDTOImpl extends _GeneralSettingsDTO {
  const _$GeneralSettingsDTOImpl(
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

  factory _$GeneralSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneralSettingsDTOImplFromJson(json);

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
  String toString() {
    return 'GeneralSettingsDTO(isDarkMode: $isDarkMode, keepSpeakerOn: $keepSpeakerOn, displayViewerCount: $displayViewerCount, appLanguage: $appLanguage, splitViewWeights: $splitViewWeights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralSettingsDTOImpl &&
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

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralSettingsDTOImplCopyWith<_$GeneralSettingsDTOImpl> get copyWith =>
      __$$GeneralSettingsDTOImplCopyWithImpl<_$GeneralSettingsDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneralSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _GeneralSettingsDTO extends GeneralSettingsDTO {
  const factory _GeneralSettingsDTO(
      {final bool isDarkMode,
      final bool keepSpeakerOn,
      final bool displayViewerCount,
      final Map<dynamic, dynamic> appLanguage,
      final List<double> splitViewWeights}) = _$GeneralSettingsDTOImpl;
  const _GeneralSettingsDTO._() : super._();

  factory _GeneralSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$GeneralSettingsDTOImpl.fromJson;

  @override
  bool get isDarkMode;
  @override
  bool get keepSpeakerOn;
  @override
  bool get displayViewerCount;
  @override
  Map<dynamic, dynamic> get appLanguage;
  @override
  List<double> get splitViewWeights;

  /// Create a copy of GeneralSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneralSettingsDTOImplCopyWith<_$GeneralSettingsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
