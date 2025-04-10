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
    // Add your initial table creation SQL here
    // Example:
    // await db.execute('''
    //   CREATE TABLE example (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     name TEXT NOT NULL,
    //     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    //   )
    // ''');
  }

  @override
  Future<void> down(Database db) async {
    // Add your table deletion SQL here
    // Example:
    // await db.execute('DROP TABLE IF EXISTS example');
  }
}
