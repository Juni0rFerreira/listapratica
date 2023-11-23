// ignore_for_file: depend_on_referenced_packages, empty_catches

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      amount TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(
      String title, String? desc, String? amount) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'desc': desc,
      'amount': amount,
    };
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('data', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id, String title, String? desc, String? amount) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'desc': desc,
      'amount': amount,
      'createAt': DateTime.now().toString()
    };
    final result =
        await db.update('data', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('data', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }
}

// user_model.dart
class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// db_helper.dart
class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT
        )
      ''');
    });
  }

  Future<void> insertUser(User user) async {
  final Database db = await database;
  await db.insert('users', user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace); // Esta é a linha
}


  Future<User?> getUser() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        email: maps[0]['email'],
      );
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    final Database db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int userId) async {
    final Database db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> updateUserName(String userEmail, String newName) async {
    final Database db = await database;

    await db.update(
      'users',
      {'name': newName},
      where: 'email = ?',
      whereArgs: [userEmail],
    );
  }

  Future<void> updateUserEmail(String userEmail, String newEmail) async {
  final Database db = await database;

  await db.update(
    'users',
    {'email': newEmail},
    where: 'email = ?',
    whereArgs: [userEmail],
  );
}

}
