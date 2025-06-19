// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  bool get isEmotes;
  double get textSize;
  bool get displayTimestamp;
  ChatEventsSettingsDTO get chatEventsSettings;
  ChatSettingsDTO get chatSettings; //GENERAL SETTINGS
  GeneralSettingsDTO get generalSettings;
  DashboardSettingsDTO get dashboardSettings; //CONNECTIONS SETTINGS
  bool get isObsConnected;
  String get obsWebsocketUrl;
  String get obsWebsocketPassword;
  List get obsConnectionsHistory;
  StreamElementsSettingsDTO get streamElementsSettings;
  String get rtIrlPushKey; //TTS SETTINGS
  TtsSettingsDTO get ttsSettings;

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
            (identical(other.isEmotes, isEmotes) ||
                other.isEmotes == isEmotes) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.displayTimestamp, displayTimestamp) ||
                other.displayTimestamp == displayTimestamp) &&
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
            const DeepCollectionEquality()
                .equals(other.obsConnectionsHistory, obsConnectionsHistory) &&
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
      chatEventsSettings,
      chatSettings,
      generalSettings,
      dashboardSettings,
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      const DeepCollectionEquality().hash(obsConnectionsHistory),
      streamElementsSettings,
      rtIrlPushKey,
      ttsSettings);

  @override
  String toString() {
    return 'SettingsDTO(isEmotes: $isEmotes, textSize: $textSize, displayTimestamp: $displayTimestamp, chatEventsSettings: $chatEventsSettings, chatSettings: $chatSettings, generalSettings: $generalSettings, dashboardSettings: $dashboardSettings, isObsConnected: $isObsConnected, obsWebsocketUrl: $obsWebsocketUrl, obsWebsocketPassword: $obsWebsocketPassword, obsConnectionsHistory: $obsConnectionsHistory, streamElementsSettings: $streamElementsSettings, rtIrlPushKey: $rtIrlPushKey, ttsSettings: $ttsSettings)';
  }
}

