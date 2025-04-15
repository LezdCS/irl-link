// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint, unnecessary_cast, unused_local_variable

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;

import '../../data/entities/dashboard_event_dto.dart' as _i11;
import '../../data/entities/kick/kick_credentials_dto.dart' as _i45;
import '../../data/entities/kick/kick_user_dto.dart' as _i43;
import '../../data/entities/settings/browser_tab_settings_dto.dart' as _i7;
import '../../data/entities/settings/chat_events_settings_dto.dart' as _i17;
import '../../data/entities/settings/chat_settings_dto.dart' as _i5;
import '../../data/entities/settings/dashboard_settings_dto.dart' as _i25;
import '../../data/entities/settings/general_settings_dto.dart' as _i9;
import '../../data/entities/settings/stream_elements_settings_dto.dart' as _i13;
import '../../data/entities/settings/tts_settings_dto.dart' as _i15;
import '../../data/entities/settings_dto.dart' as _i3;
import '../../data/entities/stream_elements/se_activity_dto.dart' as _i30;
import '../../data/entities/stream_elements/se_credentials_dto.dart' as _i32;
import '../../data/entities/stream_elements/se_me_dto.dart' as _i34;
import '../../data/entities/stream_elements/se_overlay_dto.dart' as _i36;
import '../../data/entities/twitch/twitch_credentials_dto.dart' as _i19;
import '../../data/entities/twitch/twitch_decoded_idtoken_dto.dart' as _i21;
import '../../data/entities/twitch/twitch_hype_train_dto.dart' as _i40;
import '../../data/entities/twitch/twitch_poll_dto.dart' as _i27;
import '../../data/entities/twitch/twitch_prediction_dto.dart' as _i28;
import '../../data/entities/twitch/twitch_stream_infos_dto.dart' as _i38;
import '../../data/entities/twitch/twitch_user_dto.dart' as _i23;
import '../../domain/entities/dashboard_event.dart' as _i10;
import '../../domain/entities/kick/kick_credentials.dart' as _i44;
import '../../domain/entities/kick/kick_user.dart' as _i42;
import '../../domain/entities/settings.dart' as _i2;
import '../../domain/entities/settings/browser_tab_settings.dart' as _i6;
import '../../domain/entities/settings/chat_events_settings.dart' as _i16;
import '../../domain/entities/settings/chat_settings.dart' as _i4;
import '../../domain/entities/settings/dashboard_settings.dart' as _i24;
import '../../domain/entities/settings/general_settings.dart' as _i8;
import '../../domain/entities/settings/stream_elements_settings.dart' as _i12;
import '../../domain/entities/settings/tts_settings.dart' as _i14;
import '../../domain/entities/stream_elements/se_activity.dart' as _i31;
import '../../domain/entities/stream_elements/se_credentials.dart' as _i33;
import '../../domain/entities/stream_elements/se_me.dart' as _i35;
import '../../domain/entities/stream_elements/se_overlay.dart' as _i37;
import '../../domain/entities/twitch/twitch_credentials.dart' as _i18;
import '../../domain/entities/twitch/twitch_decoded_idtoken.dart' as _i20;
import '../../domain/entities/twitch/twitch_hype_train.dart' as _i41;
import '../../domain/entities/twitch/twitch_poll.dart' as _i26;
import '../../domain/entities/twitch/twitch_prediction.dart' as _i29;
import '../../domain/entities/twitch/twitch_stream_infos.dart' as _i39;
import '../../domain/entities/twitch/twitch_user.dart' as _i22;

