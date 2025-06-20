import 'package:irllink/data/database/migrations/migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "irllink.db";
  static const _databaseVersion = 3;

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
}
