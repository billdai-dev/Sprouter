import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _DbName);
    Database db =
        await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return db;
  }

  void _onCreateDatabase(Database db, int version) async {
    await db.execute("""
        CREATE TABLE User(id INTEGER PRIMARY KEY NOT NULL, name TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TABLE Drink(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price INTEGER, ice TEXT, sugar TEXT, pearl TEXT, coconut TEXT, cup_size TEXT, other_ingredient TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TABLE Shop(name TEXT PRIMARY KEY, thread_ts TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TABLE Order(id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, shop_name TEXT, thread_ts TEXT, drink_id INTEGER, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')), FOREIGN KEY(user_id) REFERENCES User(id), FOREIGN KEY(shop_name, thread_ts) REFERENCES Shop(name, thread_ts), FOREIGN KEY(drink_id) REFERENCES Drink(id))
        """);
  }
}
