import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/data/entities/settings/chat_settings_dto.dart';
import 'package:irllink/src/data/entities/settings/hidden_user_dto.dart';
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
      where: 'channel = ? AND chat_group_id = ?',
      whereArgs: [channel.channel, chatGroup.id],
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
}