/// {@template package:irllink/src/core/utils/mapper.dart}
/// Available mappings:
/// - `Settings` → `SettingsDTO`.
/// - `SettingsDTO` → `Settings`.
/// - `Channel` → `ChannelDTO`.
/// - `ChannelDTO` → `Channel`.
/// - `ChatGroup` → `ChatGroupDTO`.
/// - `ChatGroupDTO` → `ChatGroup`.
/// - `BrowserTab` → `BrowserTabDTO`.
/// - `BrowserTabDTO` → `BrowserTab`.
/// - `ChatSettings` → `ChatSettingsDTO`.
/// - `ChatSettingsDTO` → `ChatSettings`.
/// - `GeneralSettings` → `GeneralSettingsDTO`.
/// - `GeneralSettingsDTO` → `GeneralSettings`.
/// - `DashboardEvent` → `DashboardEventDTO`.
/// - `DashboardEventDTO` → `DashboardEvent`.
/// - `BrowserTabSettings` → `BrowserTabSettingsDTO`.
/// - `BrowserTabSettingsDTO` → `BrowserTabSettings`.
/// - `StreamElementsSettings` → `StreamElementsSettingsDTO`.
/// - `StreamElementsSettingsDTO` → `StreamElementsSettings`.
/// - `TtsSettings` → `TtsSettingsDTO`.
/// - `TtsSettingsDTO` → `TtsSettings`.
/// - `ChatEventsSettings` → `ChatEventsSettingsDTO`.
/// - `ChatEventsSettingsDTO` → `ChatEventsSettings`.
/// - `TwitchCredentials` → `TwitchCredentialsDTO`.
/// - `TwitchCredentialsDTO` → `TwitchCredentials`.
/// - `TwitchDecodedIdToken` → `TwitchDecodedIdTokenDTO`.
/// - `TwitchDecodedIdTokenDTO` → `TwitchDecodedIdToken`.
/// - `TwitchUser` → `TwitchUserDTO`.
/// - `TwitchUserDTO` → `TwitchUser`.
/// - `DashboardSettings` → `DashboardSettingsDTO`.
/// - `DashboardSettingsDTO` → `DashboardSettings`.
/// - `TwitchPoll` → `TwitchPollDTO`.
/// - `TwitchPollDTO` → `TwitchPoll`.
/// - `Choice` → `ChoiceDTO`.
/// - `ChoiceDTO` → `Choice`.
/// - `OutcomeDTO` → `Outcome`.
/// - `TwitchPredictionDTO` → `TwitchPrediction`.
/// - `SeActivityDTO` → `SeActivity`.
/// - `SeCredentialsDTO` → `SeCredentials`.
/// - `SeCredentials` → `SeCredentialsDTO`.
/// - `SeMeDTO` → `SeMe`.
/// - `SeOverlayDTO` → `SeOverlay`.
/// - `TwitchStreamInfosDto` → `TwitchStreamInfos`.
/// - `TwitchHypeTrainDTO` → `TwitchHypeTrain`.
/// - `Contribution` → `ContributionDTO`.
/// - `ContributionDTO` → `Contribution`.
/// - `KickUser` → `KickUserDTO`.
/// - `KickUserDTO` → `KickUser`.
/// - `KickCredentials` → `KickCredentialsDTO`.
/// - `KickCredentialsDTO` → `KickCredentials`.
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
    if ((sourceTypeOf == _typeOf<_i3.SettingsDTO>() ||
            sourceTypeOf == _typeOf<_i3.SettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i2.Settings>() ||
            targetTypeOf == _typeOf<_i2.Settings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.Channel>() ||
            sourceTypeOf == _typeOf<_i4.Channel?>()) &&
        (targetTypeOf == _typeOf<_i5.ChannelDTO>() ||
            targetTypeOf == _typeOf<_i5.ChannelDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i5.ChannelDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChannelDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.Channel>() ||
            targetTypeOf == _typeOf<_i4.Channel?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatGroup>() ||
            sourceTypeOf == _typeOf<_i4.ChatGroup?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatGroupDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatGroupDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i5.ChatGroupDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChatGroupDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.ChatGroup>() ||
            targetTypeOf == _typeOf<_i4.ChatGroup?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTab>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTab?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i7.BrowserTabDTO>() ||
            sourceTypeOf == _typeOf<_i7.BrowserTabDTO?>()) &&
        (targetTypeOf == _typeOf<_i6.BrowserTab>() ||
            targetTypeOf == _typeOf<_i6.BrowserTab?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i4.ChatSettings>() ||
            sourceTypeOf == _typeOf<_i4.ChatSettings?>()) &&
        (targetTypeOf == _typeOf<_i5.ChatSettingsDTO>() ||
            targetTypeOf == _typeOf<_i5.ChatSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i5.ChatSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChatSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.ChatSettings>() ||
            targetTypeOf == _typeOf<_i4.ChatSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i8.GeneralSettings>() ||
            sourceTypeOf == _typeOf<_i8.GeneralSettings?>()) &&
        (targetTypeOf == _typeOf<_i9.GeneralSettingsDTO>() ||
            targetTypeOf == _typeOf<_i9.GeneralSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i9.GeneralSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i9.GeneralSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i8.GeneralSettings>() ||
            targetTypeOf == _typeOf<_i8.GeneralSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i10.DashboardEvent>() ||
            sourceTypeOf == _typeOf<_i10.DashboardEvent?>()) &&
        (targetTypeOf == _typeOf<_i11.DashboardEventDTO>() ||
            targetTypeOf == _typeOf<_i11.DashboardEventDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i11.DashboardEventDTO>() ||
            sourceTypeOf == _typeOf<_i11.DashboardEventDTO?>()) &&
        (targetTypeOf == _typeOf<_i10.DashboardEvent>() ||
            targetTypeOf == _typeOf<_i10.DashboardEvent?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i6.BrowserTabSettings>() ||
            sourceTypeOf == _typeOf<_i6.BrowserTabSettings?>()) &&
        (targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO>() ||
            targetTypeOf == _typeOf<_i7.BrowserTabSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i7.BrowserTabSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i7.BrowserTabSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i6.BrowserTabSettings>() ||
            targetTypeOf == _typeOf<_i6.BrowserTabSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i12.StreamElementsSettings>() ||
            sourceTypeOf == _typeOf<_i12.StreamElementsSettings?>()) &&
        (targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i13.StreamElementsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i13.StreamElementsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i13.StreamElementsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i12.StreamElementsSettings>() ||
            targetTypeOf == _typeOf<_i12.StreamElementsSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i14.TtsSettings>() ||
            sourceTypeOf == _typeOf<_i14.TtsSettings?>()) &&
        (targetTypeOf == _typeOf<_i15.TtsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i15.TtsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i15.TtsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i15.TtsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i14.TtsSettings>() ||
            targetTypeOf == _typeOf<_i14.TtsSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i16.ChatEventsSettings>() ||
            sourceTypeOf == _typeOf<_i16.ChatEventsSettings?>()) &&
        (targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i17.ChatEventsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i17.ChatEventsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i17.ChatEventsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i16.ChatEventsSettings>() ||
            targetTypeOf == _typeOf<_i16.ChatEventsSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i18.TwitchCredentials>() ||
            sourceTypeOf == _typeOf<_i18.TwitchCredentials?>()) &&
        (targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i19.TwitchCredentialsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i19.TwitchCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i19.TwitchCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i18.TwitchCredentials>() ||
            targetTypeOf == _typeOf<_i18.TwitchCredentials?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken>() ||
            sourceTypeOf == _typeOf<_i20.TwitchDecodedIdToken?>()) &&
        (targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO>() ||
            targetTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO>() ||
            sourceTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO?>()) &&
        (targetTypeOf == _typeOf<_i20.TwitchDecodedIdToken>() ||
            targetTypeOf == _typeOf<_i20.TwitchDecodedIdToken?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i22.TwitchUser>() ||
            sourceTypeOf == _typeOf<_i22.TwitchUser?>()) &&
        (targetTypeOf == _typeOf<_i23.TwitchUserDTO>() ||
            targetTypeOf == _typeOf<_i23.TwitchUserDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i23.TwitchUserDTO>() ||
            sourceTypeOf == _typeOf<_i23.TwitchUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i22.TwitchUser>() ||
            targetTypeOf == _typeOf<_i22.TwitchUser?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i24.DashboardSettings>() ||
            sourceTypeOf == _typeOf<_i24.DashboardSettings?>()) &&
        (targetTypeOf == _typeOf<_i25.DashboardSettingsDTO>() ||
            targetTypeOf == _typeOf<_i25.DashboardSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i25.DashboardSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i25.DashboardSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.DashboardSettings>() ||
            targetTypeOf == _typeOf<_i24.DashboardSettings?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i26.TwitchPoll>() ||
            sourceTypeOf == _typeOf<_i26.TwitchPoll?>()) &&
        (targetTypeOf == _typeOf<_i27.TwitchPollDTO>() ||
            targetTypeOf == _typeOf<_i27.TwitchPollDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i27.TwitchPollDTO>() ||
            sourceTypeOf == _typeOf<_i27.TwitchPollDTO?>()) &&
        (targetTypeOf == _typeOf<_i26.TwitchPoll>() ||
            targetTypeOf == _typeOf<_i26.TwitchPoll?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i26.Choice>() ||
            sourceTypeOf == _typeOf<_i26.Choice?>()) &&
        (targetTypeOf == _typeOf<_i27.ChoiceDTO>() ||
            targetTypeOf == _typeOf<_i27.ChoiceDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i27.ChoiceDTO>() ||
            sourceTypeOf == _typeOf<_i27.ChoiceDTO?>()) &&
        (targetTypeOf == _typeOf<_i26.Choice>() ||
            targetTypeOf == _typeOf<_i26.Choice?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i28.OutcomeDTO>() ||
            sourceTypeOf == _typeOf<_i28.OutcomeDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.Outcome>() ||
            targetTypeOf == _typeOf<_i29.Outcome?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i28.TwitchPredictionDTO>() ||
            sourceTypeOf == _typeOf<_i28.TwitchPredictionDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.TwitchPrediction>() ||
            targetTypeOf == _typeOf<_i29.TwitchPrediction?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i30.SeActivityDTO>() ||
            sourceTypeOf == _typeOf<_i30.SeActivityDTO?>()) &&
        (targetTypeOf == _typeOf<_i31.SeActivity>() ||
            targetTypeOf == _typeOf<_i31.SeActivity?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i32.SeCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i32.SeCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i33.SeCredentials>() ||
            targetTypeOf == _typeOf<_i33.SeCredentials?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i33.SeCredentials>() ||
            sourceTypeOf == _typeOf<_i33.SeCredentials?>()) &&
        (targetTypeOf == _typeOf<_i32.SeCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i32.SeCredentialsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i34.SeMeDTO>() ||
            sourceTypeOf == _typeOf<_i34.SeMeDTO?>()) &&
        (targetTypeOf == _typeOf<_i35.SeMe>() ||
            targetTypeOf == _typeOf<_i35.SeMe?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i36.SeOverlayDTO>() ||
            sourceTypeOf == _typeOf<_i36.SeOverlayDTO?>()) &&
        (targetTypeOf == _typeOf<_i37.SeOverlay>() ||
            targetTypeOf == _typeOf<_i37.SeOverlay?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i38.TwitchStreamInfosDto>() ||
            sourceTypeOf == _typeOf<_i38.TwitchStreamInfosDto?>()) &&
        (targetTypeOf == _typeOf<_i39.TwitchStreamInfos>() ||
            targetTypeOf == _typeOf<_i39.TwitchStreamInfos?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i40.TwitchHypeTrainDTO>() ||
            sourceTypeOf == _typeOf<_i40.TwitchHypeTrainDTO?>()) &&
        (targetTypeOf == _typeOf<_i41.TwitchHypeTrain>() ||
            targetTypeOf == _typeOf<_i41.TwitchHypeTrain?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i41.Contribution>() ||
            sourceTypeOf == _typeOf<_i41.Contribution?>()) &&
        (targetTypeOf == _typeOf<_i40.ContributionDTO>() ||
            targetTypeOf == _typeOf<_i40.ContributionDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i40.ContributionDTO>() ||
            sourceTypeOf == _typeOf<_i40.ContributionDTO?>()) &&
        (targetTypeOf == _typeOf<_i41.Contribution>() ||
            targetTypeOf == _typeOf<_i41.Contribution?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i42.KickUser>() ||
            sourceTypeOf == _typeOf<_i42.KickUser?>()) &&
        (targetTypeOf == _typeOf<_i43.KickUserDTO>() ||
            targetTypeOf == _typeOf<_i43.KickUserDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i43.KickUserDTO>() ||
            sourceTypeOf == _typeOf<_i43.KickUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i42.KickUser>() ||
            targetTypeOf == _typeOf<_i42.KickUser?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i44.KickCredentials>() ||
            sourceTypeOf == _typeOf<_i44.KickCredentials?>()) &&
        (targetTypeOf == _typeOf<_i45.KickCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i45.KickCredentialsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i45.KickCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i45.KickCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i44.KickCredentials>() ||
            targetTypeOf == _typeOf<_i44.KickCredentials?>())) {
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
    if ((sourceTypeOf == _typeOf<_i3.SettingsDTO>() ||
            sourceTypeOf == _typeOf<_i3.SettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i2.Settings>() ||
            targetTypeOf == _typeOf<_i2.Settings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i3$SettingsDTO_To__i2$Settings((model as _i3.SettingsDTO?))
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
    if ((sourceTypeOf == _typeOf<_i5.ChannelDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChannelDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.Channel>() ||
            targetTypeOf == _typeOf<_i4.Channel?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i5$ChannelDTO_To__i4$Channel((model as _i5.ChannelDTO?))
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
    if ((sourceTypeOf == _typeOf<_i5.ChatGroupDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChatGroupDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.ChatGroup>() ||
            targetTypeOf == _typeOf<_i4.ChatGroup?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i5$ChatGroupDTO_To__i4$ChatGroup(
          (model as _i5.ChatGroupDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i7.BrowserTabDTO>() ||
            sourceTypeOf == _typeOf<_i7.BrowserTabDTO?>()) &&
        (targetTypeOf == _typeOf<_i6.BrowserTab>() ||
            targetTypeOf == _typeOf<_i6.BrowserTab?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i7$BrowserTabDTO_To__i6$BrowserTab(
          (model as _i7.BrowserTabDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i5.ChatSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i5.ChatSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i4.ChatSettings>() ||
            targetTypeOf == _typeOf<_i4.ChatSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i5$ChatSettingsDTO_To__i4$ChatSettings(
          (model as _i5.ChatSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i9.GeneralSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i9.GeneralSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i8.GeneralSettings>() ||
            targetTypeOf == _typeOf<_i8.GeneralSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i9$GeneralSettingsDTO_To__i8$GeneralSettings(
          (model as _i9.GeneralSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i11.DashboardEventDTO>() ||
            sourceTypeOf == _typeOf<_i11.DashboardEventDTO?>()) &&
        (targetTypeOf == _typeOf<_i10.DashboardEvent>() ||
            targetTypeOf == _typeOf<_i10.DashboardEvent?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i11$DashboardEventDTO_To__i10$DashboardEvent(
          (model as _i11.DashboardEventDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i7.BrowserTabSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i7.BrowserTabSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i6.BrowserTabSettings>() ||
            targetTypeOf == _typeOf<_i6.BrowserTabSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i7$BrowserTabSettingsDTO_To__i6$BrowserTabSettings(
          (model as _i7.BrowserTabSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i13.StreamElementsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i13.StreamElementsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i12.StreamElementsSettings>() ||
            targetTypeOf == _typeOf<_i12.StreamElementsSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i13$StreamElementsSettingsDTO_To__i12$StreamElementsSettings(
          (model as _i13.StreamElementsSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i15.TtsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i15.TtsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i14.TtsSettings>() ||
            targetTypeOf == _typeOf<_i14.TtsSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i15$TtsSettingsDTO_To__i14$TtsSettings(
          (model as _i15.TtsSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i17.ChatEventsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i17.ChatEventsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i16.ChatEventsSettings>() ||
            targetTypeOf == _typeOf<_i16.ChatEventsSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i17$ChatEventsSettingsDTO_To__i16$ChatEventsSettings(
          (model as _i17.ChatEventsSettingsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i19.TwitchCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i19.TwitchCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i18.TwitchCredentials>() ||
            targetTypeOf == _typeOf<_i18.TwitchCredentials?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i19$TwitchCredentialsDTO_To__i18$TwitchCredentials(
          (model as _i19.TwitchCredentialsDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO>() ||
            sourceTypeOf == _typeOf<_i21.TwitchDecodedIdTokenDTO?>()) &&
        (targetTypeOf == _typeOf<_i20.TwitchDecodedIdToken>() ||
            targetTypeOf == _typeOf<_i20.TwitchDecodedIdToken?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i21$TwitchDecodedIdTokenDTO_To__i20$TwitchDecodedIdToken(
          (model as _i21.TwitchDecodedIdTokenDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i23.TwitchUserDTO>() ||
            sourceTypeOf == _typeOf<_i23.TwitchUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i22.TwitchUser>() ||
            targetTypeOf == _typeOf<_i22.TwitchUser?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i23$TwitchUserDTO_To__i22$TwitchUser(
          (model as _i23.TwitchUserDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i25.DashboardSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i25.DashboardSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.DashboardSettings>() ||
            targetTypeOf == _typeOf<_i24.DashboardSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i25$DashboardSettingsDTO_To__i24$DashboardSettings(
          (model as _i25.DashboardSettingsDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i26.TwitchPoll>() ||
            sourceTypeOf == _typeOf<_i26.TwitchPoll?>()) &&
        (targetTypeOf == _typeOf<_i27.TwitchPollDTO>() ||
            targetTypeOf == _typeOf<_i27.TwitchPollDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i26$TwitchPoll_To__i27$TwitchPollDTO(
          (model as _i26.TwitchPoll?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i27.TwitchPollDTO>() ||
            sourceTypeOf == _typeOf<_i27.TwitchPollDTO?>()) &&
        (targetTypeOf == _typeOf<_i26.TwitchPoll>() ||
            targetTypeOf == _typeOf<_i26.TwitchPoll?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i27$TwitchPollDTO_To__i26$TwitchPoll(
          (model as _i27.TwitchPollDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i26.Choice>() ||
            sourceTypeOf == _typeOf<_i26.Choice?>()) &&
        (targetTypeOf == _typeOf<_i27.ChoiceDTO>() ||
            targetTypeOf == _typeOf<_i27.ChoiceDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i26$Choice_To__i27$ChoiceDTO((model as _i26.Choice?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i27.ChoiceDTO>() ||
            sourceTypeOf == _typeOf<_i27.ChoiceDTO?>()) &&
        (targetTypeOf == _typeOf<_i26.Choice>() ||
            targetTypeOf == _typeOf<_i26.Choice?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i27$ChoiceDTO_To__i26$Choice((model as _i27.ChoiceDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i28.OutcomeDTO>() ||
            sourceTypeOf == _typeOf<_i28.OutcomeDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.Outcome>() ||
            targetTypeOf == _typeOf<_i29.Outcome?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i28$OutcomeDTO_To__i29$Outcome((model as _i28.OutcomeDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i28.TwitchPredictionDTO>() ||
            sourceTypeOf == _typeOf<_i28.TwitchPredictionDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.TwitchPrediction>() ||
            targetTypeOf == _typeOf<_i29.TwitchPrediction?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i28$TwitchPredictionDTO_To__i29$TwitchPrediction(
          (model as _i28.TwitchPredictionDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i30.SeActivityDTO>() ||
            sourceTypeOf == _typeOf<_i30.SeActivityDTO?>()) &&
        (targetTypeOf == _typeOf<_i31.SeActivity>() ||
            targetTypeOf == _typeOf<_i31.SeActivity?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i30$SeActivityDTO_To__i31$SeActivity(
          (model as _i30.SeActivityDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i32.SeCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i32.SeCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i33.SeCredentials>() ||
            targetTypeOf == _typeOf<_i33.SeCredentials?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i32$SeCredentialsDTO_To__i33$SeCredentials(
          (model as _i32.SeCredentialsDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i33.SeCredentials>() ||
            sourceTypeOf == _typeOf<_i33.SeCredentials?>()) &&
        (targetTypeOf == _typeOf<_i32.SeCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i32.SeCredentialsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i33$SeCredentials_To__i32$SeCredentialsDTO(
          (model as _i33.SeCredentials?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i34.SeMeDTO>() ||
            sourceTypeOf == _typeOf<_i34.SeMeDTO?>()) &&
        (targetTypeOf == _typeOf<_i35.SeMe>() ||
            targetTypeOf == _typeOf<_i35.SeMe?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i34$SeMeDTO_To__i35$SeMe((model as _i34.SeMeDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i36.SeOverlayDTO>() ||
            sourceTypeOf == _typeOf<_i36.SeOverlayDTO?>()) &&
        (targetTypeOf == _typeOf<_i37.SeOverlay>() ||
            targetTypeOf == _typeOf<_i37.SeOverlay?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i36$SeOverlayDTO_To__i37$SeOverlay(
          (model as _i36.SeOverlayDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i38.TwitchStreamInfosDto>() ||
            sourceTypeOf == _typeOf<_i38.TwitchStreamInfosDto?>()) &&
        (targetTypeOf == _typeOf<_i39.TwitchStreamInfos>() ||
            targetTypeOf == _typeOf<_i39.TwitchStreamInfos?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i38$TwitchStreamInfosDto_To__i39$TwitchStreamInfos(
          (model as _i38.TwitchStreamInfosDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i40.TwitchHypeTrainDTO>() ||
            sourceTypeOf == _typeOf<_i40.TwitchHypeTrainDTO?>()) &&
        (targetTypeOf == _typeOf<_i41.TwitchHypeTrain>() ||
            targetTypeOf == _typeOf<_i41.TwitchHypeTrain?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i40$TwitchHypeTrainDTO_To__i41$TwitchHypeTrain(
          (model as _i40.TwitchHypeTrainDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i41.Contribution>() ||
            sourceTypeOf == _typeOf<_i41.Contribution?>()) &&
        (targetTypeOf == _typeOf<_i40.ContributionDTO>() ||
            targetTypeOf == _typeOf<_i40.ContributionDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i41$Contribution_To__i40$ContributionDTO(
          (model as _i41.Contribution?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i40.ContributionDTO>() ||
            sourceTypeOf == _typeOf<_i40.ContributionDTO?>()) &&
        (targetTypeOf == _typeOf<_i41.Contribution>() ||
            targetTypeOf == _typeOf<_i41.Contribution?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i40$ContributionDTO_To__i41$Contribution(
          (model as _i40.ContributionDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i42.KickUser>() ||
            sourceTypeOf == _typeOf<_i42.KickUser?>()) &&
        (targetTypeOf == _typeOf<_i43.KickUserDTO>() ||
            targetTypeOf == _typeOf<_i43.KickUserDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i42$KickUser_To__i43$KickUserDTO((model as _i42.KickUser?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i43.KickUserDTO>() ||
            sourceTypeOf == _typeOf<_i43.KickUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i42.KickUser>() ||
            targetTypeOf == _typeOf<_i42.KickUser?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i43$KickUserDTO_To__i42$KickUser(
          (model as _i43.KickUserDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i44.KickCredentials>() ||
            sourceTypeOf == _typeOf<_i44.KickCredentials?>()) &&
        (targetTypeOf == _typeOf<_i45.KickCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i45.KickCredentialsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i44$KickCredentials_To__i45$KickCredentialsDTO(
          (model as _i44.KickCredentials?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i45.KickCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i45.KickCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i44.KickCredentials>() ||
            targetTypeOf == _typeOf<_i44.KickCredentials?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i45$KickCredentialsDTO_To__i44$KickCredentials(
          (model as _i45.KickCredentialsDTO?)) as TARGET);
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
      chatEventsSettings:
          _map__i16$ChatEventsSettings_To__i17$ChatEventsSettingsDTO(
              model.chatEventsSettings),
      chatSettings:
          _map__i4$ChatSettings_To__i5$ChatSettingsDTO(model.chatSettings),
      generalSettings: _map__i8$GeneralSettings_To__i9$GeneralSettingsDTO(
          model.generalSettings),
      dashboardSettings:
          _map__i24$DashboardSettings_To__i25$DashboardSettingsDTO(
              model.dashboardSettings),
      isObsConnected: model.isObsConnected,
      obsWebsocketUrl: model.obsWebsocketUrl,
      obsWebsocketPassword: model.obsWebsocketPassword,
      browserTabs: _map__i6$BrowserTabSettings_To__i7$BrowserTabSettingsDTO(
          model.browserTabs),
      obsConnectionsHistory: model.obsConnectionsHistory,
      streamElementsSettings:
          _map__i12$StreamElementsSettings_To__i13$StreamElementsSettingsDTO(
              model.streamElementsSettings),
      rtIrlPushKey: model.rtIrlPushKey,
      ttsSettings:
          _map__i14$TtsSettings_To__i15$TtsSettingsDTO(model.ttsSettings),
    );
  }

  _i2.Settings _map__i3$SettingsDTO_To__i2$Settings(_i3.SettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SettingsDTO → Settings failed because SettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SettingsDTO, Settings> to handle null values during mapping.');
    }
    return _i2.Settings(
      isEmotes: model.isEmotes,
      textSize: model.textSize,
      displayTimestamp: model.displayTimestamp,
      hiddenUsersIds: model.hiddenUsersIds,
      chatEventsSettings:
          _map__i17$ChatEventsSettingsDTO_To__i16$ChatEventsSettings(
              model.chatEventsSettings),
      chatSettings:
          _map__i5$ChatSettingsDTO_To__i4$ChatSettings(model.chatSettings),
      generalSettings: _map__i9$GeneralSettingsDTO_To__i8$GeneralSettings(
          model.generalSettings),
      dashboardSettings:
          _map__i25$DashboardSettingsDTO_To__i24$DashboardSettings(
              model.dashboardSettings),
      isObsConnected: model.isObsConnected,
      obsWebsocketUrl: model.obsWebsocketUrl,
      obsWebsocketPassword: model.obsWebsocketPassword,
      browserTabs: _map__i7$BrowserTabSettingsDTO_To__i6$BrowserTabSettings(
          model.browserTabs),
      obsConnectionsHistory: model.obsConnectionsHistory,
      streamElementsSettings:
          _map__i13$StreamElementsSettingsDTO_To__i12$StreamElementsSettings(
              model.streamElementsSettings),
      rtIrlPushKey: model.rtIrlPushKey,
      ttsSettings:
          _map__i15$TtsSettingsDTO_To__i14$TtsSettings(model.ttsSettings),
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

  _i4.Channel _map__i5$ChannelDTO_To__i4$Channel(_i5.ChannelDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChannelDTO → Channel failed because ChannelDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChannelDTO, Channel> to handle null values during mapping.');
    }
    return _i4.Channel(
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
      channels: model.channels
          .map<_i5.ChannelDTO>(
              (value) => _map__i4$Channel_To__i5$ChannelDTO(value))
          .toList(),
    );
  }

  _i4.ChatGroup _map__i5$ChatGroupDTO_To__i4$ChatGroup(
      _i5.ChatGroupDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatGroupDTO → ChatGroup failed because ChatGroupDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatGroupDTO, ChatGroup> to handle null values during mapping.');
    }
    return _i4.ChatGroup(
      id: model.id,
      channels: model.channels
          .map<_i4.Channel>(
              (value) => _map__i5$ChannelDTO_To__i4$Channel(value))
          .toList(),
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

  _i6.BrowserTab _map__i7$BrowserTabDTO_To__i6$BrowserTab(
      _i7.BrowserTabDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping BrowserTabDTO → BrowserTab failed because BrowserTabDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<BrowserTabDTO, BrowserTab> to handle null values during mapping.');
    }
    return _i6.BrowserTab(
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
      permanentFirstGroup:
          _map__i4$ChatGroup_To__i5$ChatGroupDTO(model.permanentFirstGroup),
      chatGroups: model.chatGroups
          .map<_i5.ChatGroupDTO>(
              (value) => _map__i4$ChatGroup_To__i5$ChatGroupDTO(value))
          .toList(),
      hideDeletedMessages: model.hideDeletedMessages,
    );
  }

  _i4.ChatSettings _map__i5$ChatSettingsDTO_To__i4$ChatSettings(
      _i5.ChatSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatSettingsDTO → ChatSettings failed because ChatSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatSettingsDTO, ChatSettings> to handle null values during mapping.');
    }
    return _i4.ChatSettings(
      permanentFirstGroup:
          _map__i5$ChatGroupDTO_To__i4$ChatGroup(model.permanentFirstGroup),
      chatGroups: model.chatGroups
          .map<_i4.ChatGroup>(
              (value) => _map__i5$ChatGroupDTO_To__i4$ChatGroup(value))
          .toList(),
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

  _i8.GeneralSettings _map__i9$GeneralSettingsDTO_To__i8$GeneralSettings(
      _i9.GeneralSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping GeneralSettingsDTO → GeneralSettings failed because GeneralSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<GeneralSettingsDTO, GeneralSettings> to handle null values during mapping.');
    }
    return _i8.GeneralSettings(
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

  _i10.DashboardEvent _map__i11$DashboardEventDTO_To__i10$DashboardEvent(
      _i11.DashboardEventDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping DashboardEventDTO → DashboardEvent failed because DashboardEventDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<DashboardEventDTO, DashboardEvent> to handle null values during mapping.');
    }
    return _i10.DashboardEvent(
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
    return _i7.BrowserTabSettingsDTO(
        tabs: model.tabs
            .map<_i7.BrowserTabDTO>(
                (value) => _map__i6$BrowserTab_To__i7$BrowserTabDTO(value))
            .toList());
  }

  _i6.BrowserTabSettings
      _map__i7$BrowserTabSettingsDTO_To__i6$BrowserTabSettings(
          _i7.BrowserTabSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping BrowserTabSettingsDTO → BrowserTabSettings failed because BrowserTabSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<BrowserTabSettingsDTO, BrowserTabSettings> to handle null values during mapping.');
    }
    return _i6.BrowserTabSettings(
        tabs: model.tabs
            .map<_i6.BrowserTab>(
                (value) => _map__i7$BrowserTabDTO_To__i6$BrowserTab(value))
            .toList());
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

  _i12.StreamElementsSettings
      _map__i13$StreamElementsSettingsDTO_To__i12$StreamElementsSettings(
          _i13.StreamElementsSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping StreamElementsSettingsDTO → StreamElementsSettings failed because StreamElementsSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<StreamElementsSettingsDTO, StreamElementsSettings> to handle null values during mapping.');
    }
    return _i12.StreamElementsSettings(
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

  _i14.TtsSettings _map__i15$TtsSettingsDTO_To__i14$TtsSettings(
      _i15.TtsSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TtsSettingsDTO → TtsSettings failed because TtsSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TtsSettingsDTO, TtsSettings> to handle null values during mapping.');
    }
    return _i14.TtsSettings(
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

  _i16.ChatEventsSettings
      _map__i17$ChatEventsSettingsDTO_To__i16$ChatEventsSettings(
          _i17.ChatEventsSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatEventsSettingsDTO → ChatEventsSettings failed because ChatEventsSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatEventsSettingsDTO, ChatEventsSettings> to handle null values during mapping.');
    }
    return _i16.ChatEventsSettings(
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
      decodedIdToken:
          _map__i20$TwitchDecodedIdToken_To__i21$TwitchDecodedIdTokenDTO(
              model.decodedIdToken),
      twitchUser: _map__i22$TwitchUser_To__i23$TwitchUserDTO(model.twitchUser),
      scopes: model.scopes,
    );
  }

  _i18.TwitchCredentials
      _map__i19$TwitchCredentialsDTO_To__i18$TwitchCredentials(
          _i19.TwitchCredentialsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchCredentialsDTO → TwitchCredentials failed because TwitchCredentialsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchCredentialsDTO, TwitchCredentials> to handle null values during mapping.');
    }
    return _i18.TwitchCredentials(
      accessToken: model.accessToken,
      idToken: model.idToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      decodedIdToken:
          _map__i21$TwitchDecodedIdTokenDTO_To__i20$TwitchDecodedIdToken(
              model.decodedIdToken),
      twitchUser: _map__i23$TwitchUserDTO_To__i22$TwitchUser(model.twitchUser),
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

  _i20.TwitchDecodedIdToken
      _map__i21$TwitchDecodedIdTokenDTO_To__i20$TwitchDecodedIdToken(
          _i21.TwitchDecodedIdTokenDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchDecodedIdTokenDTO → TwitchDecodedIdToken failed because TwitchDecodedIdTokenDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchDecodedIdTokenDTO, TwitchDecodedIdToken> to handle null values during mapping.');
    }
    return _i20.TwitchDecodedIdToken(
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

  _i22.TwitchUser _map__i23$TwitchUserDTO_To__i22$TwitchUser(
      _i23.TwitchUserDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchUserDTO → TwitchUser failed because TwitchUserDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchUserDTO, TwitchUser> to handle null values during mapping.');
    }
    return _i22.TwitchUser(
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
      userEvents: model.userEvents
          .map<_i11.DashboardEventDTO>((value) =>
              _map__i10$DashboardEvent_To__i11$DashboardEventDTO(value))
          .toList(),
      activated: model.activated,
    );
  }

  _i24.DashboardSettings
      _map__i25$DashboardSettingsDTO_To__i24$DashboardSettings(
          _i25.DashboardSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping DashboardSettingsDTO → DashboardSettings failed because DashboardSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<DashboardSettingsDTO, DashboardSettings> to handle null values during mapping.');
    }
    return _i24.DashboardSettings(
      userEvents: model.userEvents
          .map<_i10.DashboardEvent>((value) =>
              _map__i11$DashboardEventDTO_To__i10$DashboardEvent(value))
          .toList(),
      activated: model.activated,
    );
  }

  _i27.TwitchPollDTO _map__i26$TwitchPoll_To__i27$TwitchPollDTO(
      _i26.TwitchPoll? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPoll → TwitchPollDTO failed because TwitchPoll was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPoll, TwitchPollDTO> to handle null values during mapping.');
    }
    return _i27.TwitchPollDTO(
      id: model.id,
      title: model.title,
      choices: model.choices
          .map<_i27.ChoiceDTO>(
              (value) => _map__i26$Choice_To__i27$ChoiceDTO(value))
          .toList(),
      totalVotes: model.totalVotes,
      status: model.status,
      endsAt: model.endsAt,
    );
  }

  _i26.TwitchPoll _map__i27$TwitchPollDTO_To__i26$TwitchPoll(
      _i27.TwitchPollDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPollDTO → TwitchPoll failed because TwitchPollDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPollDTO, TwitchPoll> to handle null values during mapping.');
    }
    return _i26.TwitchPoll(
      id: model.id,
      title: model.title,
      choices: model.choices
          .map<_i26.Choice>(
              (value) => _map__i27$ChoiceDTO_To__i26$Choice(value))
          .toList(),
      totalVotes: model.totalVotes,
      status: model.status,
      endsAt: model.endsAt,
    );
  }

  _i27.ChoiceDTO _map__i26$Choice_To__i27$ChoiceDTO(_i26.Choice? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Choice → ChoiceDTO failed because Choice was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Choice, ChoiceDTO> to handle null values during mapping.');
    }
    return _i27.ChoiceDTO(
      id: model.id,
      title: model.title,
      votes: model.votes,
    );
  }

  _i26.Choice _map__i27$ChoiceDTO_To__i26$Choice(_i27.ChoiceDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChoiceDTO → Choice failed because ChoiceDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChoiceDTO, Choice> to handle null values during mapping.');
    }
    return _i26.Choice(
      id: model.id,
      title: model.title,
      votes: model.votes,
    );
  }

  _i29.Outcome _map__i28$OutcomeDTO_To__i29$Outcome(_i28.OutcomeDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping OutcomeDTO → Outcome failed because OutcomeDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<OutcomeDTO, Outcome> to handle null values during mapping.');
    }
    return _i29.Outcome(
      id: model.id,
      title: model.title,
      users: model.users,
      channelPoints: model.channelPoints,
      color: model.color,
    );
  }

  _i29.TwitchPrediction _map__i28$TwitchPredictionDTO_To__i29$TwitchPrediction(
      _i28.TwitchPredictionDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPredictionDTO → TwitchPrediction failed because TwitchPredictionDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPredictionDTO, TwitchPrediction> to handle null values during mapping.');
    }
    return _i29.TwitchPrediction(
      id: model.id,
      title: model.title,
      winningOutcomeId: model.winningOutcomeId,
      totalUsers: model.totalUsers,
      outcomes: model.outcomes
          .map<_i29.Outcome>(
              (value) => _map__i28$OutcomeDTO_To__i29$Outcome(value))
          .toList(),
      status: model.status,
      remainingTime: model.remainingTime,
    );
  }

  _i31.SeActivity _map__i30$SeActivityDTO_To__i31$SeActivity(
      _i30.SeActivityDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeActivityDTO → SeActivity failed because SeActivityDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeActivityDTO, SeActivity> to handle null values during mapping.');
    }
    return _i31.SeActivity(
      id: model.id,
      channel: model.channel,
      username: model.username,
      activityType: model.activityType,
      provider: model.provider,
      message: model.message,
      amount: model.amount,
      tier: model.tier,
      gifted: model.gifted,
      sender: model.sender,
      currency: model.currency,
      isTest: model.isTest,
    );
  }

  _i33.SeCredentials _map__i32$SeCredentialsDTO_To__i33$SeCredentials(
      _i32.SeCredentialsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeCredentialsDTO → SeCredentials failed because SeCredentialsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeCredentialsDTO, SeCredentials> to handle null values during mapping.');
    }
    return _i33.SeCredentials(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      scopes: model.scopes,
    );
  }

  _i32.SeCredentialsDTO _map__i33$SeCredentials_To__i32$SeCredentialsDTO(
      _i33.SeCredentials? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeCredentials → SeCredentialsDTO failed because SeCredentials was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeCredentials, SeCredentialsDTO> to handle null values during mapping.');
    }
    return _i32.SeCredentialsDTO(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      scopes: model.scopes,
    );
  }

  _i35.SeMe _map__i34$SeMeDTO_To__i35$SeMe(_i34.SeMeDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeMeDTO → SeMe failed because SeMeDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeMeDTO, SeMe> to handle null values during mapping.');
    }
    return _i35.SeMe(
      id: model.id,
      avatar: model.avatar,
      username: model.username,
      displayName: model.displayName,
    );
  }

  _i37.SeOverlay _map__i36$SeOverlayDTO_To__i37$SeOverlay(
      _i36.SeOverlayDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeOverlayDTO → SeOverlay failed because SeOverlayDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeOverlayDTO, SeOverlay> to handle null values during mapping.');
    }
    return _i37.SeOverlay(
      id: model.id,
      name: model.name,
    );
  }

  _i39.TwitchStreamInfos
      _map__i38$TwitchStreamInfosDto_To__i39$TwitchStreamInfos(
          _i38.TwitchStreamInfosDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchStreamInfosDto → TwitchStreamInfos failed because TwitchStreamInfosDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchStreamInfosDto, TwitchStreamInfos> to handle null values during mapping.');
    }
    return _i39.TwitchStreamInfos(
      title: model.title,
      viewerCount: model.viewerCount,
      isOnline: model.isOnline,
      startedAtDuration: model.startedAtDuration,
      isEmoteMode: model.isEmoteMode,
      isFollowerMode: model.isFollowerMode,
      isSlowMode: model.isSlowMode,
      slowModeWaitTime: model.slowModeWaitTime,
      isSubscriberMode: model.isSubscriberMode,
    );
  }

  _i41.TwitchHypeTrain _map__i40$TwitchHypeTrainDTO_To__i41$TwitchHypeTrain(
      _i40.TwitchHypeTrainDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchHypeTrainDTO → TwitchHypeTrain failed because TwitchHypeTrainDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchHypeTrainDTO, TwitchHypeTrain> to handle null values during mapping.');
    }
    return _i41.TwitchHypeTrain(
      id: model.id,
      total: model.total,
      progress: model.progress,
      goal: model.goal,
      level: model.level,
      topContributions: model.topContributions
          .map<_i41.Contribution>(
              (value) => _map__i40$ContributionDTO_To__i41$Contribution(value))
          .toList(),
      lastContribution: _map__i40$ContributionDTO_To__i41$Contribution_Nullable(
          model.lastContribution),
      endsAt: model.endsAt,
    );
  }

  _i40.ContributionDTO _map__i41$Contribution_To__i40$ContributionDTO(
      _i41.Contribution? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Contribution → ContributionDTO failed because Contribution was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Contribution, ContributionDTO> to handle null values during mapping.');
    }
    return _i40.ContributionDTO(
      userId: model.userId,
      userLogin: model.userLogin,
      userName: model.userName,
      type: model.type,
      total: model.total,
    );
  }

  _i41.Contribution _map__i40$ContributionDTO_To__i41$Contribution(
      _i40.ContributionDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ContributionDTO → Contribution failed because ContributionDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ContributionDTO, Contribution> to handle null values during mapping.');
    }
    return _i41.Contribution(
      userId: model.userId,
      userLogin: model.userLogin,
      userName: model.userName,
      type: model.type,
      total: model.total,
    );
  }

  _i43.KickUserDTO _map__i42$KickUser_To__i43$KickUserDTO(
      _i42.KickUser? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickUser → KickUserDTO failed because KickUser was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickUser, KickUserDTO> to handle null values during mapping.');
    }
    return _i43.KickUserDTO(
      userId: model.userId,
      name: model.name,
      email: model.email,
      profilePicture: model.profilePicture,
    );
  }

  _i42.KickUser _map__i43$KickUserDTO_To__i42$KickUser(
      _i43.KickUserDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickUserDTO → KickUser failed because KickUserDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickUserDTO, KickUser> to handle null values during mapping.');
    }
    return _i42.KickUser(
      userId: model.userId,
      name: model.name,
      email: model.email,
      profilePicture: model.profilePicture,
    );
  }

  _i45.KickCredentialsDTO _map__i44$KickCredentials_To__i45$KickCredentialsDTO(
      _i44.KickCredentials? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickCredentials → KickCredentialsDTO failed because KickCredentials was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickCredentials, KickCredentialsDTO> to handle null values during mapping.');
    }
    return _i45.KickCredentialsDTO(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      kickUser: _map__i42$KickUser_To__i43$KickUserDTO(model.kickUser),
      scopes: model.scopes,
    );
  }

  _i44.KickCredentials _map__i45$KickCredentialsDTO_To__i44$KickCredentials(
      _i45.KickCredentialsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickCredentialsDTO → KickCredentials failed because KickCredentialsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickCredentialsDTO, KickCredentials> to handle null values during mapping.');
    }
    return _i44.KickCredentials(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      kickUser: _map__i43$KickUserDTO_To__i42$KickUser(model.kickUser),
      scopes: model.scopes,
    );
  }

  _i41.Contribution? _map__i40$ContributionDTO_To__i41$Contribution_Nullable(
      _i40.ContributionDTO? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    return _i41.Contribution(
      userId: model.userId,
      userLogin: model.userLogin,
      userName: model.userName,
      type: model.type,
      total: model.total,
    );
  }
}
