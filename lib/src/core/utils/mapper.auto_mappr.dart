// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint, unnecessary_cast, unused_local_variable

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;

import '../../data/entities/dashboard_event_dto.dart' as _i11;
import '../../data/entities/kick/kick_category_dto.dart' as _i41;
import '../../data/entities/kick/kick_channel_dto.dart' as _i46;
import '../../data/entities/kick/kick_credentials_dto.dart' as _i45;
import '../../data/entities/kick/kick_user_dto.dart' as _i43;
import '../../data/entities/obs_settings_dto.dart' as _i53;
import '../../data/entities/rtmp_dto.dart' as _i49;
import '../../data/entities/settings/browser_tab_settings_dto.dart' as _i7;
import '../../data/entities/settings/chat_events_settings_dto.dart' as _i17;
import '../../data/entities/settings/chat_settings_dto.dart' as _i5;
import '../../data/entities/settings/general_settings_dto.dart' as _i9;
import '../../data/entities/settings/hidden_user_dto.dart' as _i51;
import '../../data/entities/settings/stream_elements_settings_dto.dart' as _i13;
import '../../data/entities/settings/tts_settings_dto.dart' as _i15;
import '../../data/entities/settings_dto.dart' as _i3;
import '../../data/entities/stream_elements/se_activity_dto.dart' as _i28;
import '../../data/entities/stream_elements/se_credentials_dto.dart' as _i30;
import '../../data/entities/stream_elements/se_me_dto.dart' as _i32;
import '../../data/entities/stream_elements/se_overlay_dto.dart' as _i34;
import '../../data/entities/twitch/twitch_credentials_dto.dart' as _i19;
import '../../data/entities/twitch/twitch_decoded_idtoken_dto.dart' as _i21;
import '../../data/entities/twitch/twitch_hype_train_dto.dart' as _i38;
import '../../data/entities/twitch/twitch_poll_dto.dart' as _i25;
import '../../data/entities/twitch/twitch_prediction_dto.dart' as _i26;
import '../../data/entities/twitch/twitch_stream_infos_dto.dart' as _i36;
import '../../data/entities/twitch/twitch_user_dto.dart' as _i23;
import '../../domain/entities/dashboard_event.dart' as _i10;
import '../../domain/entities/kick/kick_category.dart' as _i40;
import '../../domain/entities/kick/kick_channel.dart' as _i47;
import '../../domain/entities/kick/kick_credentials.dart' as _i44;
import '../../domain/entities/kick/kick_user.dart' as _i42;
import '../../domain/entities/rtmp.dart' as _i48;
import '../../domain/entities/settings.dart' as _i2;
import '../../domain/entities/settings/browser_tab_settings.dart' as _i6;
import '../../domain/entities/settings/chat_events_settings.dart' as _i16;
import '../../domain/entities/settings/chat_settings.dart' as _i4;
import '../../domain/entities/settings/general_settings.dart' as _i8;
import '../../domain/entities/settings/hidden_user.dart' as _i50;
import '../../domain/entities/settings/obs_settings.dart' as _i52;
import '../../domain/entities/settings/stream_elements_settings.dart' as _i12;
import '../../domain/entities/settings/tts_settings.dart' as _i14;
import '../../domain/entities/stream_elements/se_activity.dart' as _i29;
import '../../domain/entities/stream_elements/se_credentials.dart' as _i31;
import '../../domain/entities/stream_elements/se_me.dart' as _i33;
import '../../domain/entities/stream_elements/se_overlay.dart' as _i35;
import '../../domain/entities/twitch/twitch_credentials.dart' as _i18;
import '../../domain/entities/twitch/twitch_decoded_idtoken.dart' as _i20;
import '../../domain/entities/twitch/twitch_hype_train.dart' as _i39;
import '../../domain/entities/twitch/twitch_poll.dart' as _i24;
import '../../domain/entities/twitch/twitch_prediction.dart' as _i27;
import '../../domain/entities/twitch/twitch_stream_infos.dart' as _i37;
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
/// - `KickCategory` → `KickCategoryDTO`.
/// - `KickCategoryDTO` → `KickCategory`.
/// - `Contribution` → `ContributionDTO`.
/// - `ContributionDTO` → `Contribution`.
/// - `KickUser` → `KickUserDTO`.
/// - `KickUserDTO` → `KickUser`.
/// - `KickCredentials` → `KickCredentialsDTO`.
/// - `KickCredentialsDTO` → `KickCredentials`.
/// - `KickChannelStreamDto` → `KickChannelStream`.
/// - `KickChannelStream` → `KickChannelStreamDto`.
/// - `KickChannel` → `KickChannelDto`.
/// - `KickChannelDto` → `KickChannel`.
/// - `Rtmp` → `RtmpDTO`.
/// - `RtmpDTO` → `Rtmp`.
/// - `HiddenUser` → `HiddenUserDTO`.
/// - `HiddenUserDTO` → `HiddenUser`.
/// - `ObsSettings` → `ObsSettingsDTO`.
/// - `ObsSettingsDTO` → `ObsSettings`.
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
    if ((sourceTypeOf == _typeOf<_i24.TwitchPoll>() ||
            sourceTypeOf == _typeOf<_i24.TwitchPoll?>()) &&
        (targetTypeOf == _typeOf<_i25.TwitchPollDTO>() ||
            targetTypeOf == _typeOf<_i25.TwitchPollDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i25.TwitchPollDTO>() ||
            sourceTypeOf == _typeOf<_i25.TwitchPollDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.TwitchPoll>() ||
            targetTypeOf == _typeOf<_i24.TwitchPoll?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i24.Choice>() ||
            sourceTypeOf == _typeOf<_i24.Choice?>()) &&
        (targetTypeOf == _typeOf<_i25.ChoiceDTO>() ||
            targetTypeOf == _typeOf<_i25.ChoiceDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i25.ChoiceDTO>() ||
            sourceTypeOf == _typeOf<_i25.ChoiceDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.Choice>() ||
            targetTypeOf == _typeOf<_i24.Choice?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i26.OutcomeDTO>() ||
            sourceTypeOf == _typeOf<_i26.OutcomeDTO?>()) &&
        (targetTypeOf == _typeOf<_i27.Outcome>() ||
            targetTypeOf == _typeOf<_i27.Outcome?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i26.TwitchPredictionDTO>() ||
            sourceTypeOf == _typeOf<_i26.TwitchPredictionDTO?>()) &&
        (targetTypeOf == _typeOf<_i27.TwitchPrediction>() ||
            targetTypeOf == _typeOf<_i27.TwitchPrediction?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i28.SeActivityDTO>() ||
            sourceTypeOf == _typeOf<_i28.SeActivityDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.SeActivity>() ||
            targetTypeOf == _typeOf<_i29.SeActivity?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i30.SeCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i30.SeCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i31.SeCredentials>() ||
            targetTypeOf == _typeOf<_i31.SeCredentials?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i31.SeCredentials>() ||
            sourceTypeOf == _typeOf<_i31.SeCredentials?>()) &&
        (targetTypeOf == _typeOf<_i30.SeCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i30.SeCredentialsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i32.SeMeDTO>() ||
            sourceTypeOf == _typeOf<_i32.SeMeDTO?>()) &&
        (targetTypeOf == _typeOf<_i33.SeMe>() ||
            targetTypeOf == _typeOf<_i33.SeMe?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i34.SeOverlayDTO>() ||
            sourceTypeOf == _typeOf<_i34.SeOverlayDTO?>()) &&
        (targetTypeOf == _typeOf<_i35.SeOverlay>() ||
            targetTypeOf == _typeOf<_i35.SeOverlay?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i36.TwitchStreamInfosDto>() ||
            sourceTypeOf == _typeOf<_i36.TwitchStreamInfosDto?>()) &&
        (targetTypeOf == _typeOf<_i37.TwitchStreamInfos>() ||
            targetTypeOf == _typeOf<_i37.TwitchStreamInfos?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i38.TwitchHypeTrainDTO>() ||
            sourceTypeOf == _typeOf<_i38.TwitchHypeTrainDTO?>()) &&
        (targetTypeOf == _typeOf<_i39.TwitchHypeTrain>() ||
            targetTypeOf == _typeOf<_i39.TwitchHypeTrain?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i40.KickCategory>() ||
            sourceTypeOf == _typeOf<_i40.KickCategory?>()) &&
        (targetTypeOf == _typeOf<_i41.KickCategoryDTO>() ||
            targetTypeOf == _typeOf<_i41.KickCategoryDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i41.KickCategoryDTO>() ||
            sourceTypeOf == _typeOf<_i41.KickCategoryDTO?>()) &&
        (targetTypeOf == _typeOf<_i40.KickCategory>() ||
            targetTypeOf == _typeOf<_i40.KickCategory?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i39.Contribution>() ||
            sourceTypeOf == _typeOf<_i39.Contribution?>()) &&
        (targetTypeOf == _typeOf<_i38.ContributionDTO>() ||
            targetTypeOf == _typeOf<_i38.ContributionDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i38.ContributionDTO>() ||
            sourceTypeOf == _typeOf<_i38.ContributionDTO?>()) &&
        (targetTypeOf == _typeOf<_i39.Contribution>() ||
            targetTypeOf == _typeOf<_i39.Contribution?>())) {
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
    if ((sourceTypeOf == _typeOf<_i46.KickChannelStreamDto>() ||
            sourceTypeOf == _typeOf<_i46.KickChannelStreamDto?>()) &&
        (targetTypeOf == _typeOf<_i47.KickChannelStream>() ||
            targetTypeOf == _typeOf<_i47.KickChannelStream?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i47.KickChannelStream>() ||
            sourceTypeOf == _typeOf<_i47.KickChannelStream?>()) &&
        (targetTypeOf == _typeOf<_i46.KickChannelStreamDto>() ||
            targetTypeOf == _typeOf<_i46.KickChannelStreamDto?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i47.KickChannel>() ||
            sourceTypeOf == _typeOf<_i47.KickChannel?>()) &&
        (targetTypeOf == _typeOf<_i46.KickChannelDto>() ||
            targetTypeOf == _typeOf<_i46.KickChannelDto?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i46.KickChannelDto>() ||
            sourceTypeOf == _typeOf<_i46.KickChannelDto?>()) &&
        (targetTypeOf == _typeOf<_i47.KickChannel>() ||
            targetTypeOf == _typeOf<_i47.KickChannel?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i48.Rtmp>() ||
            sourceTypeOf == _typeOf<_i48.Rtmp?>()) &&
        (targetTypeOf == _typeOf<_i49.RtmpDTO>() ||
            targetTypeOf == _typeOf<_i49.RtmpDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i49.RtmpDTO>() ||
            sourceTypeOf == _typeOf<_i49.RtmpDTO?>()) &&
        (targetTypeOf == _typeOf<_i48.Rtmp>() ||
            targetTypeOf == _typeOf<_i48.Rtmp?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i50.HiddenUser>() ||
            sourceTypeOf == _typeOf<_i50.HiddenUser?>()) &&
        (targetTypeOf == _typeOf<_i51.HiddenUserDTO>() ||
            targetTypeOf == _typeOf<_i51.HiddenUserDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i51.HiddenUserDTO>() ||
            sourceTypeOf == _typeOf<_i51.HiddenUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i50.HiddenUser>() ||
            targetTypeOf == _typeOf<_i50.HiddenUser?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i52.ObsSettings>() ||
            sourceTypeOf == _typeOf<_i52.ObsSettings?>()) &&
        (targetTypeOf == _typeOf<_i53.ObsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i53.ObsSettingsDTO?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i53.ObsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i53.ObsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i52.ObsSettings>() ||
            targetTypeOf == _typeOf<_i52.ObsSettings?>())) {
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
    if ((sourceTypeOf == _typeOf<_i24.TwitchPoll>() ||
            sourceTypeOf == _typeOf<_i24.TwitchPoll?>()) &&
        (targetTypeOf == _typeOf<_i25.TwitchPollDTO>() ||
            targetTypeOf == _typeOf<_i25.TwitchPollDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i24$TwitchPoll_To__i25$TwitchPollDTO(
          (model as _i24.TwitchPoll?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i25.TwitchPollDTO>() ||
            sourceTypeOf == _typeOf<_i25.TwitchPollDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.TwitchPoll>() ||
            targetTypeOf == _typeOf<_i24.TwitchPoll?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i25$TwitchPollDTO_To__i24$TwitchPoll(
          (model as _i25.TwitchPollDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i24.Choice>() ||
            sourceTypeOf == _typeOf<_i24.Choice?>()) &&
        (targetTypeOf == _typeOf<_i25.ChoiceDTO>() ||
            targetTypeOf == _typeOf<_i25.ChoiceDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i24$Choice_To__i25$ChoiceDTO((model as _i24.Choice?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i25.ChoiceDTO>() ||
            sourceTypeOf == _typeOf<_i25.ChoiceDTO?>()) &&
        (targetTypeOf == _typeOf<_i24.Choice>() ||
            targetTypeOf == _typeOf<_i24.Choice?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i25$ChoiceDTO_To__i24$Choice((model as _i25.ChoiceDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i26.OutcomeDTO>() ||
            sourceTypeOf == _typeOf<_i26.OutcomeDTO?>()) &&
        (targetTypeOf == _typeOf<_i27.Outcome>() ||
            targetTypeOf == _typeOf<_i27.Outcome?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i26$OutcomeDTO_To__i27$Outcome((model as _i26.OutcomeDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i26.TwitchPredictionDTO>() ||
            sourceTypeOf == _typeOf<_i26.TwitchPredictionDTO?>()) &&
        (targetTypeOf == _typeOf<_i27.TwitchPrediction>() ||
            targetTypeOf == _typeOf<_i27.TwitchPrediction?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i26$TwitchPredictionDTO_To__i27$TwitchPrediction(
          (model as _i26.TwitchPredictionDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i28.SeActivityDTO>() ||
            sourceTypeOf == _typeOf<_i28.SeActivityDTO?>()) &&
        (targetTypeOf == _typeOf<_i29.SeActivity>() ||
            targetTypeOf == _typeOf<_i29.SeActivity?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i28$SeActivityDTO_To__i29$SeActivity(
          (model as _i28.SeActivityDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i30.SeCredentialsDTO>() ||
            sourceTypeOf == _typeOf<_i30.SeCredentialsDTO?>()) &&
        (targetTypeOf == _typeOf<_i31.SeCredentials>() ||
            targetTypeOf == _typeOf<_i31.SeCredentials?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i30$SeCredentialsDTO_To__i31$SeCredentials(
          (model as _i30.SeCredentialsDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i31.SeCredentials>() ||
            sourceTypeOf == _typeOf<_i31.SeCredentials?>()) &&
        (targetTypeOf == _typeOf<_i30.SeCredentialsDTO>() ||
            targetTypeOf == _typeOf<_i30.SeCredentialsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i31$SeCredentials_To__i30$SeCredentialsDTO(
          (model as _i31.SeCredentials?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i32.SeMeDTO>() ||
            sourceTypeOf == _typeOf<_i32.SeMeDTO?>()) &&
        (targetTypeOf == _typeOf<_i33.SeMe>() ||
            targetTypeOf == _typeOf<_i33.SeMe?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i32$SeMeDTO_To__i33$SeMe((model as _i32.SeMeDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i34.SeOverlayDTO>() ||
            sourceTypeOf == _typeOf<_i34.SeOverlayDTO?>()) &&
        (targetTypeOf == _typeOf<_i35.SeOverlay>() ||
            targetTypeOf == _typeOf<_i35.SeOverlay?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i34$SeOverlayDTO_To__i35$SeOverlay(
          (model as _i34.SeOverlayDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i36.TwitchStreamInfosDto>() ||
            sourceTypeOf == _typeOf<_i36.TwitchStreamInfosDto?>()) &&
        (targetTypeOf == _typeOf<_i37.TwitchStreamInfos>() ||
            targetTypeOf == _typeOf<_i37.TwitchStreamInfos?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i36$TwitchStreamInfosDto_To__i37$TwitchStreamInfos(
          (model as _i36.TwitchStreamInfosDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i38.TwitchHypeTrainDTO>() ||
            sourceTypeOf == _typeOf<_i38.TwitchHypeTrainDTO?>()) &&
        (targetTypeOf == _typeOf<_i39.TwitchHypeTrain>() ||
            targetTypeOf == _typeOf<_i39.TwitchHypeTrain?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i38$TwitchHypeTrainDTO_To__i39$TwitchHypeTrain(
          (model as _i38.TwitchHypeTrainDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i40.KickCategory>() ||
            sourceTypeOf == _typeOf<_i40.KickCategory?>()) &&
        (targetTypeOf == _typeOf<_i41.KickCategoryDTO>() ||
            targetTypeOf == _typeOf<_i41.KickCategoryDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i40$KickCategory_To__i41$KickCategoryDTO(
          (model as _i40.KickCategory?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i41.KickCategoryDTO>() ||
            sourceTypeOf == _typeOf<_i41.KickCategoryDTO?>()) &&
        (targetTypeOf == _typeOf<_i40.KickCategory>() ||
            targetTypeOf == _typeOf<_i40.KickCategory?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i41$KickCategoryDTO_To__i40$KickCategory(
          (model as _i41.KickCategoryDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i39.Contribution>() ||
            sourceTypeOf == _typeOf<_i39.Contribution?>()) &&
        (targetTypeOf == _typeOf<_i38.ContributionDTO>() ||
            targetTypeOf == _typeOf<_i38.ContributionDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i39$Contribution_To__i38$ContributionDTO(
          (model as _i39.Contribution?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i38.ContributionDTO>() ||
            sourceTypeOf == _typeOf<_i38.ContributionDTO?>()) &&
        (targetTypeOf == _typeOf<_i39.Contribution>() ||
            targetTypeOf == _typeOf<_i39.Contribution?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i38$ContributionDTO_To__i39$Contribution(
          (model as _i38.ContributionDTO?)) as TARGET);
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
    if ((sourceTypeOf == _typeOf<_i46.KickChannelStreamDto>() ||
            sourceTypeOf == _typeOf<_i46.KickChannelStreamDto?>()) &&
        (targetTypeOf == _typeOf<_i47.KickChannelStream>() ||
            targetTypeOf == _typeOf<_i47.KickChannelStream?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i46$KickChannelStreamDto_To__i47$KickChannelStream(
          (model as _i46.KickChannelStreamDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i47.KickChannelStream>() ||
            sourceTypeOf == _typeOf<_i47.KickChannelStream?>()) &&
        (targetTypeOf == _typeOf<_i46.KickChannelStreamDto>() ||
            targetTypeOf == _typeOf<_i46.KickChannelStreamDto?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i47$KickChannelStream_To__i46$KickChannelStreamDto(
          (model as _i47.KickChannelStream?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i47.KickChannel>() ||
            sourceTypeOf == _typeOf<_i47.KickChannel?>()) &&
        (targetTypeOf == _typeOf<_i46.KickChannelDto>() ||
            targetTypeOf == _typeOf<_i46.KickChannelDto?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i47$KickChannel_To__i46$KickChannelDto(
          (model as _i47.KickChannel?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i46.KickChannelDto>() ||
            sourceTypeOf == _typeOf<_i46.KickChannelDto?>()) &&
        (targetTypeOf == _typeOf<_i47.KickChannel>() ||
            targetTypeOf == _typeOf<_i47.KickChannel?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i46$KickChannelDto_To__i47$KickChannel(
          (model as _i46.KickChannelDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i48.Rtmp>() ||
            sourceTypeOf == _typeOf<_i48.Rtmp?>()) &&
        (targetTypeOf == _typeOf<_i49.RtmpDTO>() ||
            targetTypeOf == _typeOf<_i49.RtmpDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i48$Rtmp_To__i49$RtmpDTO((model as _i48.Rtmp?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i49.RtmpDTO>() ||
            sourceTypeOf == _typeOf<_i49.RtmpDTO?>()) &&
        (targetTypeOf == _typeOf<_i48.Rtmp>() ||
            targetTypeOf == _typeOf<_i48.Rtmp?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i49$RtmpDTO_To__i48$Rtmp((model as _i49.RtmpDTO?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i50.HiddenUser>() ||
            sourceTypeOf == _typeOf<_i50.HiddenUser?>()) &&
        (targetTypeOf == _typeOf<_i51.HiddenUserDTO>() ||
            targetTypeOf == _typeOf<_i51.HiddenUserDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i50$HiddenUser_To__i51$HiddenUserDTO(
          (model as _i50.HiddenUser?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i51.HiddenUserDTO>() ||
            sourceTypeOf == _typeOf<_i51.HiddenUserDTO?>()) &&
        (targetTypeOf == _typeOf<_i50.HiddenUser>() ||
            targetTypeOf == _typeOf<_i50.HiddenUser?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i51$HiddenUserDTO_To__i50$HiddenUser(
          (model as _i51.HiddenUserDTO?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i52.ObsSettings>() ||
            sourceTypeOf == _typeOf<_i52.ObsSettings?>()) &&
        (targetTypeOf == _typeOf<_i53.ObsSettingsDTO>() ||
            targetTypeOf == _typeOf<_i53.ObsSettingsDTO?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i52$ObsSettings_To__i53$ObsSettingsDTO(
          (model as _i52.ObsSettings?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i53.ObsSettingsDTO>() ||
            sourceTypeOf == _typeOf<_i53.ObsSettingsDTO?>()) &&
        (targetTypeOf == _typeOf<_i52.ObsSettings>() ||
            targetTypeOf == _typeOf<_i52.ObsSettings?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i53$ObsSettingsDTO_To__i52$ObsSettings(
          (model as _i53.ObsSettingsDTO?)) as TARGET);
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
      chatEventsSettings:
          _map__i16$ChatEventsSettings_To__i17$ChatEventsSettingsDTO(
              model.chatEventsSettings),
      chatSettings:
          _map__i4$ChatSettings_To__i5$ChatSettingsDTO(model.chatSettings),
      generalSettings: _map__i8$GeneralSettings_To__i9$GeneralSettingsDTO(
          model.generalSettings),
      rtIrlPushKey: model.rtIrlPushKey,
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
      chatEventsSettings:
          _map__i17$ChatEventsSettingsDTO_To__i16$ChatEventsSettings(
              model.chatEventsSettings),
      chatSettings:
          _map__i5$ChatSettingsDTO_To__i4$ChatSettings(model.chatSettings),
      generalSettings: _map__i9$GeneralSettingsDTO_To__i8$GeneralSettings(
          model.generalSettings),
      rtIrlPushKey: model.rtIrlPushKey,
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
    return _i5.ChatSettingsDTO(hideDeletedMessages: model.hideDeletedMessages);
  }

  _i4.ChatSettings _map__i5$ChatSettingsDTO_To__i4$ChatSettings(
      _i5.ChatSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChatSettingsDTO → ChatSettings failed because ChatSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChatSettingsDTO, ChatSettings> to handle null values during mapping.');
    }
    return _i4.ChatSettings(hideDeletedMessages: model.hideDeletedMessages);
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
      id: model.id,
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
      id: model.id,
      title: model.title,
      color: model.color,
      dashboardActionsType: model.dashboardActionsType,
      event: model.event,
      customValue: model.customValue,
    );
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

  _i25.TwitchPollDTO _map__i24$TwitchPoll_To__i25$TwitchPollDTO(
      _i24.TwitchPoll? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPoll → TwitchPollDTO failed because TwitchPoll was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPoll, TwitchPollDTO> to handle null values during mapping.');
    }
    return _i25.TwitchPollDTO(
      id: model.id,
      title: model.title,
      choices: model.choices
          .map<_i25.ChoiceDTO>(
              (value) => _map__i24$Choice_To__i25$ChoiceDTO(value))
          .toList(),
      totalVotes: model.totalVotes,
      status: model.status,
      endsAt: model.endsAt,
    );
  }

  _i24.TwitchPoll _map__i25$TwitchPollDTO_To__i24$TwitchPoll(
      _i25.TwitchPollDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPollDTO → TwitchPoll failed because TwitchPollDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPollDTO, TwitchPoll> to handle null values during mapping.');
    }
    return _i24.TwitchPoll(
      id: model.id,
      title: model.title,
      choices: model.choices
          .map<_i24.Choice>(
              (value) => _map__i25$ChoiceDTO_To__i24$Choice(value))
          .toList(),
      totalVotes: model.totalVotes,
      status: model.status,
      endsAt: model.endsAt,
    );
  }

  _i25.ChoiceDTO _map__i24$Choice_To__i25$ChoiceDTO(_i24.Choice? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Choice → ChoiceDTO failed because Choice was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Choice, ChoiceDTO> to handle null values during mapping.');
    }
    return _i25.ChoiceDTO(
      id: model.id,
      title: model.title,
      votes: model.votes,
    );
  }

  _i24.Choice _map__i25$ChoiceDTO_To__i24$Choice(_i25.ChoiceDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ChoiceDTO → Choice failed because ChoiceDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ChoiceDTO, Choice> to handle null values during mapping.');
    }
    return _i24.Choice(
      id: model.id,
      title: model.title,
      votes: model.votes,
    );
  }

  _i27.Outcome _map__i26$OutcomeDTO_To__i27$Outcome(_i26.OutcomeDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping OutcomeDTO → Outcome failed because OutcomeDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<OutcomeDTO, Outcome> to handle null values during mapping.');
    }
    return _i27.Outcome(
      id: model.id,
      title: model.title,
      users: model.users,
      channelPoints: model.channelPoints,
      color: model.color,
    );
  }

  _i27.TwitchPrediction _map__i26$TwitchPredictionDTO_To__i27$TwitchPrediction(
      _i26.TwitchPredictionDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchPredictionDTO → TwitchPrediction failed because TwitchPredictionDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchPredictionDTO, TwitchPrediction> to handle null values during mapping.');
    }
    return _i27.TwitchPrediction(
      id: model.id,
      title: model.title,
      winningOutcomeId: model.winningOutcomeId,
      totalUsers: model.totalUsers,
      outcomes: model.outcomes
          .map<_i27.Outcome>(
              (value) => _map__i26$OutcomeDTO_To__i27$Outcome(value))
          .toList(),
      status: model.status,
      remainingTime: model.remainingTime,
    );
  }

  _i29.SeActivity _map__i28$SeActivityDTO_To__i29$SeActivity(
      _i28.SeActivityDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeActivityDTO → SeActivity failed because SeActivityDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeActivityDTO, SeActivity> to handle null values during mapping.');
    }
    return _i29.SeActivity(
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

  _i31.SeCredentials _map__i30$SeCredentialsDTO_To__i31$SeCredentials(
      _i30.SeCredentialsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeCredentialsDTO → SeCredentials failed because SeCredentialsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeCredentialsDTO, SeCredentials> to handle null values during mapping.');
    }
    return _i31.SeCredentials(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      scopes: model.scopes,
    );
  }

  _i30.SeCredentialsDTO _map__i31$SeCredentials_To__i30$SeCredentialsDTO(
      _i31.SeCredentials? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeCredentials → SeCredentialsDTO failed because SeCredentials was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeCredentials, SeCredentialsDTO> to handle null values during mapping.');
    }
    return _i30.SeCredentialsDTO(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresIn: model.expiresIn,
      scopes: model.scopes,
    );
  }

  _i33.SeMe _map__i32$SeMeDTO_To__i33$SeMe(_i32.SeMeDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeMeDTO → SeMe failed because SeMeDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeMeDTO, SeMe> to handle null values during mapping.');
    }
    return _i33.SeMe(
      id: model.id,
      avatar: model.avatar,
      username: model.username,
      displayName: model.displayName,
    );
  }

  _i35.SeOverlay _map__i34$SeOverlayDTO_To__i35$SeOverlay(
      _i34.SeOverlayDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping SeOverlayDTO → SeOverlay failed because SeOverlayDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<SeOverlayDTO, SeOverlay> to handle null values during mapping.');
    }
    return _i35.SeOverlay(
      id: model.id,
      name: model.name,
    );
  }

  _i37.TwitchStreamInfos
      _map__i36$TwitchStreamInfosDto_To__i37$TwitchStreamInfos(
          _i36.TwitchStreamInfosDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchStreamInfosDto → TwitchStreamInfos failed because TwitchStreamInfosDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchStreamInfosDto, TwitchStreamInfos> to handle null values during mapping.');
    }
    return _i37.TwitchStreamInfos(
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

  _i39.TwitchHypeTrain _map__i38$TwitchHypeTrainDTO_To__i39$TwitchHypeTrain(
      _i38.TwitchHypeTrainDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping TwitchHypeTrainDTO → TwitchHypeTrain failed because TwitchHypeTrainDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<TwitchHypeTrainDTO, TwitchHypeTrain> to handle null values during mapping.');
    }
    return _i39.TwitchHypeTrain(
      id: model.id,
      total: model.total,
      progress: model.progress,
      goal: model.goal,
      level: model.level,
      topContributions: model.topContributions
          .map<_i39.Contribution>(
              (value) => _map__i38$ContributionDTO_To__i39$Contribution(value))
          .toList(),
      lastContribution: _map__i38$ContributionDTO_To__i39$Contribution_Nullable(
          model.lastContribution),
      endsAt: model.endsAt,
    );
  }

  _i41.KickCategoryDTO _map__i40$KickCategory_To__i41$KickCategoryDTO(
      _i40.KickCategory? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickCategory → KickCategoryDTO failed because KickCategory was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickCategory, KickCategoryDTO> to handle null values during mapping.');
    }
    return _i41.KickCategoryDTO(
      id: model.id,
      name: model.name,
      thumbnail: model.thumbnail,
    );
  }

  _i40.KickCategory _map__i41$KickCategoryDTO_To__i40$KickCategory(
      _i41.KickCategoryDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickCategoryDTO → KickCategory failed because KickCategoryDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickCategoryDTO, KickCategory> to handle null values during mapping.');
    }
    return _i40.KickCategory(
      id: model.id,
      name: model.name,
      thumbnail: model.thumbnail,
    );
  }

  _i38.ContributionDTO _map__i39$Contribution_To__i38$ContributionDTO(
      _i39.Contribution? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Contribution → ContributionDTO failed because Contribution was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Contribution, ContributionDTO> to handle null values during mapping.');
    }
    return _i38.ContributionDTO(
      userId: model.userId,
      userLogin: model.userLogin,
      userName: model.userName,
      type: model.type,
      total: model.total,
    );
  }

  _i39.Contribution _map__i38$ContributionDTO_To__i39$Contribution(
      _i38.ContributionDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ContributionDTO → Contribution failed because ContributionDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ContributionDTO, Contribution> to handle null values during mapping.');
    }
    return _i39.Contribution(
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

  _i47.KickChannelStream
      _map__i46$KickChannelStreamDto_To__i47$KickChannelStream(
          _i46.KickChannelStreamDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickChannelStreamDto → KickChannelStream failed because KickChannelStreamDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickChannelStreamDto, KickChannelStream> to handle null values during mapping.');
    }
    return _i47.KickChannelStream(
      isLive: model.isLive,
      isMature: model.isMature,
      key: model.key,
      language: model.language,
      startTime: model.startTime,
      thumbnail: model.thumbnail,
      url: model.url,
      viewerCount: model.viewerCount,
    );
  }

  _i46.KickChannelStreamDto
      _map__i47$KickChannelStream_To__i46$KickChannelStreamDto(
          _i47.KickChannelStream? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickChannelStream → KickChannelStreamDto failed because KickChannelStream was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickChannelStream, KickChannelStreamDto> to handle null values during mapping.');
    }
    return _i46.KickChannelStreamDto(
      isLive: model.isLive,
      isMature: model.isMature,
      key: model.key,
      language: model.language,
      startTime: model.startTime,
      thumbnail: model.thumbnail,
      url: model.url,
      viewerCount: model.viewerCount,
    );
  }

  _i46.KickChannelDto _map__i47$KickChannel_To__i46$KickChannelDto(
      _i47.KickChannel? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickChannel → KickChannelDto failed because KickChannel was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickChannel, KickChannelDto> to handle null values during mapping.');
    }
    return _i46.KickChannelDto(
      bannerPicture: model.bannerPicture,
      broadcasterUserId: model.broadcasterUserId,
      category: _map__i40$KickCategory_To__i41$KickCategoryDTO(model.category),
      channelDescription: model.channelDescription,
      slug: model.slug,
      stream: _map__i47$KickChannelStream_To__i46$KickChannelStreamDto(
          model.stream),
      streamTitle: model.streamTitle,
    );
  }

  _i47.KickChannel _map__i46$KickChannelDto_To__i47$KickChannel(
      _i46.KickChannelDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping KickChannelDto → KickChannel failed because KickChannelDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<KickChannelDto, KickChannel> to handle null values during mapping.');
    }
    return _i47.KickChannel(
      bannerPicture: model.bannerPicture,
      broadcasterUserId: model.broadcasterUserId,
      category: _map__i41$KickCategoryDTO_To__i40$KickCategory(model.category),
      channelDescription: model.channelDescription,
      slug: model.slug,
      stream: _map__i46$KickChannelStreamDto_To__i47$KickChannelStream(
          model.stream),
      streamTitle: model.streamTitle,
    );
  }

  _i49.RtmpDTO _map__i48$Rtmp_To__i49$RtmpDTO(_i48.Rtmp? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Rtmp → RtmpDTO failed because Rtmp was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Rtmp, RtmpDTO> to handle null values during mapping.');
    }
    return _i49.RtmpDTO(
      id: model.id,
      name: model.name,
      url: model.url,
      key: model.key,
      createdAt: model.createdAt,
    );
  }

  _i48.Rtmp _map__i49$RtmpDTO_To__i48$Rtmp(_i49.RtmpDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping RtmpDTO → Rtmp failed because RtmpDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<RtmpDTO, Rtmp> to handle null values during mapping.');
    }
    return _i48.Rtmp(
      id: model.id,
      name: model.name,
      url: model.url,
      key: model.key,
      createdAt: model.createdAt,
    );
  }

  _i51.HiddenUserDTO _map__i50$HiddenUser_To__i51$HiddenUserDTO(
      _i50.HiddenUser? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping HiddenUser → HiddenUserDTO failed because HiddenUser was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<HiddenUser, HiddenUserDTO> to handle null values during mapping.');
    }
    return _i51.HiddenUserDTO(
      id: model.id,
      username: model.username,
      platform: model.platform,
    );
  }

  _i50.HiddenUser _map__i51$HiddenUserDTO_To__i50$HiddenUser(
      _i51.HiddenUserDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping HiddenUserDTO → HiddenUser failed because HiddenUserDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<HiddenUserDTO, HiddenUser> to handle null values during mapping.');
    }
    return _i50.HiddenUser(
      id: model.id,
      username: model.username,
      platform: model.platform,
    );
  }

  _i53.ObsSettingsDTO _map__i52$ObsSettings_To__i53$ObsSettingsDTO(
      _i52.ObsSettings? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ObsSettings → ObsSettingsDTO failed because ObsSettings was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ObsSettings, ObsSettingsDTO> to handle null values during mapping.');
    }
    return _i53.ObsSettingsDTO(
      url: model.url,
      password: model.password,
      isConnected: model.isConnected,
    );
  }

  _i52.ObsSettings _map__i53$ObsSettingsDTO_To__i52$ObsSettings(
      _i53.ObsSettingsDTO? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping ObsSettingsDTO → ObsSettings failed because ObsSettingsDTO was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<ObsSettingsDTO, ObsSettings> to handle null values during mapping.');
    }
    return _i52.ObsSettings(
      url: model.url,
      password: model.password,
      isConnected: model.isConnected,
    );
  }

  _i39.Contribution? _map__i38$ContributionDTO_To__i39$Contribution_Nullable(
      _i38.ContributionDTO? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    return _i39.Contribution(
      userId: model.userId,
      userLogin: model.userLogin,
      userName: model.userName,
      type: model.type,
      total: model.total,
    );
  }
}
