import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/utils/mapper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/datasources/local/settings_local_data_source.dart';
import 'package:irllink/src/data/entities/obs_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/hidden_user_dto.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/domain/entities/settings/chat_settings.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/entities/settings/obs_settings.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final Mappr _mappr;
  final Talker talker;
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl({
    required this.talker,
    required SettingsLocalDataSource localDataSource,
  })  : _mappr = Mappr(),
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    talker.logCustom(SettingsLog('Retrieving settings.'));
    final settingsDTO = await _localDataSource.getSettings();
    if (settingsDTO != null) {
      Settings settings = _mappr.convert<SettingsDTO, Settings>(settingsDTO);
      return Right(settings);
    }
    talker.info('No settings found, returning blank settings.');
    SettingsDTO blankSettingsDTO = SettingsDTO.blank();
    Settings settings = _mappr.convert<SettingsDTO, Settings>(blankSettingsDTO);
    return Right(settings);
  }

  @override
  Future<Either<Failure, void>> setSettings(Settings settings) async {
    SettingsDTO settingsDTO = _mappr.convert<Settings, SettingsDTO>(settings);
    await _localDataSource.setSettings(settingsDTO);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addHiddenUser(HiddenUser hiddenUser) async {
    HiddenUserDTO hiddenUserDTO =
        _mappr.convert<HiddenUser, HiddenUserDTO>(hiddenUser);
    await _localDataSource.addHiddenUser(hiddenUserDTO);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeHiddenUser(HiddenUser hiddenUser) async {
    HiddenUserDTO hiddenUserDTO =
        _mappr.convert<HiddenUser, HiddenUserDTO>(hiddenUser);
    await _localDataSource.removeHiddenUser(hiddenUserDTO);
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<HiddenUser>>> getHiddenUsers() async {
    final hiddenUsersDTO = await _localDataSource.getHiddenUsers();
    if (hiddenUsersDTO != null) {
      List<HiddenUser> hiddenUsers = hiddenUsersDTO
          .map(
            (hiddenUserDTO) =>
                _mappr.convert<HiddenUserDTO, HiddenUser>(hiddenUserDTO),
          )
          .toList();
      return Right(hiddenUsers);
    }
    return const Right([]);
  }

  @override
  Future<Either<Failure, void>> addChatGroup(ChatGroup chatGroup) async {
    try {
      ChatGroupDTO chatGroupDTO =
          _mappr.convert<ChatGroup, ChatGroupDTO>(chatGroup);
      await _localDataSource.addChatGroup(chatGroupDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeChatGroup(ChatGroup chatGroup) async {
    try {
      ChatGroupDTO chatGroupDTO =
          _mappr.convert<ChatGroup, ChatGroupDTO>(chatGroup);
      await _localDataSource.removeChatGroup(chatGroupDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addChannel(
    ChatGroup chatGroup,
    Channel channel,
  ) async {
    try {
      ChatGroupDTO chatGroupDTO =
          _mappr.convert<ChatGroup, ChatGroupDTO>(chatGroup);
      ChannelDTO channelDTO = _mappr.convert<Channel, ChannelDTO>(channel);
      await _localDataSource.addChannel(chatGroupDTO, channelDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeChannel(
    ChatGroup chatGroup,
    Channel channel,
  ) async {
    try {
      ChatGroupDTO chatGroupDTO =
          _mappr.convert<ChatGroup, ChatGroupDTO>(chatGroup);
      ChannelDTO channelDTO = _mappr.convert<Channel, ChannelDTO>(channel);
      await _localDataSource.removeChannel(chatGroupDTO, channelDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatGroup>>> getChatGroups() async {
    final chatGroupsDTO = await _localDataSource.getChatGroups();
    if (chatGroupsDTO != null) {
      List<ChatGroup> chatGroups = chatGroupsDTO
          .map(
            (chatGroupDTO) =>
                _mappr.convert<ChatGroupDTO, ChatGroup>(chatGroupDTO),
          )
          .toList();
      return Right(chatGroups);
    }
    return const Right([]);
  }

  @override
  Future<Either<Failure, void>> addBrowserTab(BrowserTab browserTab) async {
    try {
      BrowserTabDTO browserTabDTO =
          _mappr.convert<BrowserTab, BrowserTabDTO>(browserTab);
      await _localDataSource.addBrowserTab(browserTabDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editBrowserTab(BrowserTab browserTab) async {
    try {
      BrowserTabDTO browserTabDTO =
          _mappr.convert<BrowserTab, BrowserTabDTO>(browserTab);
      await _localDataSource.editBrowserTab(browserTabDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeBrowserTab(BrowserTab browserTab) async {
    try {
      BrowserTabDTO browserTabDTO =
          _mappr.convert<BrowserTab, BrowserTabDTO>(browserTab);
      await _localDataSource.removeBrowserTab(browserTabDTO);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BrowserTab>>> getBrowserTabs() async {
    final browserTabsDTO = await _localDataSource.getBrowserTabs();
    if (browserTabsDTO != null) {
      List<BrowserTab> browserTabs = browserTabsDTO
          .map(
            (browserTabDTO) =>
                _mappr.convert<BrowserTabDTO, BrowserTab>(browserTabDTO),
          )
          .toList();
      return Right(browserTabs);
    }
    return const Right([]);
  }

  @override
  Future<Either<Failure, ObsSettings>> getObsCredentials() async {
    final obsSettingsDTO = await _localDataSource.getObsCredentials();
    if (obsSettingsDTO != null) {
      return Right(_mappr.convert<ObsSettingsDTO, ObsSettings>(obsSettingsDTO));
    }
    return Left(Failure('No obs credentials found'));
  }

  @override
  Future<Either<Failure, void>> updateObsSettings(
    ObsSettings obsSettings,
  ) async {
    final obsSettingsDTO =
        _mappr.convert<ObsSettings, ObsSettingsDTO>(obsSettings);
    await _localDataSource.updateObsSettings(obsSettingsDTO);
    return const Right(null);
  }
}
