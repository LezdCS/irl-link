// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsDTO _$SettingsDTOFromJson(Map<String, dynamic> json) {
  return _SettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$SettingsDTO {
//CHAT SETTINGS
  bool get isEmotes => throw _privateConstructorUsedError;
  double get textSize => throw _privateConstructorUsedError;
  bool get displayTimestamp => throw _privateConstructorUsedError;
  List<dynamic> get hiddenUsersIds => throw _privateConstructorUsedError;
  ChatEventsSettingsDTO get chatEventsSettings =>
      throw _privateConstructorUsedError;
  ChatSettingsDTO get chatSettings =>
      throw _privateConstructorUsedError; //GENERAL SETTINGS
  GeneralSettingsDTO get generalSettings => throw _privateConstructorUsedError;
  DashboardSettingsDTO get dashboardSettings =>
      throw _privateConstructorUsedError; //CONNECTIONS SETTINGS
  bool get isObsConnected => throw _privateConstructorUsedError;
  String get obsWebsocketUrl => throw _privateConstructorUsedError;
  String get obsWebsocketPassword => throw _privateConstructorUsedError;
  BrowserTabSettingsDTO get browserTabs => throw _privateConstructorUsedError;
  List<dynamic> get obsConnectionsHistory => throw _privateConstructorUsedError;
  StreamElementsSettingsDTO get streamElementsSettings =>
      throw _privateConstructorUsedError;
  String get rtIrlPushKey => throw _privateConstructorUsedError; //TTS SETTINGS
  TtsSettingsDTO get ttsSettings => throw _privateConstructorUsedError;

  /// Serializes this SettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsDTOCopyWith<SettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsDTOCopyWith<$Res> {
  factory $SettingsDTOCopyWith(
          SettingsDTO value, $Res Function(SettingsDTO) then) =
      _$SettingsDTOCopyWithImpl<$Res, SettingsDTO>;
  @useResult
  $Res call(
      {bool isEmotes,
      double textSize,
      bool displayTimestamp,
      List<dynamic> hiddenUsersIds,
      ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings,
      DashboardSettingsDTO dashboardSettings,
      bool isObsConnected,
      String obsWebsocketUrl,
      String obsWebsocketPassword,
      BrowserTabSettingsDTO browserTabs,
      List<dynamic> obsConnectionsHistory,
      StreamElementsSettingsDTO streamElementsSettings,
      String rtIrlPushKey,
      TtsSettingsDTO ttsSettings});

  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings;
}

