import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:irllink/data/database/migrations/migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "irllink.db";
  static const _databaseVersion = 4;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Execute all migrations up to the current version
    for (var i = 1; i <= version; i++) {
      final migration = Migration.getMigration(i);
      if (migration != null) {
        await migration.up(db);
      }
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Execute all migrations between old and new version
    for (var i = oldVersion + 1; i <= newVersion; i++) {
      final migration = Migration.getMigration(i);
      if (migration != null) {
        await migration.up(db);
      }
    }
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    // Execute all migrations in reverse order
    for (var i = oldVersion; i > newVersion; i--) {
      final migration = Migration.getMigration(i);
      if (migration != null) {
        await migration.down(db);
      }
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  /// Exports the database to a JSON dump file
  /// Returns the file path where the dump was saved
  Future<String> exportDatabaseDump(String filePath) async {
    final db = await database;

    // Get all table names
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
    );

    Map<String, dynamic> dumpData = {
      'version': _databaseVersion,
      'exported_at': DateTime.now().toIso8601String(),
      'tables': {},
    };

    // Export data from each table
    for (final table in tables) {
      final tableName = table['name'] as String;
      final tableData = await db.query(tableName);
      dumpData['tables'][tableName] = tableData;
    }

    // Write to file
    final file = File(filePath);
    await file.writeAsString(jsonEncode(dumpData));

    return filePath;
  }

  /// Imports a database dump from a JSON file
  /// Handles version compatibility and runs necessary migrations
  Future<void> importDatabaseDump(String filePath) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Dump file not found: $filePath');
    }

    final dumpContent = await file.readAsString();
    final Map<String, dynamic> dumpData = jsonDecode(dumpContent);

    final dumpVersion = dumpData['version'] as int;
    final currentVersion = _databaseVersion;

    if (dumpVersion > currentVersion) {
      throw Exception(
          'Cannot import dump from newer version ($dumpVersion) to current version ($currentVersion). '
          'Please update the app first.');
    }

    // If dump is from older version, we need to close and recreate the database
    // to properly handle migrations
    if (dumpVersion < currentVersion) {
      await _recreateDatabaseWithMigrations(dumpVersion, currentVersion);
    }

    final db = await database;

    await db.transaction((txn) async {
      // Clear existing data (in reverse order to respect foreign keys)
      final clearOrder = [
        'channels', // References chat_groups
        'kick_credentials', // References kick_users
        'browser_tabs',
        'hidden_users',
        'chat_groups',
        'kick_users',
        'streamelements_credentials',
        'rtmp',
        'twitch_credentials',
      ];

      for (final tableName in clearOrder) {
        try {
          await txn.delete(tableName);
        } catch (e) {
          // Table might not exist in older versions, continue
        }
      }

      // Import data in correct order (respecting foreign keys)
      final importOrder = [
        'twitch_credentials',
        'rtmp',
        'streamelements_credentials',
        'kick_users',
        'kick_credentials',
        'hidden_users',
        'chat_groups',
        'channels',
        'browser_tabs',
      ];

      final tablesData = dumpData['tables'] as Map<String, dynamic>;

      for (final tableName in importOrder) {
        if (tablesData.containsKey(tableName)) {
          final tableData = tablesData[tableName] as List<dynamic>;

          for (final row in tableData) {
            final rowData = Map<String, dynamic>.from(row as Map);
            try {
              await txn.insert(tableName, rowData);
            } catch (e) {
              // Log error but continue with other rows
              debugPrint('Error inserting row into $tableName: $e');
            }
          }
        }
      }
    });
  }

  /// Helper method to recreate database with proper migrations
  Future<void> _recreateDatabaseWithMigrations(
    int fromVersion,
    int toVersion,
  ) async {
    // Close current database
    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    // Delete the database file
    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);

    // Recreate database which will trigger migrations through _onCreate
    await database;
  }
}
