// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint, unnecessary_cast, unused_local_variable

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;

import '../../data/entities/dashboard_event_dto.dart' as _i11;
import '../../data/entities/settings/browser_tab_settings_dto.dart' as _i7;
import '../../data/entities/settings/chat_events_settings_dto.dart' as _i17;
import '../../data/entities/settings/chat_settings_dto.dart' as _i5;
import '../../data/entities/settings/dashboard_settings_dto.dart' as _i25;
import '../../data/entities/settings/general_settings_dto.dart' as _i9;
import '../../data/entities/settings/stream_elements_settings_dto.dart' as _i13;
import '../../data/entities/settings/tts_settings_dto.dart' as _i15;
import '../../data/entities/settings_dto.dart' as _i3;
import '../../data/entities/twitch/twitch_credentials_dto.dart' as _i19;
import '../../data/entities/twitch/twitch_decoded_idtoken_dto.dart' as _i21;
import '../../data/entities/twitch/twitch_user_dto.dart' as _i23;
import '../../domain/entities/dashboard_event.dart' as _i10;
import '../../domain/entities/settings.dart' as _i2;
import '../../domain/entities/settings/browser_tab_settings.dart' as _i6;
import '../../domain/entities/settings/chat_events_settings.dart' as _i16;
import '../../domain/entities/settings/chat_settings.dart' as _i4;
import '../../domain/entities/settings/dashboard_settings.dart' as _i24;
import '../../domain/entities/settings/general_settings.dart' as _i8;
import '../../domain/entities/settings/stream_elements_settings.dart' as _i12;
import '../../domain/entities/settings/tts_settings.dart' as _i14;
import '../../domain/entities/twitch/twitch_credentials.dart' as _i18;
import '../../domain/entities/twitch/twitch_decoded_idtoken.dart' as _i20;
import '../../domain/entities/twitch/twitch_user.dart' as _i22;

