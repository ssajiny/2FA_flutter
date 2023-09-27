import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBConnect {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'demo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String sql = '''
                CREATE TABLE Test(
                  No INTEGER PRIMARY KEY AUTOINCREMENT,
                  UserID TEXT,
                  Content TEXT)
                ''';

    db.execute(sql);
  }

  Future<void> insertData(String userId, String content) async {
    final Database db = await database;
    await db.insert(
      'Test',
      {'UserID': userId, 'Content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final Database db = await database;
    return await db.query('Test');
  }
}
