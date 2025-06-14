import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
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
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS hidden_users');
  }
}