/// {@template package:irllink/src/core/utils/mapper.dart}
/// Available mappings:
/// - `Settings` → `SettingsDTO`.
/// - `Channel` → `ChannelDTO`.
/// - `ChatGroup` → `ChatGroupDTO`.
/// - `BrowserTab` → `BrowserTabDTO`.
/// - `ChatSettings` → `ChatSettingsDTO`.
/// - `GeneralSettings` → `GeneralSettingsDTO`.
/// - `DashboardEvent` → `DashboardEventDTO`.
/// - `BrowserTabSettings` → `BrowserTabSettingsDTO`.
/// - `StreamElementsSettings` → `StreamElementsSettingsDTO`.
/// - `TtsSettings` → `TtsSettingsDTO`.
/// - `ChatEventsSettings` → `ChatEventsSettingsDTO`.
/// - `TwitchCredentials` → `TwitchCredentialsDTO`.
/// - `TwitchDecodedIdToken` → `TwitchDecodedIdTokenDTO`.
/// - `TwitchUser` → `TwitchUserDTO`.
/// - `DashboardSettings` → `DashboardSettingsDTO`.
/// {@endtemplate}
class $Mappr implements _i1.AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;

  List<_i1.AutoMapprInterface> get _delegates => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.Settings>() ||
            sourceTypeOf == _typeOf<_i2.Settings?>()) &&
        (targetTypeOf == _typeOf<_i3.SettingsDTO>() ||
            targetTypeOf == _typeOf<_i3.SettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.Channel>() ||
            sourceTypeOf == _typeOf<_i4.Channel?>()) &&
        (targetTypeOf == _typeOf<_i5.ChannelDTO>() ||
            targetTypeOf == _typeOf<_i5.ChannelDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatGroup>() ||
            sourceTypeOf == _typeOf<_i4.ChatGroup?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatGroupDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatGroupDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTab>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTab?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatSettings>() ||
            sourceTypeOf == _typeOf<_i4.ChatSettings?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatSettingsDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i8.GeneralSettings>() ||
            sourceTypeOf == _typeOf<_i8.GeneralSettings?>()) &&
        (targetTypeOf == _typeOf<_i9.GeneralSettingsDTO>() ||
            targetTypeOf == _typeOf<_i9.GeneralSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i10.DashboardEvent>() ||
            sourceTypeOf == _typeOf<_i10.DashboardEvent?>()) &&
        (targetTypeOf == _typeOf<_i11.DashboardEventDTO>() ||
            targetTypeOf == _typeOf<_i11.DashboardEventDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTabSettings>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTabSettings?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i12.StreamElementsSettings>() ||
            sourceTypeOf == _typeOf<_i12.StreamElementsSettings?>()) &&
        (targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i14.TtsSettings>() ||
            sourceTypeOf == _typeOf<_i14.TtsSettings?>()) &&
        (targetTypeOf == _typeOf<_i15.TtsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i15.TtsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i16.ChatEventsSettings>() ||
            sourceTypeOf == _typeOf<_i16.ChatEventsSettings?>()) &&
        (targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i18.TwitchCredentials>() ||
            sourceTypeOf == _typeOf<_i18.TwitchCredentials?>()) &&
        (targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken>() ||
            sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken?>()) &&
        (targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO>() ||
            targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i22.TwitchUser>() ||
            sourceTypeOf == _typeOf<_i22.TwitchUser?>()) &&
        (targetTypeOf == _typeOf<_i23.TwitchUserDTO>() ||
            targetTypeOf == _typeOf<_i23.TwitchUserDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i24.DashboardSettings>() ||
            sourceTypeOf == _typeOf<_i24.DashboardSettings?>()) &&
        (targetTypeOf == _typeOf<_i25.DashboardSettingsDTO>() ||
            targetTypeOf == _typeOf<_i25.DashboardSettingsDTO?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _delegates) {
        if (mappr.canConvert<SOURCE, TARGET>()) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(model)!;
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
        onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _safeConvert(
        model,
        onMappingError: onMappingError,
      );
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(
          model,
          onMappingError: onMappingError,
        );
      }
    }

    return null;
  }

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET>((item) => _convert(item)!);
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
        onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>(
          (item) => _safeConvert(item, onMappingError: onMappingError));
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(
          model,
          onMappingError: onMappingError,
        );
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
        onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(
          model,
          onMappingError: onMappingError,
        );
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
        onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(
          model,
          onMappingError: onMappingError,
        );
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.Settings>() ||
            sourceTypeOf == _typeOf<_i2.Settings?>()) &&
        (targetTypeOf == _typeOf<_i3.SettingsDTO>() ||
            targetTypeOf == _typeOf<_i3.SettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i2$Settings_To__i3$SettingsDTO((model as _i2.Settings?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i4.Channel>() ||
            sourceTypeOf == _typeOf<_i4.Channel?>()) &&
        (targetTypeOf == _typeOf<_i5.ChannelDTO>() ||
            targetTypeOf == _typeOf<_i5.ChannelDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i4$Channel_To__i5$ChannelDTO((model as _i4.Channel?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatGroup>() ||
            sourceTypeOf == _typeOf<_i4.ChatGroup?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatGroupDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatGroupDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i4$ChatGroup_To__i5$ChatGroupDTO((model as _i4.ChatGroup?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTab>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTab?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i6$BrowserTab_To__i7$BrowserTabDTO(
          (model as _i6.BrowserTab?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatSettings>() ||
            sourceTypeOf == _typeOf<_i4.ChatSettings?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatSettingsDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i4$ChatSettings_To__i5$ChatSettingsDTO(
          (model as _i4.ChatSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i8.GeneralSettings>() ||
            sourceTypeOf == _typeOf<_i8.GeneralSettings?>()) &&
        (targetTypeOf == _typeOf<_i9.GeneralSettingsDTO>() ||
            targetTypeOf == _typeOf<_i9.GeneralSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i8$GeneralSettings_To__i9$GeneralSettingsDTO(
          (model as _i8.GeneralSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i10.DashboardEvent>() ||
            sourceTypeOf == _typeOf<_i10.DashboardEvent?>()) &&
        (targetTypeOf == _typeOf<_i11.DashboardEventDTO>() ||
            targetTypeOf == _typeOf<_i11.DashboardEventDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i10$DashboardEvent_To__i11$DashboardEventDTO(
          (model as _i10.DashboardEvent?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTabSettings>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTabSettings?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i6$BrowserTabSettings_To__i7$BrowserTabSettingsDTO(
          (model as _i6.BrowserTabSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i12.StreamElementsSettings>() ||
            sourceTypeOf == _typeOf<_i12.StreamElementsSettings?>()) &&
        (targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i12$StreamElementsSettings_To__i13$StreamElementsSettingsDTO(
          (model as _i12.StreamElementsSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i14.TtsSettings>() ||
            sourceTypeOf == _typeOf<_i14.TtsSettings?>()) &&
        (targetTypeOf == _typeOf<_i15.TtsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i15.TtsSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i14$TtsSettings_To__i15$TtsSettingsDTO(
          (model as _i14.TtsSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i16.ChatEventsSettings>() ||
            sourceTypeOf == _typeOf<_i16.ChatEventsSettings?>()) &&
        (targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i16$ChatEventsSettings_To__i17$ChatEventsSettingsDTO(
          (model as _i16.ChatEventsSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i18.TwitchCredentials>() ||
            sourceTypeOf == _typeOf<_i18.TwitchCredentials?>()) &&
        (targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i18$TwitchCredentials_To__i19$TwitchCredentialsDTO(
          (model as _i18.TwitchCredentials?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken>() ||
            sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken?>()) &&
        (targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO>() ||
            targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i20$TwitchDecodedIdToken_To__i21$TwitchDecodedIdTokenDTO(
          (model as _i20.TwitchDecodedIdToken?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i22.TwitchUser>() ||
            sourceTypeOf == _typeOf<_i22.TwitchUser?>()) &&
        (targetTypeOf == _typeOf<_i23.TwitchUserDTO>() ||
            targetTypeOf == _typeOf<_i23.TwitchUserDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i22$TwitchUser_To__i23$TwitchUserDTO(
          (model as _i22.TwitchUser?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i24.DashboardSettings>() ||
            sourceTypeOf == _typeOf<_i24.DashboardSettings?>()) &&
        (targetTypeOf == _typeOf<_i25.DashboardSettingsDTO>() ||
            targetTypeOf == _typeOf<_i25.DashboardSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i24$DashboardSettings_To__i25$DashboardSettingsDTO(
          (model as _i24.DashboardSettings?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  TARGET? _safeConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
        onMappingError,
  }) {
    if (!useSafeMapping<SOURCE, TARGET>()) {
      return _convert(
        model,
        canReturnNull: true,
      );
    }
    try {
      return _convert(
        model,
        canReturnNull: true,
      );
    } catch (e, s) {
      onMappingError?.call(e, s, model);
      return null;
    }
  }

  /// {@macro AutoMapprInterface:useSafeMapping}
  /// {@macro package:irllink/src/core/utils/mapper.dart}
  @override
  bool useSafeMapping<SOURCE, TARGET>() {
    return false;
  }

  _i3.SettingsDTO _map__i2$Settings_To__i3$SettingsDTO(_i2.Settings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Settings → SettingsDTO failed because Settings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Settings, SettingsDTO> to handle null values during mapping.');
    }
    return _i3.SettingsDTO(
      isEmotes: model.isEmotes,
      textSize: model.textSize,
      displayTimestamp: model.displayTimestamp,
      hiddenUsersIds: model.hiddenUsersIds,
      chatEventsSettings: model.chatEventsSettings,
      chatSettings: model.chatSettings,
      generalSettings: model.generalSettings,
      dashboardSettings: model.dashboardSettings,
      isObsConnected: model.isObsConnected,
      obsWebsocketUrl: model.obsWebsocketUrl,
      obsWebsocketPassword: model.obsWebsocketPassword,
      browserTabs: model.browserTabs,
      obsConnectionsHistory: model.obsConnectionsHistory,
      streamElementsSettings: model.streamElementsSettings,
      rtIrlPushKey: model.rtIrlPushKey,
      ttsSettings: model.ttsSettings,
    );
  }

  _i5.ChannelDTO _map__i4$Channel_To__i5$ChannelDTO(_i4.Channel? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Channel → ChannelDTO failed because Channel was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Channel, ChannelDTO> to handle null values during mapping.');
    }
    return _i5.ChannelDTO(
      platform: model.platform,
      channel: model.channel,
      enabled: model.enabled,
    );
  }

  _i5.ChatGroupDTO _map__i4$ChatGroup_To__i5$ChatGroupDTO(
      _i4.ChatGroup? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatGroup → ChatGroupDTO failed because ChatGroup was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatGroup, ChatGroupDTO> to handle null values during mapping.');
    }
    return _i5.ChatGroupDTO(
      id: model.id,
      channels: model.channels,
    );
  }

  _i7.BrowserTabDTO _map__i6$BrowserTab_To__i7$BrowserTabDTO(
      _i6.BrowserTab? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping BrowserTab → BrowserTabDTO failed because BrowserTab was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<BrowserTab, BrowserTabDTO> to handle null values during mapping.');
    }
    return _i7.BrowserTabDTO(
      id: model.id,
      title: model.title,
      url: model.url,
      toggled: model.toggled,
      iOSAudioSource: model.iOSAudioSource,
    );
  }

  _i5.ChatSettingsDTO _map__i4$ChatSettings_To__i5$ChatSettingsDTO(
      _i4.ChatSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatSettings → ChatSettingsDTO failed because ChatSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatSettings, ChatSettingsDTO> to handle null values during mapping.');
    }
    return _i5.ChatSettingsDTO(
      permanentFirstGroup: model.permanentFirstGroup,
      chatGroups: model.chatGroups,
      hideDeletedMessages: model.hideDeletedMessages,
    );
  }

  _i9.GeneralSettingsDTO _map__i8$GeneralSettings_To__i9$GeneralSettingsDTO(
      _i8.GeneralSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping GeneralSettings → GeneralSettingsDTO failed because GeneralSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<GeneralSettings, GeneralSettingsDTO> to handle null values during mapping.');
    }
    return _i9.GeneralSettingsDTO(
      isDarkMode: model.isDarkMode,
      keepSpeakerOn: model.keepSpeakerOn,
      displayViewerCount: model.displayViewerCount,
      appLanguage: model.appLanguage,
      splitViewWeights: model.splitViewWeights,
    );
  }

  _i11.DashboardEventDTO _map__i10$DashboardEvent_To__i11$DashboardEventDTO(
      _i10.DashboardEvent? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping DashboardEvent → DashboardEventDTO failed because DashboardEvent was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<DashboardEvent, DashboardEventDTO> to handle null values during mapping.');
    }
    return _i11.DashboardEventDTO(
      title: model.title,
      color: model.color,
      dashboardActionsType: model.dashboardActionsType,
      event: model.event,
      customValue: model.customValue,
    );
  }

  _i7.BrowserTabSettingsDTO
      _map__i6$BrowserTabSettings_To__i7$BrowserTabSettingsDTO(
          _i6.BrowserTabSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping BrowserTabSettings → BrowserTabSettingsDTO failed because BrowserTabSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<BrowserTabSettings, BrowserTabSettingsDTO> to handle null values during mapping.');
    }
    return _i7.BrowserTabSettingsDTO(tabs: model.tabs);
  }

  _i13.StreamElementsSettingsDTO
      _map__i12$StreamElementsSettings_To__i13$StreamElementsSettingsDTO(
          _i12.StreamElementsSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping StreamElementsSettings → StreamElementsSettingsDTO failed because StreamElementsSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<StreamElementsSettings, StreamElementsSettingsDTO> to handle null values during mapping.');
    }
    return _i13.StreamElementsSettingsDTO(
      showFollowerActivity: model.showFollowerActivity,
      showSubscriberActivity: model.showSubscriberActivity,
      showDonationActivity: model.showDonationActivity,
      showCheerActivity: model.showCheerActivity,
      showRaidActivity: model.showRaidActivity,
      showHostActivity: model.showHostActivity,
      showMerchActivity: model.showMerchActivity,
      jwt: model.jwt,
      overlayToken: model.overlayToken,
      mutedOverlays: model.mutedOverlays,
    );
  }

  _i15.TtsSettingsDTO _map__i14$TtsSettings_To__i15$TtsSettingsDTO(
      _i14.TtsSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TtsSettings → TtsSettingsDTO failed because TtsSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TtsSettings, TtsSettingsDTO> to handle null values during mapping.');
    }
    return _i15.TtsSettingsDTO(
      ttsEnabled: model.ttsEnabled,
      language: model.language,
      prefixsToIgnore: model.prefixsToIgnore,
      prefixsToUseTtsOnly: model.prefixsToUseTtsOnly,
      volume: model.volume,
      pitch: model.pitch,
      rate: model.rate,
      voice: model.voice,
      ttsUsersToIgnore: model.ttsUsersToIgnore,
      ttsMuteViewerName: model.ttsMuteViewerName,
      ttsOnlyVip: model.ttsOnlyVip,
      ttsOnlyMod: model.ttsOnlyMod,
      ttsOnlySubscriber: model.ttsOnlySubscriber,
    );
  }

  _i17.ChatEventsSettingsDTO
      _map__i16$ChatEventsSettings_To__i17$ChatEventsSettingsDTO(
          _i16.ChatEventsSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatEventsSettings → ChatEventsSettingsDTO failed because ChatEventsSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatEventsSettings, ChatEventsSettingsDTO> to handle null values during mapping.');
    }
    return _i17.ChatEventsSettingsDTO(
      firstsMessages: model.firstsMessages,
      subscriptions: model.subscriptions,
      bitsDonations: model.bitsDonations,
      announcements: model.announcements,
      incomingRaids: model.incomingRaids,
      redemptions: model.redemptions,
    );
  }

  _i19.TwitchCredentialsDTO
      _map__i18$TwitchCredentials_To__i19$TwitchCredentialsDTO(
          _i18.TwitchCredentials? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchCredentials → TwitchCredentialsDTO failed because TwitchCredentials was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchCredentials, TwitchCredentialsDTO> to handle null values during mapping.');
    }
    return _i19.TwitchCredentialsDTO(
      accessToken: model.accessToken,
      idToken: model.idToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      decodedIdToken: model.decodedIdToken,
      twitchUser: model.twitchUser,
      scopes: model.scopes,
    );
  }

  _i21.TwitchDecodedIdTokenDTO
      _map__i20$TwitchDecodedIdToken_To__i21$TwitchDecodedIdTokenDTO(
          _i20.TwitchDecodedIdToken? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchDecodedIdToken → TwitchDecodedIdTokenDTO failed because TwitchDecodedIdToken was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchDecodedIdToken, TwitchDecodedIdTokenDTO> to handle null values during mapping.');
    }
    return _i21.TwitchDecodedIdTokenDTO(
      preferredUsername: model.preferredUsername,
      profilePicture: model.profilePicture,
    );
  }

  _i23.TwitchUserDTO _map__i22$TwitchUser_To__i23$TwitchUserDTO(
      _i22.TwitchUser? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchUser → TwitchUserDTO failed because TwitchUser was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchUser, TwitchUserDTO> to handle null values during mapping.');
    }
    return _i23.TwitchUserDTO(
      id: model.id,
      login: model.login,
      displayName: model.displayName,
      broadcasterType: model.broadcasterType,
      description: model.description,
      profileImageUrl: model.profileImageUrl,
      viewCount: model.viewCount,
    );
  }

  _i25.DashboardSettingsDTO
      _map__i24$DashboardSettings_To__i25$DashboardSettingsDTO(
          _i24.DashboardSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping DashboardSettings → DashboardSettingsDTO failed because DashboardSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<DashboardSettings, DashboardSettingsDTO> to handle null values during mapping.');
    }
    return _i25.DashboardSettingsDTO(
      userEvents: model.userEvents,
      activated: model.activated,
    );
  }
}