/// @nodoc
abstract mixin class $SettingsDTOCopyWith<$Res> {
  factory $SettingsDTOCopyWith(
          SettingsDTO value, $Res Function(SettingsDTO) _then) =
      _$SettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {bool isEmotes,
      double textSize,
      bool displayTimestamp,
      ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings,
      DashboardSettingsDTO dashboardSettings,
      bool isObsConnected,
      String obsWebsocketUrl,
      String obsWebsocketPassword,
      List obsConnectionsHistory,
      StreamElementsSettingsDTO streamElementsSettings,
      String rtIrlPushKey,
      TtsSettingsDTO ttsSettings});

  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  $ChatSettingsDTOCopyWith<$Res> get chatSettings;
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
  $DashboardSettingsDTOCopyWith<$Res> get dashboardSettings;
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings;
  $TtsSettingsDTOCopyWith<$Res> get ttsSettings;
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
    Object? isEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
    Object? dashboardSettings = null,
    Object? isObsConnected = null,
    Object? obsWebsocketUrl = null,
    Object? obsWebsocketPassword = null,
    Object? obsConnectionsHistory = null,
    Object? streamElementsSettings = null,
    Object? rtIrlPushKey = null,
    Object? ttsSettings = null,
  }) {
    return _then(_self.copyWith(
      isEmotes: null == isEmotes
          ? _self.isEmotes
          : isEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _self.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _self.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
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
      dashboardSettings: null == dashboardSettings
          ? _self.dashboardSettings
          : dashboardSettings // ignore: cast_nullable_to_non_nullable
              as DashboardSettingsDTO,
      isObsConnected: null == isObsConnected
          ? _self.isObsConnected
          : isObsConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      obsWebsocketUrl: null == obsWebsocketUrl
          ? _self.obsWebsocketUrl
          : obsWebsocketUrl // ignore: cast_nullable_to_non_nullable
              as String,
      obsWebsocketPassword: null == obsWebsocketPassword
          ? _self.obsWebsocketPassword
          : obsWebsocketPassword // ignore: cast_nullable_to_non_nullable
              as String,
      obsConnectionsHistory: null == obsConnectionsHistory
          ? _self.obsConnectionsHistory
          : obsConnectionsHistory // ignore: cast_nullable_to_non_nullable
              as List,
      streamElementsSettings: null == streamElementsSettings
          ? _self.streamElementsSettings
          : streamElementsSettings // ignore: cast_nullable_to_non_nullable
              as StreamElementsSettingsDTO,
      rtIrlPushKey: null == rtIrlPushKey
          ? _self.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      ttsSettings: null == ttsSettings
          ? _self.ttsSettings
          : ttsSettings // ignore: cast_nullable_to_non_nullable
              as TtsSettingsDTO,
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

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardSettingsDTOCopyWith<$Res> get dashboardSettings {
    return $DashboardSettingsDTOCopyWith<$Res>(_self.dashboardSettings,
        (value) {
      return _then(_self.copyWith(dashboardSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings {
    return $StreamElementsSettingsDTOCopyWith<$Res>(
        _self.streamElementsSettings, (value) {
      return _then(_self.copyWith(streamElementsSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TtsSettingsDTOCopyWith<$Res> get ttsSettings {
    return $TtsSettingsDTOCopyWith<$Res>(_self.ttsSettings, (value) {
      return _then(_self.copyWith(ttsSettings: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SettingsDTO implements SettingsDTO {
  const _SettingsDTO(
      {this.isEmotes = true,
      this.textSize = 19,
      this.displayTimestamp = false,
      required this.chatEventsSettings,
      required this.chatSettings,
      required this.generalSettings,
      required this.dashboardSettings,
      this.isObsConnected = false,
      this.obsWebsocketUrl = "",
      this.obsWebsocketPassword = "",
      final List obsConnectionsHistory = const [],
      required this.streamElementsSettings,
      this.rtIrlPushKey = "",
      required this.ttsSettings})
      : _obsConnectionsHistory = obsConnectionsHistory;
  factory _SettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsDTOFromJson(json);

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
  final List _obsConnectionsHistory;
  @override
  @JsonKey()
  List get obsConnectionsHistory {
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
            (identical(other.isEmotes, isEmotes) ||
                other.isEmotes == isEmotes) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.displayTimestamp, displayTimestamp) ||
                other.displayTimestamp == displayTimestamp) &&
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
      chatEventsSettings,
      chatSettings,
      generalSettings,
      dashboardSettings,
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      const DeepCollectionEquality().hash(_obsConnectionsHistory),
      streamElementsSettings,
      rtIrlPushKey,
      ttsSettings);

  @override
  String toString() {
    return 'SettingsDTO(isEmotes: $isEmotes, textSize: $textSize, displayTimestamp: $displayTimestamp, chatEventsSettings: $chatEventsSettings, chatSettings: $chatSettings, generalSettings: $generalSettings, dashboardSettings: $dashboardSettings, isObsConnected: $isObsConnected, obsWebsocketUrl: $obsWebsocketUrl, obsWebsocketPassword: $obsWebsocketPassword, obsConnectionsHistory: $obsConnectionsHistory, streamElementsSettings: $streamElementsSettings, rtIrlPushKey: $rtIrlPushKey, ttsSettings: $ttsSettings)';
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
      {bool isEmotes,
      double textSize,
      bool displayTimestamp,
      ChatEventsSettingsDTO chatEventsSettings,
      ChatSettingsDTO chatSettings,
      GeneralSettingsDTO generalSettings,
      DashboardSettingsDTO dashboardSettings,
      bool isObsConnected,
      String obsWebsocketUrl,
      String obsWebsocketPassword,
      List obsConnectionsHistory,
      StreamElementsSettingsDTO streamElementsSettings,
      String rtIrlPushKey,
      TtsSettingsDTO ttsSettings});

  @override
  $ChatEventsSettingsDTOCopyWith<$Res> get chatEventsSettings;
  @override
  $ChatSettingsDTOCopyWith<$Res> get chatSettings;
  @override
  $GeneralSettingsDTOCopyWith<$Res> get generalSettings;
  @override
  $DashboardSettingsDTOCopyWith<$Res> get dashboardSettings;
  @override
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings;
  @override
  $TtsSettingsDTOCopyWith<$Res> get ttsSettings;
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
    Object? isEmotes = null,
    Object? textSize = null,
    Object? displayTimestamp = null,
    Object? chatEventsSettings = null,
    Object? chatSettings = null,
    Object? generalSettings = null,
    Object? dashboardSettings = null,
    Object? isObsConnected = null,
    Object? obsWebsocketUrl = null,
    Object? obsWebsocketPassword = null,
    Object? obsConnectionsHistory = null,
    Object? streamElementsSettings = null,
    Object? rtIrlPushKey = null,
    Object? ttsSettings = null,
  }) {
    return _then(_SettingsDTO(
      isEmotes: null == isEmotes
          ? _self.isEmotes
          : isEmotes // ignore: cast_nullable_to_non_nullable
              as bool,
      textSize: null == textSize
          ? _self.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      displayTimestamp: null == displayTimestamp
          ? _self.displayTimestamp
          : displayTimestamp // ignore: cast_nullable_to_non_nullable
              as bool,
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
      dashboardSettings: null == dashboardSettings
          ? _self.dashboardSettings
          : dashboardSettings // ignore: cast_nullable_to_non_nullable
              as DashboardSettingsDTO,
      isObsConnected: null == isObsConnected
          ? _self.isObsConnected
          : isObsConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      obsWebsocketUrl: null == obsWebsocketUrl
          ? _self.obsWebsocketUrl
          : obsWebsocketUrl // ignore: cast_nullable_to_non_nullable
              as String,
      obsWebsocketPassword: null == obsWebsocketPassword
          ? _self.obsWebsocketPassword
          : obsWebsocketPassword // ignore: cast_nullable_to_non_nullable
              as String,
      obsConnectionsHistory: null == obsConnectionsHistory
          ? _self._obsConnectionsHistory
          : obsConnectionsHistory // ignore: cast_nullable_to_non_nullable
              as List,
      streamElementsSettings: null == streamElementsSettings
          ? _self.streamElementsSettings
          : streamElementsSettings // ignore: cast_nullable_to_non_nullable
              as StreamElementsSettingsDTO,
      rtIrlPushKey: null == rtIrlPushKey
          ? _self.rtIrlPushKey
          : rtIrlPushKey // ignore: cast_nullable_to_non_nullable
              as String,
      ttsSettings: null == ttsSettings
          ? _self.ttsSettings
          : ttsSettings // ignore: cast_nullable_to_non_nullable
              as TtsSettingsDTO,
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

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardSettingsDTOCopyWith<$Res> get dashboardSettings {
    return $DashboardSettingsDTOCopyWith<$Res>(_self.dashboardSettings,
        (value) {
      return _then(_self.copyWith(dashboardSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamElementsSettingsDTOCopyWith<$Res> get streamElementsSettings {
    return $StreamElementsSettingsDTOCopyWith<$Res>(
        _self.streamElementsSettings, (value) {
      return _then(_self.copyWith(streamElementsSettings: value));
    });
  }

  /// Create a copy of SettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TtsSettingsDTOCopyWith<$Res> get ttsSettings {
    return $TtsSettingsDTOCopyWith<$Res>(_self.ttsSettings, (value) {
      return _then(_self.copyWith(ttsSettings: value));
    });
  }
}

// dart format on
