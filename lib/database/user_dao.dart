import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
class UserDao {
  static const _databaseName = "users.db";
  static const _tableName = "users";
  static Future _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
 CREATE TABLE $_tableName (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 email TEXT UNIQUE,
 password TEXT
 )
 ''');
      },
    );
  }

  static Future insertUser(UserModel user) async {
    final db = await _getDatabase();
    await db.insert(_tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future getUserByEmail(String email) async {
    final db = await _getDatabase();
    final result = await db.query(
      _tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }
}