/// @nodoc
class _$SettingsDTOCopyWithImpl<$Res, $Val extends SettingsDTO>
    implements $SettingsDTOCopyWith<$Res> {
  _$SettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? hiddenUsersIds = null,
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
    Object? dashboardSettings = null,
    Object? isObsConnected = null,
    Object? obsWebsocketUrl = null,
    Object? obsWebsocketPassword = null,
    Object? browserTabs = null,
    Object? obsConnectionsHistory = null,
    Object? streamElementsSettings = null,
    Object? rtIrlPushKey = null,
    Object? ttsSettings = null,
  }) {
    return _then(_value.copyWith(
      isEmotes: null == isEmotes
          ? _value.isEmotes
          : isEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _value.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      hiddenUsersIds: null == hiddenUsersIds
          ? _value.hiddenUsersIds
          : hiddenUsersIds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      chatEventsSettings: null == chatEventsSettings
          ? _value.chatEventsSettings
          : chatEventsSettings // ignore: cast_nullable_to_non_nullable
              as ChatEventsSettingsDTO,
      chatSettings: null == chatSettings
          ? _value.chatSettings
          : chatSettings // ignore: cast_nullable_to_non_nullable
              as ChatSettingsDTO,
      generalSettings: null == generalSettings
          ? _value.generalSettings
          : generalSettings // ignore: cast_nullable_to_non_nullable
              as GeneralSettingsDTO,
      dashboardSettings: null == dashboardSettings
          ? _value.dashboardSettings
          : dashboardSettings // ignore: cast_nullable_to_non_nullable
              as DashboardSettingsDTO,
      isObsConnected: null == isObsConnected
          ? _value.isObsConnected
          : isObsConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      obsWebsocketUrl: null == obsWebsocketUrl
          ? _value.obsWebsocketUrl
          : obsWebsocketUrl // ignore: cast_nullable_to_non_nullable
              as String,
      obsWebsocketPassword: null == obsWebsocketPassword
          ? _value.obsWebsocketPassword
          : obsWebsocketPassword // ignore: cast_nullable_to_non_nullable
              as String,
      browserTabs: null == browserTabs
          ? _value.browserTabs
          : browserTabs // ignore: cast_nullable_to_non_nullable
              as BrowserTabSettingsDTO,
      obsConnectionsHistory: null == obsConnectionsHistory
          ? _value.obsConnectionsHistory
          : obsConnectionsHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      streamElementsSettings: null == streamElementsSettings
          ? _value.streamElementsSettings
          : streamElementsSettings // ignore: cast_nullable_to_non_nullable
              as StreamElementsSettingsDTO,
      rtIrlPushKey: null == rtIrlPushKey
          ? _value.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      ttsSettings: null == ttsSettings
          ? _value.ttsSettings
          : ttsSettings // ignore: cast_nullable_to_non_nullable
              as TtsSettingsDTO,
    ) as $Val);
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings {
    return $ChatEventsSettingsDTOCopyWith<$Res>(_value.chatEventsSettings,
        (value) {
      return _then(_value.copyWith(chatEventsSettings: value) as $Val);
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings {
    return $GeneralSettingsDTOCopyWith<$Res>(_value.generalSettings, (value) {
      return _then(_value.copyWith(generalSettings: value) as $Val);
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings {
    return $StreamElementsSettingsDTOCopyWith<$Res>(
        _value.streamElementsSettings, (value) {
      return _then(_value.copyWith(streamElementsSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingsDTOImplCopyWith<$Res>
    implements $SettingsDTOCopyWith<$Res> {
  factory _$$SettingsDTOImplCopyWith(
          _$SettingsDTOImpl value, $Res Function(_$SettingsDTOImpl) then) =
      __$$SettingsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEmotes,
      double textSize,
      bool displayTimestamp,
      List<dynamic> hiddenUsersIds,
      ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings,
      DashboardSettingsDTO dashboardSettings,
      bool isObsConnected,
      String obsWebsocketUrl,
      String obsWebsocketPassword,
      BrowserTabSettingsDTO browserTabs,
      List<dynamic> obsConnectionsHistory,
      StreamElementsSettingsDTO streamElementsSettings,
      String rtIrlPushKey,
      TtsSettingsDTO ttsSettings});

  @override
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  @override
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
  @override
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings;
}

/// @nodoc
class __$$SettingsDTOImplCopyWithImpl<$Res>
    extends _$SettingsDTOCopyWithImpl<$Res, _$SettingsDTOImpl>
    implements _$$SettingsDTOImplCopyWith<$Res> {
  __$$SettingsDTOImplCopyWithImpl(
      _$SettingsDTOImpl _value, $Res Function(_$SettingsDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? hiddenUsersIds = null,
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
    Object? dashboardSettings = null,
    Object? isObsConnected = null,
    Object? obsWebsocketUrl = null,
    Object? obsWebsocketPassword = null,
    Object? browserTabs = null,
    Object? obsConnectionsHistory = null,
    Object? streamElementsSettings = null,
    Object? rtIrlPushKey = null,
    Object? ttsSettings = null,
  }) {
    return _then(_$SettingsDTOImpl(
      isEmotes: null == isEmotes
          ? _value.isEmotes
          : isEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _value.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
      hiddenUsersIds: null == hiddenUsersIds
          ? _value._hiddenUsersIds
          : hiddenUsersIds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      chatEventsSettings: null == chatEventsSettings
          ? _value.chatEventsSettings
          : chatEventsSettings // ignore: cast_nullable_to_non_nullable
              as ChatEventsSettingsDTO,
      chatSettings: null == chatSettings
          ? _value.chatSettings
          : chatSettings // ignore: cast_nullable_to_non_nullable
              as ChatSettingsDTO,
      generalSettings: null == generalSettings
          ? _value.generalSettings
          : generalSettings // ignore: cast_nullable_to_non_nullable
              as GeneralSettingsDTO,
      dashboardSettings: null == dashboardSettings
          ? _value.dashboardSettings
          : dashboardSettings // ignore: cast_nullable_to_non_nullable
              as DashboardSettingsDTO,
      isObsConnected: null == isObsConnected
          ? _value.isObsConnected
          : isObsConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      obsWebsocketUrl: null == obsWebsocketUrl
          ? _value.obsWebsocketUrl
          : obsWebsocketUrl // ignore: cast_nullable_to_non_nullable
              as String,
      obsWebsocketPassword: null == obsWebsocketPassword
          ? _value.obsWebsocketPassword
          : obsWebsocketPassword // ignore: cast_nullable_to_non_nullable
              as String,
      browserTabs: null == browserTabs
          ? _value.browserTabs
          : browserTabs // ignore: cast_nullable_to_non_nullable
              as BrowserTabSettingsDTO,
      obsConnectionsHistory: null == obsConnectionsHistory
          ? _value._obsConnectionsHistory
          : obsConnectionsHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      streamElementsSettings: null == streamElementsSettings
          ? _value.streamElementsSettings
          : streamElementsSettings // ignore: cast_nullable_to_non_nullable
              as StreamElementsSettingsDTO,
      rtIrlPushKey: null == rtIrlPushKey
          ? _value.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      ttsSettings: null == ttsSettings
          ? _value.ttsSettings
          : ttsSettings // ignore: cast_nullable_to_non_nullable
              as TtsSettingsDTO,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsDTOImpl implements _SettingsDTO {
  const _$SettingsDTOImpl(
      {this.isEmotes = true,
      this.textSize = 19,
      this.displayTimestamp = false,
      final List<dynamic> hiddenUsersIds = const [],
      required this.chatEventsSettings,
      required this.chatSettings,
      required this.generalSettings,
      required this.dashboardSettings,
      this.isObsConnected = false,
      this.obsWebsocketUrl = "",
      this.obsWebsocketPassword = "",
      required this.browserTabs,
      final List<dynamic> obsConnectionsHistory = const [],
      required this.streamElementsSettings,
      this.rtIrlPushKey = "",
      required this.ttsSettings})
      : _hiddenUsersIds = hiddenUsersIds,
        _obsConnectionsHistory = obsConnectionsHistory;

  factory _$SettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsDTOImplFromJson(json);

//CHAT SETTINGS
  @override
  @JsonKey()
  final bool isEmotes;
  @override
  @JsonKey()
  final double textSize;
  @override
  @JsonKey()
  final bool displayTimestamp;
  final List<dynamic> _hiddenUsersIds;
  @override
  @JsonKey()
  List<dynamic> get hiddenUsersIds {
    if (_hiddenUsersIds is EqualUnmodifiableListView) return _hiddenUsersIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenUsersIds);
  }

  @override
  final ChatEventsSettingsDTO chatEventsSettings;
  @override
  final ChatSettingsDTO chatSettings;
//GENERAL SETTINGS
  @override
  final GeneralSettingsDTO generalSettings;
  @override
  final DashboardSettingsDTO dashboardSettings;
//CONNECTIONS SETTINGS
  @override
  @JsonKey()
  final bool isObsConnected;
  @override
  @JsonKey()
  final String obsWebsocketUrl;
  @override
  @JsonKey()
  final String obsWebsocketPassword;
  @override
  final BrowserTabSettingsDTO browserTabs;
  final List<dynamic> _obsConnectionsHistory;
  @override
  @JsonKey()
  List<dynamic> get obsConnectionsHistory {
    if (_obsConnectionsHistory is EqualUnmodifiableListView)
      return _obsConnectionsHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_obsConnectionsHistory);
  }

  @override
  final StreamElementsSettingsDTO streamElementsSettings;
  @override
  @JsonKey()
  final String rtIrlPushKey;
//TTS SETTINGS
  @override
  final TtsSettingsDTO ttsSettings;

  @override
  String toString() {
    return 'SettingsDTO(isEmotes: $isEmotes, textSize: $textSize, displayTimestamp: $displayTimestamp, hiddenUsersIds: $hiddenUsersIds, chatEventsSettings: $chatEventsSettings, chatSettings: $chatSettings, generalSettings: $generalSettings, dashboardSettings: $dashboardSettings, isObsConnected: $isObsConnected, obsWebsocketUrl: $obsWebsocketUrl, obsWebsocketPassword: $obsWebsocketPassword, browserTabs: $browserTabs, obsConnectionsHistory: $obsConnectionsHistory, streamElementsSettings: $streamElementsSettings, rtIrlPushKey: $rtIrlPushKey, ttsSettings: $ttsSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsDTOImpl &&
            (identical(other.isEmotes, isEmotes) ||
                other.isEmotes == isEmotes) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.displayTimestamp, displayTimestamp) ||
                other.displayTimestamp == displayTimestamp) &&
            const DeepCollectionEquality()
                .equals(other._hiddenUsersIds, _hiddenUsersIds) &&
            (identical(other.chatEventsSettings, chatEventsSettings) ||
                other.chatEventsSettings == chatEventsSettings) &&
            (identical(other.chatSettings, chatSettings) ||
                other.chatSettings == chatSettings) &&
            (identical(other.generalSettings, generalSettings) ||
                other.generalSettings == generalSettings) &&
            (identical(other.dashboardSettings, dashboardSettings) ||
                other.dashboardSettings == dashboardSettings) &&
            (identical(other.isObsConnected, isObsConnected) ||
                other.isObsConnected == isObsConnected) &&
            (identical(other.obsWebsocketUrl, obsWebsocketUrl) ||
                other.obsWebsocketUrl == obsWebsocketUrl) &&
            (identical(other.obsWebsocketPassword, obsWebsocketPassword) ||
                other.obsWebsocketPassword == obsWebsocketPassword) &&
            (identical(other.browserTabs, browserTabs) ||
                other.browserTabs == browserTabs) &&
            const DeepCollectionEquality()
                .equals(other._obsConnectionsHistory, _obsConnectionsHistory) &&
            (identical(other.streamElementsSettings, streamElementsSettings) ||
                other.streamElementsSettings == streamElementsSettings) &&
            (identical(other.rtIrlPushKey, rtIrlPushKey) ||
                other.rtIrlPushKey == rtIrlPushKey) &&
            (identical(other.ttsSettings, ttsSettings) ||
                other.ttsSettings == ttsSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isEmotes,
      textSize,
      displayTimestamp,
      const DeepCollectionEquality().hash(_hiddenUsersIds),
      chatEventsSettings,
      chatSettings,
      generalSettings,
      dashboardSettings,
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      browserTabs,
      const DeepCollectionEquality().hash(_obsConnectionsHistory),
      streamElementsSettings,
      rtIrlPushKey,
      ttsSettings);

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsDTOImplCopyWith<_$SettingsDTOImpl> get copyWith =>
      __$$SettingsDTOImplCopyWithImpl<_$SettingsDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _SettingsDTO implements SettingsDTO {
  const factory _SettingsDTO(
      {final bool isEmotes,
      final double textSize,
      final bool displayTimestamp,
      final List<dynamic> hiddenUsersIds,
      required final ChatEventsSettingsDTO chatEventsSettings,
      required final ChatSettingsDTO chatSettings,
      required final GeneralSettingsDTO generalSettings,
      required final DashboardSettingsDTO dashboardSettings,
      final bool isObsConnected,
      final String obsWebsocketUrl,
      final String obsWebsocketPassword,
      required final BrowserTabSettingsDTO browserTabs,
      final List<dynamic> obsConnectionsHistory,
      required final StreamElementsSettingsDTO streamElementsSettings,
      final String rtIrlPushKey,
      required final TtsSettingsDTO ttsSettings}) = _$SettingsDTOImpl;

  factory _SettingsDTO.fromJson(Map<String, dynamic> json) =
      _$SettingsDTOImpl.fromJson;

//CHAT SETTINGS
  @override
  bool get isEmotes;
  @override
  double get textSize;
  @override
  bool get displayTimestamp;
  @override
  List<dynamic> get hiddenUsersIds;
  @override
  ChatEventsSettingsDTO get chatEventsSettings;
  @override
  ChatSettingsDTO get chatSettings; //GENERAL SETTINGS
  @override
  GeneralSettingsDTO get generalSettings;
  @override
  DashboardSettingsDTO get dashboardSettings; //CONNECTIONS SETTINGS
  @override
  bool get isObsConnected;
  @override
  String get obsWebsocketUrl;
  @override
  String get obsWebsocketPassword;
  @override
  BrowserTabSettingsDTO get browserTabs;
  @override
  List<dynamic> get obsConnectionsHistory;
  @override
  StreamElementsSettingsDTO get streamElementsSettings;
  @override
  String get rtIrlPushKey; //TTS SETTINGS
  @override
  TtsSettingsDTO get ttsSettings;

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsDTOImplCopyWith<_$SettingsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
