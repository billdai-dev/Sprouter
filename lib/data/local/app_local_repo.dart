import 'dart:async';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sprouter/util/utils.dart';
import 'package:sqflite/sqflite.dart';

class AppLocalRepo implements LocalRepo {
  static const String _DbName = "sprouter.db";
  static const String _keySlackAccessToken = "slackAccessToken";
  static const String _keyUserId = "keyUserId";
  static const String _keyUserName = "keyUserName";

  static final AppLocalRepo _repo = new AppLocalRepo.internal();

  static AppLocalRepo get repo => _repo;

  static Database _db;

  AppLocalRepo.internal();

  @override
  Future<void> saveSlackToken(String token) {
    return SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setString(_keySlackAccessToken, token));
  }

  @override
  Future<String> loadSlackToken() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(_keySlackAccessToken));
  }

  @override
  Future<String> loadUserId() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(_keyUserId));
  }

  @override
  Future<String> loadUserName() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(_keyUserName));
  }

  @override
  Future<void> saveUserData(String id, String name, String token) async {
    await SharedPreferences.getInstance().then((sharedPreferences) {
      return Future.wait([
        sharedPreferences.setString(_keySlackAccessToken, token),
        sharedPreferences.setString(_keyUserName, name),
        sharedPreferences.setString(_keyUserId, id)
      ]);
    });
    Database db = await openDB();
    await db?.insert("User", {"user_id": id, "name": name, "token": token},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.update("User", {"name": name, "token": token},
        where: "user_id = ?", whereArgs: [id]);
  }

  @override
  Future<Database> openDB() async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDB();
    return _db;
  }

  @override
  Future<void> addShopToDB(String shopName, String threadTs) async {
    if (Utils.isStringNullOrEmpty(shopName) ||
        Utils.isStringNullOrEmpty(threadTs)) {
      return;
    }
    Database db = await openDB();
    await db.insert("Shop", {"shop_name": shopName, "thread_ts": threadTs},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<int> addDrinkToDB(Drink drink,
      {String threadTs, String orderTs}) async {
    Database db = await openDB();
    Map<String, dynamic> drinkIds;
    if (!Utils.isStringNullOrEmpty(threadTs) &&
        !Utils.isStringNullOrEmpty(orderTs)) {
      drinkIds = (await db.rawQuery("""
    SELECT Drink.drink_id FROM Drink JOIN DrinkOrder ON Drink.drink_id = DrinkOrder.drink_id 
    WHERE DrinkOrder.thread_ts = ? AND DrinkOrder.order_ts = ?;
    """, [threadTs, orderTs]))?.first;
    }
    int drinkId =
        Utils.isMapNullOrEmpty(drinkIds) ? null : drinkIds["drink_id"];
    if (drinkId == null) {
      drinkId = await db.insert("Drink", drink.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } else {
      await db.update("Drink", drink.toMap(),
          where: "drink_id = ?", whereArgs: [drinkId]);
    }
    return drinkId;
  }

  @override
  Future<void> addDrinkOrderToDB(String userId, String shopName,
      String threadTs, int drinkId, String orderTs) async {
    Database db = await openDB();
    await db.insert(
      "DrinkOrder",
      {
        "user_id": userId,
        "shop_name": shopName,
        "thread_ts": threadTs,
        "drink_id": drinkId,
        "order_ts": orderTs,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    await db.update("DrinkOrder", {"updated_date": "datetime('now')"},
        where: "drink_id = ?", whereArgs: [drinkId]);
  }

  @override
  Future<List<String>> getOrderTsList(String shopName, String threadTs,
      {String orderTs}) async {
    Database db = await openDB();
    List<Map<String, dynamic>> results = await db.query("DrinkOrder",
        columns: ["order_ts"],
        where: "shop_name = ? AND thread_ts = ?",
        whereArgs: [shopName, threadTs]);
    List<String> orderTsList = List.from(results.expand((map) => map.values));
    return orderTsList;
  }

  @override
  Future<Map<String, dynamic>> getLocalDrinkData(
      {int drinkId, String shopName, String threadTs, String orderTs}) async {
    List<String> columns = [
      "name",
      "price",
      "ice",
      "sugar",
      "pearl",
      "coconut",
      "cup_size",
      "other_ingredient",
    ];
    Database db = await openDB();
    Map<String, dynamic> result;
    List<Map<String, dynamic>> results;
    if (drinkId != null) {
      results = await db.query(
        "Drink",
        columns: columns,
        where: "drink_id = ?",
        whereArgs: [drinkId],
        limit: 1,
      );
    } else if (orderTs != null) {
      results = await db.rawQuery("""
    SELECT Drink.name, price, ice, sugar, pearl, coconut, cup_size, other_ingredient FROM Drink 
    JOIN DrinkOrder ON Drink.drink_id = DrinkOrder.drink_id WHERE 
    DrinkOrder.shop_name = ? AND DrinkOrder.thread_ts = ? AND DrinkOrder.order_ts = ?;
    """, [shopName, threadTs, orderTs]);
    }
    result = Utils.isListNullOrEmpty(results) ? null : results.first;
    return result;
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
        CREATE TABLE DrinkOrder (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT, shop_name TEXT, thread_ts TEXT, drink_id INTEGER, order_ts TEXT, created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')), FOREIGN KEY (user_id) REFERENCES User (user_id), FOREIGN KEY (shop_name, thread_ts) REFERENCES Shop (shop_name, thread_ts), FOREIGN KEY (drink_id) REFERENCES Drink (drink_id))
        """);

    await db.execute("""
        CREATE TRIGGER on_drink_order_updated AFTER UPDATE ON DrinkOrder
         BEGIN UPDATE DrinkOrder SET updated_date = datetime('now') WHERE id = new.id;
         END
        """);
  }
}
