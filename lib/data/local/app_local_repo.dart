import 'dart:async';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sqflite/sqflite.dart';

class AppLocalRepo implements LocalRepo {
  static const String _DbName = "sprouter.db";
  static const String _KEY_SLACK_ACCESS_TOKEN = "slack_access_token";

  static final AppLocalRepo _repo = new AppLocalRepo.internal();

  static AppLocalRepo get repo => _repo;

  static Database _db;

  AppLocalRepo.internal();

  @override
  Future<Database> openDB() async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDB();
    return _db;
  }

  @override
  Future<void> saveSlackToken(String token) async {
    return SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setString(_KEY_SLACK_ACCESS_TOKEN, token));
  }

  @override
  Future<String> loadSlackToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(_KEY_SLACK_ACCESS_TOKEN);
    return accessToken;
  }

  @override
  Future<void> saveUserData(String id, String name, String token) async {
    await SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setString(_KEY_SLACK_ACCESS_TOKEN, token));
    Database db = await openDB();
    await db?.insert("User", {"user_id": id, "name": name, "token": token},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.update("User", {"name": name, "token": token},
        where: "user_id = ?", whereArgs: [id]);
  }

  Future<Database> _initDB() async {
    String dirPath = await getDatabasesPath();
    String path = join(dirPath, _DbName);
    Database db =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return db;
  }

  void _onCreateDatabase(Database db, int version) async {
    await db.execute("""
        CREATE TABLE User(user_id TEXT PRIMARY KEY NOT NULL, name TEXT, token TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TRIGGER on_user_updated AFTER UPDATE ON User
         BEGIN UPDATE User SET updated_date = datetime('now') WHERE user_id = new.user_id;
         END
        """);

    await db.execute("""
        CREATE TABLE Drink(drink_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price INTEGER, ice TEXT, sugar TEXT, pearl TEXT, coconut TEXT, cup_size TEXT, other_ingredient TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TRIGGER on_drink_updated AFTER UPDATE ON Drink
         BEGIN UPDATE Drink SET updated_date = datetime('now') WHERE drink_id = new.drink_id;
         END
        """);

    await db.execute("""
        CREATE TABLE Shop(shop_name TEXT, thread_ts TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')), PRIMARY KEY (shop_name, thread_ts))
        """);

    await db.execute("""
        CREATE TRIGGER on_shop_updated AFTER UPDATE ON Shop
         BEGIN UPDATE Shop SET updated_date = datetime('now') WHERE shop_name = new.shop_name AND thread_ts = new.thread_ts;
         END
        """);

    await db.execute("""
        CREATE TABLE DrinkOrder (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT, shop_name TEXT, thread_ts TEXT, drink_id INTEGER, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')), FOREIGN KEY (user_id) REFERENCES User (user_id), FOREIGN KEY (shop_name, thread_ts) REFERENCES Shop (shop_name, thread_ts), FOREIGN KEY (drink_id) REFERENCES Drink (drink_id))
        """);

    await db.execute("""
        CREATE TRIGGER on_drink_order_updated AFTER UPDATE ON DrinkOrder
         BEGIN UPDATE DrinkOrder SET updated_date = datetime('now') WHERE id = new.id;
         END
        """);
  }
}
