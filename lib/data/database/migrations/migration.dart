import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
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
      default:
        return null;
    }
  }
}

class Migration1 extends Migration {
  Migration1() : super(1);

  @override
  Future<void> up(Database db) async {
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

    // Migrate existing data from GetStorage to SQLite
    await _migrateGetStorageToSQLite(db);
  }

  Future<void> _migrateGetStorageToSQLite(Database db) async {
    final storage = GetStorage();
    final twitchDataString = storage.read('twitchData');

    if (twitchDataString != null) {
      try {
        // Parse the existing data
        final twitchDataJson = jsonDecode(twitchDataString);
        final credentials = TwitchCredentialsDTO.fromJson(twitchDataJson);

        // Insert into SQLite
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

        // Remove old data from GetStorage
        await storage.remove('twitchData');
      } catch (e) {
        // If migration fails, we'll just start fresh with SQLite
        // The old data will remain in GetStorage but won't be used
        debugPrint('Failed to migrate Twitch credentials: $e');
      }
    }
  }

  @override
  Future<void> down(Database db) async {
    await db.execute('DROP TABLE IF EXISTS twitch_credentials');
  }
}
