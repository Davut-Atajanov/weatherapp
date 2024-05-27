import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherapp/models/db_user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullname TEXT, email TEXT, phoneNumber TEXT, address TEXT, city TEXT, state TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(DBUser user) async {
    final db = await database;
    // First, delete all existing records in the users table
    await db.delete('users');

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DBUser>> users() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return DBUser(
        id: maps[i]['id'],
        fullname: maps[i]['fullname'],
        email: maps[i]['email'],
        phoneNumber: maps[i]['phoneNumber'],
        address: maps[i]['address'],
        city: maps[i]['city'],
        state: maps[i]['state'],
      );
    });
  }
}
