// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserTabSettingsDTO {
  List<BrowserTabDTO> get tabs;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowserTabSettingsDTOCopyWith<BrowserTabSettingsDTO> get copyWith =>
      _$BrowserTabSettingsDTOCopyWithImpl<BrowserTabSettingsDTO>(
          this as BrowserTabSettingsDTO, _$identity);

  /// Serializes this BrowserTabSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrowserTabSettingsDTO &&
            const DeepCollectionEquality().equals(other.tabs, tabs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tabs));

  @override
  String toString() {
    return 'BrowserTabSettingsDTO(tabs: $tabs)';
  }
}

/// @nodoc
abstract mixin class $BrowserTabSettingsDTOCopyWith<$Res> {
  factory $BrowserTabSettingsDTOCopyWith(BrowserTabSettingsDTO value,
          $Res Function(BrowserTabSettingsDTO) _then) =
      _$BrowserTabSettingsDTOCopyWithImpl;
  @useResult
  $Res call({List<BrowserTabDTO> tabs});
}

/// @nodoc
class _$BrowserTabSettingsDTOCopyWithImpl<$Res>
    implements $BrowserTabSettingsDTOCopyWith<$Res> {
  _$BrowserTabSettingsDTOCopyWithImpl(this._self, this._then);

  final BrowserTabSettingsDTO _self;
  final $Res Function(BrowserTabSettingsDTO) _then;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
  }) {
    return _then(_self.copyWith(
      tabs: null == tabs
          ? _self.tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTabDTO>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BrowserTabSettingsDTO extends BrowserTabSettingsDTO {
  _BrowserTabSettingsDTO({final List<BrowserTabDTO> tabs = const []})
      : _tabs = tabs,
        super._();
  factory _BrowserTabSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabSettingsDTOFromJson(json);

  final List<BrowserTabDTO> _tabs;
  @override
  @JsonKey()
  List<BrowserTabDTO> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowserTabSettingsDTOCopyWith<_BrowserTabSettingsDTO> get copyWith =>
      __$BrowserTabSettingsDTOCopyWithImpl<_BrowserTabSettingsDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowserTabSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrowserTabSettingsDTO &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tabs));

  @override
  String toString() {
    return 'BrowserTabSettingsDTO(tabs: $tabs)';
  }
}

/// @nodoc
abstract mixin class _$BrowserTabSettingsDTOCopyWith<$Res>
    implements $BrowserTabSettingsDTOCopyWith<$Res> {
  factory _$BrowserTabSettingsDTOCopyWith(_BrowserTabSettingsDTO value,
          $Res Function(_BrowserTabSettingsDTO) _then) =
      __$BrowserTabSettingsDTOCopyWithImpl;
  @override
  @useResult
  $Res call({List<BrowserTabDTO> tabs});
}

/// @nodoc
class __$BrowserTabSettingsDTOCopyWithImpl<$Res>
    implements _$BrowserTabSettingsDTOCopyWith<$Res> {
  __$BrowserTabSettingsDTOCopyWithImpl(this._self, this._then);

  final _BrowserTabSettingsDTO _self;
  final $Res Function(_BrowserTabSettingsDTO) _then;

  /// Create a copy of BrowserTabSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tabs = null,
  }) {
    return _then(_BrowserTabSettingsDTO(
      tabs: null == tabs
          ? _self._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTabDTO>,
    ));
  }
}

/// @nodoc
mixin _$BrowserTabDTO {
  @JsonKey(fromJson: _idFromJson)
  String get id;
  String get title;
  String get url;
  bool get toggled;
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
      {@JsonKey(fromJson: _idFromJson) String id,
      String title,
      String url,
      bool toggled,
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

/// @nodoc
@JsonSerializable()
class _BrowserTabDTO implements BrowserTabDTO {
  const _BrowserTabDTO(
      {@JsonKey(fromJson: _idFromJson) required this.id,
      required this.title,
      required this.url,
      required this.toggled,
      required this.iOSAudioSource});
  factory _BrowserTabDTO.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabDTOFromJson(json);

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
      {@JsonKey(fromJson: _idFromJson) String id,
      String title,
      String url,
      bool toggled,
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
