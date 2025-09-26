import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/dashboard_event_dto.dart';
import 'package:irllink/src/data/entities/obs_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/browser_tab_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/hidden_user_dto.dart';
import 'package:irllink/src/data/entities/settings/tts_settings_dto.dart';
import 'package:irllink/src/data/entities/settings_dto.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsDTO?> getSettings();
  Future<void> setSettings(SettingsDTO settings);
  Future<void> addHiddenUser(HiddenUserDTO hiddenUser);
  Future<void> removeHiddenUser(HiddenUserDTO hiddenUser);
  Future<List<HiddenUserDTO>?> getHiddenUsers();
  Future<void> addChatGroup(ChatGroupDTO chatGroup);
  Future<void> removeChatGroup(ChatGroupDTO chatGroup);
  Future<void> addChannel(ChatGroupDTO chatGroup, ChannelDTO channel);
  Future<void> removeChannel(ChatGroupDTO chatGroup, ChannelDTO channel);
  Future<List<ChatGroupDTO>?> getChatGroups();
  Future<void> addBrowserTab(BrowserTabDTO browserTab);
  Future<void> editBrowserTab(BrowserTabDTO browserTab);
  Future<void> removeBrowserTab(BrowserTabDTO browserTab);
  Future<List<BrowserTabDTO>?> getBrowserTabs();
  Future<void> updateObsSettings(ObsSettingsDTO obsSettings);
  Future<ObsSettingsDTO?> getObsCredentials();
  Future<TtsSettingsDTO?> getTtsSettings();
  Future<void> setTtsSettings(TtsSettingsDTO ttsSettings);
  Future<void> addDashboardEvent(DashboardEventDTO dashboardEvent);
  Future<void> removeDashboardEvent(DashboardEventDTO dashboardEvent);
  Future<List<DashboardEventDTO>?> getDashboardEvents();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Talker talker;
  final GetStorage _storage;
  final DatabaseHelper _databaseHelper;

  SettingsLocalDataSourceImpl({
    required this.talker,
    GetStorage? storage,
    DatabaseHelper? databaseHelper,
  })  : _storage = storage ?? GetStorage(),
        _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  @override
  Future<SettingsDTO?> getSettings() async {
    talker.logCustom(SettingsLog('Retrieving settings from local storage.'));
    var settingsString = _storage.read('settings');
    if (settingsString != null) {
      talker.logCustom(SettingsLog('Settings found in local storage.'));
      Map<String, dynamic> settingsJson = jsonDecode(settingsString);
      SettingsDTO settingsDTO = SettingsDTO.fromJson(settingsJson);
      talker.logCustom(SettingsLog('Settings JSON: $settingsJson'));
      return settingsDTO;
    }
    talker.info('No settings found in local storage.');
    return null;
  }

  @override
  Future<void> setSettings(SettingsDTO settings) async {
    String settingsJson = jsonEncode(settings.toJson());
    talker.logCustom(
      SettingsLog('Saving settings to local storage: $settingsJson'),
    );
    await _storage.write('settings', settingsJson);
  }

  @override
  Future<void> addHiddenUser(HiddenUserDTO hiddenUser) async {
    final db = await _databaseHelper.database;
    await db.insert('hidden_users', hiddenUser.toJson());
  }

  @override
  Future<void> removeHiddenUser(HiddenUserDTO hiddenUser) async {
    final db = await _databaseHelper.database;
    await db
        .delete('hidden_users', where: 'id = ?', whereArgs: [hiddenUser.id]);
  }

  @override
  Future<List<HiddenUserDTO>?> getHiddenUsers() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('hidden_users');
    return maps.map((map) => HiddenUserDTO.fromJson(map)).toList();
  }

  @override
  Future<void> addChatGroup(ChatGroupDTO chatGroup) async {
    final db = await _databaseHelper.database;
    await db.insert('chat_groups', {'id': chatGroup.id});
  }

  @override
  Future<void> removeChatGroup(ChatGroupDTO chatGroup) async {
    final db = await _databaseHelper.database;
    await db.delete('chat_groups', where: 'id = ?', whereArgs: [chatGroup.id]);
  }

  @override
  Future<void> addChannel(ChatGroupDTO chatGroup, ChannelDTO channel) async {
    final db = await _databaseHelper.database;
    final chatGroupId = chatGroup.id;
    await db.insert(
      'channels',
      channel.toJson()..['chat_group_id'] = chatGroupId,
    );
  }

  @override
  Future<void> removeChannel(ChatGroupDTO chatGroup, ChannelDTO channel) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'channels',
      where: 'channel = ? AND chat_group_id = ? AND platform = ?',
      whereArgs: [
        channel.channel,
        chatGroup.id,
        channel.platform.name,
      ],
    );
  }

  @override
  Future<List<ChatGroupDTO>?> getChatGroups() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('chat_groups');

    List<Map<String, dynamic>> mutableMaps = [];
    for (var map in maps) {
      // Create a new mutable map with the existing data
      Map<String, dynamic> mutableMap = Map<String, dynamic>.from(map);

      List<Map<String, dynamic>> channelsMaps = await db.query(
        'channels',
        where: 'chat_group_id = ?',
        whereArgs: [map['id']],
      );
      mutableMap['channels'] = channelsMaps;
      mutableMaps.add(mutableMap);
    }
    return mutableMaps.map((map) => ChatGroupDTO.fromJson(map)).toList();
  }

  @override
  Future<void> addBrowserTab(BrowserTabDTO browserTab) async {
    final db = await _databaseHelper.database;
    await db.insert('browser_tabs', browserTab.toJson());
  }

  @override
  Future<void> editBrowserTab(BrowserTabDTO browserTab) async {
    final db = await _databaseHelper.database;
    await db.update(
      'browser_tabs',
      browserTab.toJson(),
      where: 'id = ?',
      whereArgs: [browserTab.id],
    );
  }

  @override
  Future<void> removeBrowserTab(BrowserTabDTO browserTab) async {
    final db = await _databaseHelper.database;
    await db
        .delete('browser_tabs', where: 'id = ?', whereArgs: [browserTab.id]);
  }

  @override
  Future<List<BrowserTabDTO>?> getBrowserTabs() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('browser_tabs');
    return maps.map((map) => BrowserTabDTO.fromJson(map)).toList();
  }

  @override
  Future<void> updateObsSettings(ObsSettingsDTO obsSettings) async {
    final db = await _databaseHelper.database;

    // Check if OBS settings already exist
    final existingSettings = await db.query('obs_settings');

    if (existingSettings.isNotEmpty) {
      // Update existing settings
      await db.update(
        'obs_settings',
        {
          'url': obsSettings.url,
          'password': obsSettings.password,
          'is_connected': obsSettings.isConnected ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [existingSettings.first['id']],
      );
    } else {
      // Insert new settings
      await db.insert('obs_settings', {
        'url': obsSettings.url,
        'password': obsSettings.password,
        'is_connected': obsSettings.isConnected ? 1 : 0,
      });
    }
  }

  @override
  Future<ObsSettingsDTO?> getObsCredentials() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> obsSettingsMaps =
        await db.query('obs_settings');

    if (obsSettingsMaps.isNotEmpty) {
      final obsSettingsMap = obsSettingsMaps.first;
      return ObsSettingsDTO(
        url: obsSettingsMap['url'],
        password: obsSettingsMap['password'],
        isConnected: obsSettingsMap['is_connected'] == 1,
      );
    }

    return const ObsSettingsDTO(
      url: '',
      password: '',
      isConnected: false,
    );
  }

  @override
  Future<TtsSettingsDTO?> getTtsSettings() async {
    final db = await _databaseHelper.database;

    // Get the main TTS settings
    final List<Map<String, dynamic>> ttsSettingsMaps =
        await db.query('tts_settings');

    if (ttsSettingsMaps.isEmpty) {
      return TtsSettingsDTO();
    }

    final ttsSettingsMap = ttsSettingsMaps.first;
    final ttsSettingsId = ttsSettingsMap['id'];

    // Get the related lists
    final prefixesToIgnore = await db.query(
      'tts_prefixes_to_ignore',
      where: 'tts_settings_id = ?',
      whereArgs: [ttsSettingsId],
    );

    final prefixesToUseTtsOnly = await db.query(
      'tts_prefixes_to_use_tts_only',
      where: 'tts_settings_id = ?',
      whereArgs: [ttsSettingsId],
    );

    final usersToIgnore = await db.query(
      'tts_users_to_ignore',
      where: 'tts_settings_id = ?',
      whereArgs: [ttsSettingsId],
    );

    // Build the TtsSettingsDTO
    return TtsSettingsDTO(
      ttsEnabled: ttsSettingsMap['tts_enabled'] == 1,
      language: ttsSettingsMap['language'],
      prefixsToIgnore: prefixesToIgnore.map((e) => e['prefix']).toList(),
      prefixsToUseTtsOnly:
          prefixesToUseTtsOnly.map((e) => e['prefix']).toList(),
      volume: ttsSettingsMap['volume'],
      pitch: ttsSettingsMap['pitch'],
      rate: ttsSettingsMap['rate'],
      voice: {
        'name': ttsSettingsMap['voice_name'],
        'locale': ttsSettingsMap['voice_locale'],
      },
      ttsUsersToIgnore: usersToIgnore.map((e) => e['username']).toList(),
      ttsMuteViewerName: ttsSettingsMap['tts_mute_viewer_name'] == 1,
      ttsOnlyVip: ttsSettingsMap['tts_only_vip'] == 1,
      ttsOnlyMod: ttsSettingsMap['tts_only_mod'] == 1,
      ttsOnlySubscriber: ttsSettingsMap['tts_only_subscriber'] == 1,
    );
  }

  @override
  Future<void> setTtsSettings(TtsSettingsDTO ttsSettings) async {
    final db = await _databaseHelper.database;

    // Check if TTS settings already exist
    final existingSettings = await db.query('tts_settings');

    int ttsSettingsId;

    if (existingSettings.isNotEmpty) {
      // Update existing settings
      ttsSettingsId = existingSettings.first['id'] as int;

      await db.update(
        'tts_settings',
        {
          'tts_enabled': ttsSettings.ttsEnabled ? 1 : 0,
          'language': ttsSettings.language,
          'volume': ttsSettings.volume,
          'pitch': ttsSettings.pitch,
          'rate': ttsSettings.rate,
          'voice_name': ttsSettings.voice['name'] ?? 'en-us-x-sfg-local',
          'voice_locale': ttsSettings.voice['locale'] ?? 'en-US',
          'tts_mute_viewer_name': ttsSettings.ttsMuteViewerName ? 1 : 0,
          'tts_only_vip': ttsSettings.ttsOnlyVip ? 1 : 0,
          'tts_only_mod': ttsSettings.ttsOnlyMod ? 1 : 0,
          'tts_only_subscriber': ttsSettings.ttsOnlySubscriber ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [ttsSettingsId],
      );

      // Delete existing related records
      await db.delete(
        'tts_prefixes_to_ignore',
        where: 'tts_settings_id = ?',
        whereArgs: [ttsSettingsId],
      );
      await db.delete(
        'tts_prefixes_to_use_tts_only',
        where: 'tts_settings_id = ?',
        whereArgs: [ttsSettingsId],
      );
      await db.delete(
        'tts_users_to_ignore',
        where: 'tts_settings_id = ?',
        whereArgs: [ttsSettingsId],
      );
    } else {
      // Insert new settings
      ttsSettingsId = await db.insert('tts_settings', {
        'tts_enabled': ttsSettings.ttsEnabled ? 1 : 0,
        'language': ttsSettings.language,
        'volume': ttsSettings.volume,
        'pitch': ttsSettings.pitch,
        'rate': ttsSettings.rate,
        'voice_name': ttsSettings.voice['name'] ?? 'en-us-x-sfg-local',
        'voice_locale': ttsSettings.voice['locale'] ?? 'en-US',
        'tts_mute_viewer_name': ttsSettings.ttsMuteViewerName ? 1 : 0,
        'tts_only_vip': ttsSettings.ttsOnlyVip ? 1 : 0,
        'tts_only_mod': ttsSettings.ttsOnlyMod ? 1 : 0,
        'tts_only_subscriber': ttsSettings.ttsOnlySubscriber ? 1 : 0,
      });
    }

    // Insert prefixes to ignore
    for (String prefix in ttsSettings.prefixsToIgnore) {
      await db.insert('tts_prefixes_to_ignore', {
        'tts_settings_id': ttsSettingsId,
        'prefix': prefix,
      });
    }

    // Insert prefixes to use TTS only
    for (String prefix in ttsSettings.prefixsToUseTtsOnly) {
      await db.insert('tts_prefixes_to_use_tts_only', {
        'tts_settings_id': ttsSettingsId,
        'prefix': prefix,
      });
    }

    // Insert users to ignore
    for (String username in ttsSettings.ttsUsersToIgnore) {
      await db.insert('tts_users_to_ignore', {
        'tts_settings_id': ttsSettingsId,
        'username': username,
      });
    }
  }

  @override
  Future<void> addDashboardEvent(DashboardEventDTO dashboardEvent) async {
    final db = await _databaseHelper.database;

    // Convert to JSON and remove id if it's null to let auto-increment work
    Map<String, dynamic> eventData = dashboardEvent.toJson();
    if (dashboardEvent.id == null) {
      eventData.remove('id');
    }

    await db.insert('dashboard_events', eventData);
  }

  @override
  Future<void> removeDashboardEvent(DashboardEventDTO dashboardEvent) async {
    final db = await _databaseHelper.database;

    // Only delete if we have a valid ID
    if (dashboardEvent.id != null) {
      await db.delete(
        'dashboard_events',
        where: 'id = ?',
        whereArgs: [dashboardEvent.id],
      );
    }
  }

  @override
  Future<List<DashboardEventDTO>?> getDashboardEvents() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('dashboard_events');
    return maps.map((map) => DashboardEventDTO.fromJson(map)).toList();
  }
}
