// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrowserTabSettingsDTO _$BrowserTabSettingsDTOFromJson(
    Map<String, dynamic> json) {
  return _BrowserTabSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$BrowserTabSettingsDTO {
  List<BrowserTabDTO> get tabs => throw _privateConstructorUsedError;

  /// Serializes this BrowserTabSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserTabSettingsDTOCopyWith<BrowserTabSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabSettingsDTOCopyWith<$Res> {
  factory $BrowserTabSettingsDTOCopyWith(BrowserTabSettingsDTO value,
          $Res Function(BrowserTabSettingsDTO) then) =
      _$BrowserTabSettingsDTOCopyWithImpl<$Res, BrowserTabSettingsDTO>;
  @useResult
  $Res call({List<BrowserTabDTO> tabs});
}

/// @nodoc
class _$BrowserTabSettingsDTOCopyWithImpl<$Res,
        $Val extends BrowserTabSettingsDTO>
    implements $BrowserTabSettingsDTOCopyWith<$Res> {
  _$BrowserTabSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
  }) {
    return _then(_value.copyWith(
      tabs: null == tabs
          ? _value.tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTabDTO>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabSettingsDTOImplCopyWith<$Res>
    implements $BrowserTabSettingsDTOCopyWith<$Res> {
  factory _$$BrowserTabSettingsDTOImplCopyWith(
          _$BrowserTabSettingsDTOImpl value,
          $Res Function(_$BrowserTabSettingsDTOImpl) then) =
      __$$BrowserTabSettingsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BrowserTabDTO> tabs});
}

/// @nodoc
class __$$BrowserTabSettingsDTOImplCopyWithImpl<$Res>
    extends _$BrowserTabSettingsDTOCopyWithImpl<$Res,
        _$BrowserTabSettingsDTOImpl>
    implements _$$BrowserTabSettingsDTOImplCopyWith<$Res> {
  __$$BrowserTabSettingsDTOImplCopyWithImpl(_$BrowserTabSettingsDTOImpl _value,
      $Res Function(_$BrowserTabSettingsDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
  }) {
    return _then(_$BrowserTabSettingsDTOImpl(
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTabDTO>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserTabSettingsDTOImpl extends _BrowserTabSettingsDTO {
  _$BrowserTabSettingsDTOImpl({final List<BrowserTabDTO> tabs = const []})
      : _tabs = tabs,
        super._();

  factory _$BrowserTabSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserTabSettingsDTOImplFromJson(json);

  final List<BrowserTabDTO> _tabs;
  @override
  @JsonKey()
  List<BrowserTabDTO> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  String toString() {
    return 'BrowserTabSettingsDTO(tabs: $tabs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabSettingsDTOImpl &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tabs));

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabSettingsDTOImplCopyWith<_$BrowserTabSettingsDTOImpl>
      get copyWith => __$$BrowserTabSettingsDTOImplCopyWithImpl<
          _$BrowserTabSettingsDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserTabSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _BrowserTabSettingsDTO extends BrowserTabSettingsDTO {
  factory _BrowserTabSettingsDTO({final List<BrowserTabDTO> tabs}) =
      _$BrowserTabSettingsDTOImpl;
  _BrowserTabSettingsDTO._() : super._();

  factory _BrowserTabSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$BrowserTabSettingsDTOImpl.fromJson;

  @override
  List<BrowserTabDTO> get tabs;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserTabSettingsDTOImplCopyWith<_$BrowserTabSettingsDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BrowserTabDTO _$BrowserTabDTOFromJson(Map<String, dynamic> json) {
  return _BrowserTabDTO.fromJson(json);
}

/// @nodoc
mixin _$BrowserTabDTO {
  @JsonKey(fromJson: _idFromJson)
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  bool get toggled => throw _privateConstructorUsedError;
  bool get iOSAudioSource => throw _privateConstructorUsedError;

  /// Serializes this BrowserTabDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserTabDTOCopyWith<BrowserTabDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabDTOCopyWith<$Res> {
  factory $BrowserTabDTOCopyWith(
          BrowserTabDTO value, $Res Function(BrowserTabDTO) then) =
      _$BrowserTabDTOCopyWithImpl<$Res, BrowserTabDTO>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String title,
      String url,
      bool toggled,
      bool iOSAudioSource});
}

/// @nodoc
class _$BrowserTabDTOCopyWithImpl<$Res, $Val extends BrowserTabDTO>
    implements $BrowserTabDTOCopyWith<$Res> {
  _$BrowserTabDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      toggled: null == toggled
          ? _value.toggled
          : toggled // ignore: cast_nullable_to_non_nullable
              as bool,
      iOSAudioSource: null == iOSAudioSource
          ? _value.iOSAudioSource
          : iOSAudioSource // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabDTOImplCopyWith<$Res>
    implements $BrowserTabDTOCopyWith<$Res> {
  factory _$$BrowserTabDTOImplCopyWith(
          _$BrowserTabDTOImpl value, $Res Function(_$BrowserTabDTOImpl) then) =
      __$$BrowserTabDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String title,
      String url,
      bool toggled,
      bool iOSAudioSource});
}

/// @nodoc
class __$$BrowserTabDTOImplCopyWithImpl<$Res>
    extends _$BrowserTabDTOCopyWithImpl<$Res, _$BrowserTabDTOImpl>
    implements _$$BrowserTabDTOImplCopyWith<$Res> {
  __$$BrowserTabDTOImplCopyWithImpl(
      _$BrowserTabDTOImpl _value, $Res Function(_$BrowserTabDTOImpl) _then)
      : super(_value, _then);

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
    return _then(_$BrowserTabDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      toggled: null == toggled
          ? _value.toggled
          : toggled // ignore: cast_nullable_to_non_nullable
              as bool,
      iOSAudioSource: null == iOSAudioSource
          ? _value.iOSAudioSource
          : iOSAudioSource // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserTabDTOImpl implements _BrowserTabDTO {
  const _$BrowserTabDTOImpl(
      {@JsonKey(fromJson: _idFromJson) required this.id,
      required this.title,
      required this.url,
      required this.toggled,
      required this.iOSAudioSource});

  factory _$BrowserTabDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserTabDTOImplFromJson(json);

  @override
  @JsonKey(fromJson: _idFromJson)
  final String id;
  @override
  final String title;
  @override
  final String url;
  @override
  final bool toggled;
  @override
  final bool iOSAudioSource;

  @override
  String toString() {
    return 'BrowserTabDTO(id: $id, title: $title, url: $url, toggled: $toggled, iOSAudioSource: $iOSAudioSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabDTOImpl &&
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

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabDTOImplCopyWith<_$BrowserTabDTOImpl> get copyWith =>
      __$$BrowserTabDTOImplCopyWithImpl<_$BrowserTabDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserTabDTOImplToJson(
      this,
    );
  }
}

abstract class _BrowserTabDTO implements BrowserTabDTO {
  const factory _BrowserTabDTO(
      {@JsonKey(fromJson: _idFromJson) required final String id,
      required final String title,
      required final String url,
      required final bool toggled,
      required final bool iOSAudioSource}) = _$BrowserTabDTOImpl;

  factory _BrowserTabDTO.fromJson(Map<String, dynamic> json) =
      _$BrowserTabDTOImpl.fromJson;

  @override
  @JsonKey(fromJson: _idFromJson)
  String get id;
  @override
  String get title;
  @override
  String get url;
  @override
  bool get toggled;
  @override
  bool get iOSAudioSource;

  /// Create a copy of BrowserTabDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserTabDTOImplCopyWith<_$BrowserTabDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
