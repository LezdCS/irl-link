import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/src/data/entities/obs_settings_dto.dart';
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
      case 4:
        return Migration4();
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

        await db.insert(
          'twitch_credentials',
          {
            'access_token': twitchDataJson['accessToken'],
            'id_token': twitchDataJson['idToken'],
            'refresh_token': twitchDataJson['refreshToken'],
            'expires_in': twitchDataJson['expiresIn'],
            'decoded_id_token': jsonEncode(twitchDataJson['decodedIdToken']),
            'twitch_user': jsonEncode(twitchDataJson['twitchUser']),
            'scopes': twitchDataJson['scopes'],
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

        await db.insert(
          'streamelements_credentials',
          {
            'access_token': seCredentialsJson['accessToken'],
            'refresh_token': seCredentialsJson['refreshToken'],
            'expires_in': seCredentialsJson['expiresIn'],
            'scopes': seCredentialsJson['scopes'],
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
      'CREATE TABLE dashboard_events (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color INTEGER NOT NULL, dashboard_actions_type TEXT NOT NULL, event TEXT NOT NULL, custom_value TEXT NOT NULL)',
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

class Migration4 extends Migration {
  Migration4() : super(4);

  @override
  Future<void> up(Database db) async {
    // Create TTS settings table
    await db.execute('''
      CREATE TABLE tts_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tts_enabled INTEGER NOT NULL DEFAULT 0,
        language TEXT NOT NULL DEFAULT 'en-US',
        volume REAL NOT NULL DEFAULT 1.0,
        pitch REAL NOT NULL DEFAULT 1.0,
        rate REAL NOT NULL DEFAULT 0.5,
        voice_name TEXT NOT NULL DEFAULT 'en-us-x-sfg-local',
        voice_locale TEXT NOT NULL DEFAULT 'en-US',
        tts_mute_viewer_name INTEGER NOT NULL DEFAULT 0,
        tts_only_vip INTEGER NOT NULL DEFAULT 0,
        tts_only_mod INTEGER NOT NULL DEFAULT 0,
        tts_only_subscriber INTEGER NOT NULL DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create TTS prefixes to ignore table
    await db.execute('''
      CREATE TABLE tts_prefixes_to_ignore (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tts_settings_id INTEGER NOT NULL,
        prefix TEXT NOT NULL,
        FOREIGN KEY (tts_settings_id) REFERENCES tts_settings(id) ON DELETE CASCADE
      )
    ''');

    // Create TTS prefixes to use TTS only table
    await db.execute('''
      CREATE TABLE tts_prefixes_to_use_tts_only (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tts_settings_id INTEGER NOT NULL,
        prefix TEXT NOT NULL,
        FOREIGN KEY (tts_settings_id) REFERENCES tts_settings(id) ON DELETE CASCADE
      )
    ''');

    // Create TTS users to ignore table
    await db.execute('''
      CREATE TABLE tts_users_to_ignore (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tts_settings_id INTEGER NOT NULL,
        username TEXT NOT NULL,
        FOREIGN KEY (tts_settings_id) REFERENCES tts_settings(id) ON DELETE CASCADE
      )
    ''');

    // Create OBS settings table
    await db.execute('''
      CREATE TABLE obs_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT NOT NULL DEFAULT '',
        password TEXT NOT NULL DEFAULT '',
        is_connected INTEGER NOT NULL DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create StreamElements settings table
    await db.execute('''
      CREATE TABLE streamelements_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        show_follower_activity INTEGER NOT NULL DEFAULT 1,
        show_subscriber_activity INTEGER NOT NULL DEFAULT 1,
        show_donation_activity INTEGER NOT NULL DEFAULT 1,
        show_cheer_activity INTEGER NOT NULL DEFAULT 1,
        show_raid_activity INTEGER NOT NULL DEFAULT 1,
        show_host_activity INTEGER NOT NULL DEFAULT 1,
        show_merch_activity INTEGER NOT NULL DEFAULT 1,
        jwt TEXT,
        overlay_token TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create StreamElements muted overlays table
    await db.execute('''
      CREATE TABLE streamelements_muted_overlays (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        streamelements_settings_id INTEGER NOT NULL,
        overlay_name TEXT NOT NULL,
        FOREIGN KEY (streamelements_settings_id) REFERENCES streamelements_settings(id) ON DELETE CASCADE
      )
    ''');

    try {
      final storage = GetStorage();
      final settings = storage.read('settings');
      if (settings != null) {
        final Map<String, dynamic> settingsJson = jsonDecode(settings);

        // Migrate TTS settings
        final ttsSettings = settingsJson['ttsSettings'];
        if (ttsSettings != null) {
          // Insert main TTS settings
          int ttsSettingsId = await db.insert('tts_settings', {
            'tts_enabled': ttsSettings['ttsEnabled'] == true ? 1 : 0,
            'language': ttsSettings['language'] ?? 'en-US',
            'volume': ttsSettings['volume'] ?? 1.0,
            'pitch': ttsSettings['pitch'] ?? 1.0,
            'rate': ttsSettings['rate'] ?? 0.5,
            'voice_name': ttsSettings['voice']?['name'] ?? 'en-us-x-sfg-local',
            'voice_locale': ttsSettings['voice']?['locale'] ?? 'en-US',
            'tts_mute_viewer_name':
                ttsSettings['ttsMuteViewerName'] == true ? 1 : 0,
            'tts_only_vip': ttsSettings['ttsOnlyVip'] == true ? 1 : 0,
            'tts_only_mod': ttsSettings['ttsOnlyMod'] == true ? 1 : 0,
            'tts_only_subscriber':
                ttsSettings['ttsOnlySubscriber'] == true ? 1 : 0,
          });

          // Migrate prefixes to ignore
          final prefixsToIgnore = ttsSettings['prefixsToIgnore'] as List?;
          if (prefixsToIgnore != null) {
            for (String prefix in prefixsToIgnore) {
              await db.insert('tts_prefixes_to_ignore', {
                'tts_settings_id': ttsSettingsId,
                'prefix': prefix,
              });
            }
          }

          // Migrate prefixes to use TTS only
          final prefixsToUseTtsOnly =
              ttsSettings['prefixsToUseTtsOnly'] as List?;
          if (prefixsToUseTtsOnly != null) {
            for (String prefix in prefixsToUseTtsOnly) {
              await db.insert('tts_prefixes_to_use_tts_only', {
                'tts_settings_id': ttsSettingsId,
                'prefix': prefix,
              });
            }
          }

          // Migrate users to ignore
          final ttsUsersToIgnore = ttsSettings['ttsUsersToIgnore'] as List?;
          if (ttsUsersToIgnore != null) {
            for (String username in ttsUsersToIgnore) {
              await db.insert('tts_users_to_ignore', {
                'tts_settings_id': ttsSettingsId,
                'username': username,
              });
            }
          }

          // Remove TTS settings from main settings JSON
          settingsJson.remove('ttsSettings');
        }

        // Migrate OBS settings
        final obsSettings = storage.read('obsSettings');
        if (obsSettings != null) {
          final obsSettingsJson = jsonDecode(obsSettings);

          await db.insert('obs_settings', {
            'url': obsSettingsJson['url'] ?? '',
            'password': obsSettingsJson['password'] ?? '',
            'is_connected': obsSettingsJson['isConnected'] == true ? 1 : 0,
          });

          // Remove OBS settings from GetStorage
          await storage.remove('obsSettings');
        }

        // Migrate StreamElements settings
        final seSettings = storage.read('streamelements_settings');
        if (seSettings != null) {
          final seSettingsJson = jsonDecode(seSettings);

          // Insert main StreamElements settings
          int seSettingsId = await db.insert('streamelements_settings', {
            'show_follower_activity':
                seSettingsJson['showFollowerActivity'] == true ? 1 : 0,
            'show_subscriber_activity':
                seSettingsJson['showSubscriberActivity'] == true ? 1 : 0,
            'show_donation_activity':
                seSettingsJson['showDonationActivity'] == true ? 1 : 0,
            'show_cheer_activity':
                seSettingsJson['showCheerActivity'] == true ? 1 : 0,
            'show_raid_activity':
                seSettingsJson['showRaidActivity'] == true ? 1 : 0,
            'show_host_activity':
                seSettingsJson['showHostActivity'] == true ? 1 : 0,
            'show_merch_activity':
                seSettingsJson['showMerchActivity'] == true ? 1 : 0,
            'jwt': seSettingsJson['jwt'],
            'overlay_token': seSettingsJson['overlayToken'],
          });

          // Migrate muted overlays
          final mutedOverlays = seSettingsJson['mutedOverlays'] as List?;
          if (mutedOverlays != null) {
            for (String overlayName in mutedOverlays) {
              await db.insert('streamelements_muted_overlays', {
                'streamelements_settings_id': seSettingsId,
                'overlay_name': overlayName,
              });
            }
          }

          // Remove StreamElements settings from GetStorage
          await storage.remove('streamelements_settings');
        }

        await storage.write('settings', jsonEncode(settingsJson));
      }
    } catch (e) {
      debugPrint('Failed to migrate TTS, OBS, and StreamElements settings: $e');
    }
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS tts_prefixes_to_ignore');
    await db.execute('DROP TABLE IF EXISTS tts_prefixes_to_use_tts_only');
    await db.execute('DROP TABLE IF EXISTS tts_users_to_ignore');
    await db.execute('DROP TABLE IF EXISTS tts_settings');
    await db.execute('DROP TABLE IF EXISTS obs_settings');
    await db.execute('DROP TABLE IF EXISTS streamelements_muted_overlays');
    await db.execute('DROP TABLE IF EXISTS streamelements_settings');
  }
}
