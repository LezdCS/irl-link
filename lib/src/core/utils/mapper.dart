import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:irllink/src/data/entities/dashboard_event_dto.dart';
import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_events_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/dashboard_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/general_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/stream_elements_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_decoded_idtoken_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_poll_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_prediction_dto.dart';
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
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_decoded_idtoken.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_prediction.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_user.dart';

import 'mapper.auto_mappr.dart';

@AutoMappr([
  MapType<Settings, SettingsDTO>(),
  MapType<Channel, ChannelDTO>(),
  MapType<ChatGroup, ChatGroupDTO>(),
  MapType<BrowserTab, BrowserTabDTO>(),
  MapType<ChatSettings, ChatSettingsDTO>(),
  MapType<GeneralSettings, GeneralSettingsDTO>(),
  MapType<DashboardEvent, DashboardEventDTO>(),
  MapType<BrowserTabSettings, BrowserTabSettingsDTO>(),
  MapType<StreamElementsSettings, StreamElementsSettingsDTO>(),
  MapType<TtsSettings, TtsSettingsDTO>(),
  MapType<ChatEventsSettings, ChatEventsSettingsDTO>(),
  MapType<TwitchCredentials, TwitchCredentialsDTO>(),
  MapType<TwitchCredentialsDTO, TwitchCredentials>(),
  MapType<TwitchDecodedIdToken, TwitchDecodedIdTokenDTO>(),
  MapType<TwitchDecodedIdTokenDTO, TwitchDecodedIdToken>(),
  MapType<TwitchUser, TwitchUserDTO>(),
  MapType<TwitchUserDTO, TwitchUser>(),
  MapType<DashboardSettings, DashboardSettingsDTO>(),
  MapType<TwitchPoll, TwitchPollDTO>(),
  MapType<Choice, ChoiceDTO>(),
  MapType<TwitchPredictionDTO, TwitchPrediction>(),
  MapType<OutcomeDTO, Outcome>(),
  MapType<TwitchPredictionDTO, TwitchPrediction>(),
])
class Mappr extends $Mappr {}