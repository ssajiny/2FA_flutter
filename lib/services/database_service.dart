import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/models/site.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'otp3.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, siteId INTEGER, color INTEGER, secretKey TEXT, FOREIGN KEY (siteId) REFERENCES sites(id) ON DELETE SET NULL)',
    );
    await db.execute(
      'CREATE TABLE sites(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)',
    );
  }

  Future<void> insertAccount(Account account) async {
    final db = await _databaseService.database;
    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSite(Site site) async {
    final db = await _databaseService.database;
    await db.insert(
      'sites',
      site.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Account>> accounts() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('accounts');
    return List.generate(maps.length, (index) => Account.fromMap(maps[index]));
  }

  Future<Account> account(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('accounts', where: 'id = ?', whereArgs: [id]);
    return Account.fromMap(maps[0]);
  }

  Future<List<Site>> sites() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('sites');
    return List.generate(maps.length, (index) => Site.fromMap(maps[index]));
  }

  Future<Site> site(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('sites', where: 'id = ?', whereArgs: [id]);
    if (maps?.isNotEmpty ?? false) {
      return Site.fromMap(maps[0]);
    } else {
      return Site(name: 'No Site', description: '');
    }
  }

  Future<void> updateAccount(Account account) async {
    final db = await _databaseService.database;
    await db.update('accounts', account.toMap(),
        where: 'id = ?', whereArgs: [account.id]);
  }

  Future<void> deleteAccount(int id) async {
    final db = await _databaseService.database;
    await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteSite(int id) async {
    final db = await _databaseService.database;
    await db.delete('sites', where: 'id = ?', whereArgs: [id]);
  }
}
