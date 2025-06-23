import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/data/entities/obs_settings_dto.dart';
import 'package:irllink/src/data/entities/stream_elements/se_credentials_dto.dart';
import 'package:irllink/src/data/entities/twitch/twitch_credentials_dto.dart';
import 'package:sqflite/sqflite.dart';

abstract class Migration {
  final int version;

  const Migration(this.version);

  Future<void> up(Database db);
  Future<void> down(Database db);

  static Migration? getMigration(int version) {
    switch (version) {
      case 1:
        return Migration1();
      case 2:
        return Migration2();
      case 3:
        return Migration3();
      default:
        return null;
    }
  }
}

class Migration1 extends Migration {
  Migration1() : super(1);

  @override
  Future<void> up(Database db) async {
    // Create Twitch credentials table
    await db.execute('''
      CREATE TABLE twitch_credentials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        access_token TEXT NOT NULL,
        id_token TEXT NOT NULL,
        refresh_token TEXT NOT NULL,
        expires_in TEXT NOT NULL,
        decoded_id_token TEXT NOT NULL,
        twitch_user TEXT NOT NULL,
        scopes TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create RTMP settings table
    await db.execute('''
      CREATE TABLE rtmp (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        key TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create Kick users table
    await db.execute('''
      CREATE TABLE kick_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL UNIQUE,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        profile_picture TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create Kick credentials table
    await db.execute('''
      CREATE TABLE kick_credentials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        access_token TEXT NOT NULL,
        refresh_token TEXT NOT NULL,
        expires_in INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        scopes TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES kick_users(user_id)
      )
    ''');

    // Create StreamElements credentials table
    await db.execute('''
      CREATE TABLE streamelements_credentials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        access_token TEXT NOT NULL,
        refresh_token TEXT NOT NULL,
        expires_in INTEGER NOT NULL,
        scopes TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Migrate existing data from GetStorage to SQLite
    await _migrateGetStorageToSQLite(db);
  }

  Future<void> _migrateGetStorageToSQLite(Database db) async {
    final storage = GetStorage();

    // Migrate Twitch credentials
    final twitchDataString = storage.read('twitchData');
    if (twitchDataString != null) {
      try {
        final twitchDataJson = jsonDecode(twitchDataString);
        final credentials = TwitchCredentialsDTO.fromJson(twitchDataJson);

        await db.insert(
          'twitch_credentials',
          {
            'access_token': credentials.accessToken,
            'id_token': credentials.idToken,
            'refresh_token': credentials.refreshToken,
            'expires_in': credentials.expiresIn,
            'decoded_id_token': jsonEncode(credentials.decodedIdToken),
            'twitch_user': jsonEncode(credentials.twitchUser),
            'scopes': credentials.scopes,
          },
        );

        await storage.remove('twitchData');
      } catch (e) {
        debugPrint('Failed to migrate Twitch credentials: $e');
      }
    }

    // Migrate StreamElements credentials
    final seCredentialsString = storage.read('seCredentials');
    if (seCredentialsString != null) {
      try {
        final seCredentialsJson = jsonDecode(seCredentialsString);
        final credentials = SeCredentialsDTO.fromJson(seCredentialsJson);

        await db.insert(
          'streamelements_credentials',
          {
            'access_token': credentials.accessToken,
            'refresh_token': credentials.refreshToken,
            'expires_in': credentials.expiresIn,
            'scopes': credentials.scopes,
          },
        );

        await storage.remove('seCredentials');
      } catch (e) {
        debugPrint('Failed to migrate StreamElements credentials: $e');
      }
    }
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS twitch_credentials');
    await db.execute('DROP TABLE IF EXISTS rtmp');
    await db.execute('DROP TABLE IF EXISTS kick_credentials');
    await db.execute('DROP TABLE IF EXISTS kick_users');
    await db.execute('DROP TABLE IF EXISTS streamelements_credentials');
  }
}

class Migration2 extends Migration {
  Migration2() : super(2);

  @override
  Future<void> up(Database db) async {
    await db.execute(
      'CREATE TABLE hidden_users (id TEXT PRIMARY KEY, username TEXT NOT NULL, platform TEXT NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE chat_groups (id TEXT PRIMARY KEY)',
    );

    await db.execute(
      'CREATE TABLE channels (id TEXT PRIMARY KEY, channel TEXT NOT NULL, platform TEXT NOT NULL, chat_group_id TEXT NOT NULL, FOREIGN KEY (chat_group_id) REFERENCES chat_groups(id))',
    );

    // Create default chat group
    await db.insert('chat_groups', {'id': '-1'});

    try {
      final storage = GetStorage();
      final settings = storage.read('settings');
      if (settings != null) {
        final Map<String, dynamic> settingsJson = jsonDecode(settings);

        final firstGroupChannels =
            settingsJson['chatSettings']['permanentFirstGroup']['channels'];
        if (firstGroupChannels != null) {
          firstGroupChannels.forEach((channel) async {
            await db.insert('channels', {
              'id': channel['id'],
              'channel': channel['channel'],
              'platform': channel['platform'],
              'chat_group_id': '-1',
            });
          });
        }

        settingsJson['chatSettings']['chatGroups'].forEach((group) async {
          await db.insert('chat_groups', {'id': group['id']});
          group['channels'].forEach((channel) async {
            await db.insert('channels', {
              'id': channel['id'],
              'channel': channel['channel'],
              'platform': channel['platform'],
              'chat_group_id': group['id'],
            });
          });
        });

        // Remove chatSettings and hiddenUsers from settings after migration
        settingsJson.remove('hiddenUsersIds');
        settingsJson['chatSettings'].remove('chatGroups');
        settingsJson['chatSettings'].remove('permanentFirstGroup');
        await storage.write('settings', jsonEncode(settingsJson));
      }
    } catch (e) {
      debugPrint('Failed to migrate chat settings: $e');
    }
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS hidden_users');
    await db.execute('DROP TABLE IF EXISTS chat_groups');
    await db.execute('DROP TABLE IF EXISTS channels');
  }
}

class Migration3 extends Migration {
  Migration3() : super(3);

  @override
  Future<void> up(Database db) async {
    await db.execute(
      'CREATE TABLE browser_tabs (id TEXT PRIMARY KEY, url TEXT NOT NULL, title TEXT NOT NULL, toggled INTEGER NOT NULL, is_ios_audio_source INTEGER NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE dashboard_events (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color TEXT NOT NULL, dashboard_actions_type TEXT NOT NULL, event TEXT NOT NULL, custom_value TEXT NOT NULL)',
    );

    try {
      final storage = GetStorage();
      final settings = storage.read('settings');
      if (settings != null) {
        final Map<String, dynamic> settingsJson = jsonDecode(settings);

        // Migrate browser tabs
        final browserTabs = settingsJson['browserTabs']['tabs'];
        if (browserTabs != null) {
          browserTabs.forEach((tab) async {
            await db.insert('browser_tabs', {
              'id': tab['id'],
              'url': tab['url'],
              'title': tab['title'],
              'toggled': tab['toggled'],
              'is_ios_audio_source': tab['iOSAudioSource'],
            });
          });
          settingsJson.remove('browserTabs');
          await storage.write('settings', jsonEncode(settingsJson));
        }

        // Migrate OBS settings
        final obsUrl = settingsJson['obsWebsocketUrl'];
        final obsPassword = settingsJson['obsWebsocketPassword'];
        final obsIsConnected = settingsJson['isObsConnected'];

        if (obsUrl != null && obsPassword != null && obsIsConnected != null) {
          ObsSettingsDTO obsSettings = ObsSettingsDTO(
            url: obsUrl,
            password: obsPassword,
            isConnected: obsIsConnected,
          );
          await storage.write('obsSettings', jsonEncode(obsSettings.toJson()));
          settingsJson.remove('obsWebsocketUrl');
          settingsJson.remove('obsWebsocketPassword');
          settingsJson.remove('isObsConnected');
          await storage.write('settings', jsonEncode(settingsJson));
        }

        // Migrate TTS settings
        final ttsSettings = settingsJson['ttsSettings'];
        if (ttsSettings != null) {
          await storage.write('ttsSettings', jsonEncode(ttsSettings));
          settingsJson.remove('ttsSettings');
          await storage.write('settings', jsonEncode(settingsJson));
        }

        // Migrate StreamElements settings
        final seSettings = settingsJson['streamElementsSettings'];
        if (seSettings != null) {
          await storage.write('streamElementsSettings', jsonEncode(seSettings));
          settingsJson.remove('streamElementsSettings');
          await storage.write('settings', jsonEncode(settingsJson));
        }

        // Migrate dashboard events
        final dashboardEvents = settingsJson['dashboardSettings']['userEvents'];
        if (dashboardEvents != null) {
          dashboardEvents.forEach((event) async {
            await db.insert('dashboard_events', {
              'title': event['title'],
              'color': event['color'],
              'dashboard_actions_type': event['dashboardActionsType'],
              'event': event['event'],
              'custom_value': event['customValue'],
            });
          });
          settingsJson.remove('dashboardSettings');
          await storage.write('settings', jsonEncode(settingsJson));
        }
      }
    } catch (e) {
      debugPrint('Failed to migrate browser tabs: $e');
    }
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS browser_tabs');
  }
}
