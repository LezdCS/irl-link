import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:irllink/src/core/utils/mapper.auto_mappr.dart';
import 'package:irllink/src/data/entities/dashboard_event_dto.dart';
import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/dashboard_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/general_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_activity_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_me_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_overlay_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_hype_train_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_prediction_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_stream_infos_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_user_dto.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/dashboard_settings.dart';
import 'package:irllink/src/domain/entities/settings/general_settings.dart';
import 'package:irllink/src/domain/entities/settings/stream_elements_settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_activity.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_me.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_overlay.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_decoded_idtoken.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_hype_train.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_stream_infos.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';

@AutoMappr([
  MapType<Settings, SettingsDTO>(),
  MapType<SettingsDTO, Settings>(),
  MapType<Channel, ChannelDTO>(),
  MapType<ChannelDTO, Channel>(),
  MapType<ChatGroup, ChatGroupDTO>(),
  MapType<ChatGroupDTO, ChatGroup>(),
  MapType<BrowserTab, BrowserTabDTO>(),
  MapType<BrowserTabDTO, BrowserTab>(),
  MapType<ChatSettings, ChatSettingsDTO>(),
  MapType<ChatSettingsDTO, ChatSettings>(),
  MapType<GeneralSettings, GeneralSettingsDTO>(),
  MapType<GeneralSettingsDTO, GeneralSettings>(),
  MapType<DashboardEvent, DashboardEventDTO>(),
  MapType<DashboardEventDTO, DashboardEvent>(),
  MapType<BrowserTabSettings, BrowserTabSettingsDTO>(),
  MapType<BrowserTabSettingsDTO, BrowserTabSettings>(),
  MapType<StreamElementsSettings, StreamElementsSettingsDTO>(),
  MapType<StreamElementsSettingsDTO, StreamElementsSettings>(),
  MapType<TtsSettings, TtsSettingsDTO>(),
  MapType<TtsSettingsDTO, TtsSettings>(),
  MapType<ChatEventsSettings, ChatEventsSettingsDTO>(),
  MapType<ChatEventsSettingsDTO, ChatEventsSettings>(),
  MapType<TwitchCredentials, TwitchCredentialsDTO>(),
  MapType<TwitchCredentialsDTO, TwitchCredentials>(),
  MapType<TwitchDecodedIdToken, TwitchDecodedIdTokenDTO>(),
  MapType<TwitchDecodedIdTokenDTO, TwitchDecodedIdToken>(),
  MapType<TwitchUser, TwitchUserDTO>(),
  MapType<TwitchUserDTO, TwitchUser>(),
  MapType<DashboardSettings, DashboardSettingsDTO>(),
  MapType<DashboardSettingsDTO, DashboardSettings>(),
  MapType<TwitchPoll, TwitchPollDTO>(),
  MapType<TwitchPollDTO, TwitchPoll>(),
  MapType<Choice, ChoiceDTO>(),
  MapType<ChoiceDTO, Choice>(),
  MapType<OutcomeDTO, Outcome>(),
  MapType<TwitchPredictionDTO, TwitchPrediction>(),
  MapType<SeActivityDTO, SeActivity>(),
  MapType<SeCredentialsDTO, SeCredentials>(),
  MapType<SeMeDTO, SeMe>(),
  MapType<SeOverlayDTO, SeOverlay>(),
  MapType<TwitchStreamInfosDto, TwitchStreamInfos>(),
  MapType<TwitchHypeTrainDTO, TwitchHypeTrain>(),
  MapType<Contribution, ContributionDTO>(),
  MapType<ContributionDTO, Contribution>(),
])
class Mappr extends $Mappr {}