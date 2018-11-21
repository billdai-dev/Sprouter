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
  static const String _keyJibbleChannelId = "jibbleChannelId";

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
  Future<String> loadJibbleChannelId() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(_keyJibbleChannelId));
  }

  @override
  Future<void> saveJibbleChannelId(String channelId) {
    return SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setString(_keyJibbleChannelId, channelId));
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
    await db?.insert("User", {"user_id": id, "name": name},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.update("User", {"name": name},
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
  Future<int> addDrinkOrderToDB(String userId, String shopName, String threadTs,
      String orderTs, Drink drink) async {
    Database db = await openDB();
    int drinkId =
        await queryDrinkId(shopName, threadTs, orderTs, userId: userId);
    await db.transaction((txn) async {
      if (drinkId == null) {
        drinkId = await txn.insert("Drink", drink.toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore);
      } else {
        await txn.update("Drink", drink.toMap(),
            where: "drink_id = ?", whereArgs: [drinkId]);
      }

      await txn.insert(
        "DrinkOrder",
        {
          "user_id": userId,
          "shop_name": shopName,
          "thread_ts": threadTs,
          "drink_id": drinkId,
          "order_ts": orderTs,
        },
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
      await txn.update("DrinkOrder", {"updated_date": "datetime('now')"},
          where: "drink_id = ?", whereArgs: [drinkId]);
    });
    return drinkId;
  }

  @override
  Future<int> queryDrinkId(String shopName, String threadTs, String orderTs,
      {String userId}) async {
    Database db = await openDB();
    userId ??= await loadUserId();

    Map<String, dynamic> drinkId;
    if (Utils.isStringNullOrEmpty(threadTs) ||
        Utils.isStringNullOrEmpty(orderTs)) {
      return null;
    }

    var drinkIds = await db.rawQuery("""
    SELECT Drink.drink_id FROM Drink JOIN DrinkOrder ON Drink.drink_id = DrinkOrder.drink_id
    WHERE DrinkOrder.user_id = ? AND DrinkOrder.shop_name = ? AND DrinkOrder.thread_ts = ? AND DrinkOrder.order_ts = ?;
    """, [userId, shopName, threadTs, orderTs]);
    drinkId = Utils.isListNullOrEmpty(drinkIds) ? null : drinkIds.first;
    return Utils.isMapNullOrEmpty(drinkId) ? null : drinkId["drink_id"];
  }

  @override
  Future<List<String>> getOrderTsList(String shopName, String threadTs,
      {String orderTs}) async {
    Database db = await openDB();
    List<Map<String, dynamic>> results = await db.query("DrinkOrder",
        columns: ["order_ts"],
        where: "shop_name = ? AND thread_ts = ?",
        whereArgs: [shopName, threadTs]);
    List<String> orderTsList = List.from(results?.expand((map) => map.values));
    return orderTsList;
  }

  @override
  Future<String> getOrderTs({int drinkId}) async {
    Database db = await openDB();
    List<Map<String, dynamic>> results = await db.query("DrinkOrder",
        columns: ["order_ts"], where: "drink_id = ?", whereArgs: [drinkId]);
    return Utils.isListNullOrEmpty(results) ? null : results.first["order_ts"];
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
        orderBy: "updated_date DESC",
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

  @override
  Future<int> deleteDrinkOrderInDB(
      String userId, String shopName, String threadTs, String orderTs) async {
    int drinkId =
        await queryDrinkId(shopName, threadTs, orderTs, userId: userId);

    if (drinkId == null) {
      return null;
    }
    Database db = await openDB();

    int count = await db.transaction((txn) async {
      int count1 = await txn
          .delete("DrinkOrder", where: "drink_id = ?", whereArgs: [drinkId]);
      int count2 = await txn
          .delete("Drink", where: "drink_id = ?", whereArgs: [drinkId]);
      return count1 | count2;
    });
    return count;
  }

  @override
  Future<void> addFavoriteDrink(
      String userId, String shopName, int drinkId) async {
    Database db = await openDB();

    int count = await db.update("FavoriteDrink", {"drink_id": drinkId},
        where: "user_id = ? AND shop_name = ?", whereArgs: [userId, shopName]);
    if (count > 0) {
      return;
    }
    await db?.insert(
        "FavoriteDrink",
        {
          "user_id": userId,
          "shop_name": shopName,
          "drink_id": drinkId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<int> getFavoriteDrinkId(String userId, String shopName) async {
    Database db = await openDB();
    Map<String, dynamic> result;
    List<Map<String, dynamic>> results;
    results = await db.query(
      "FavoriteDrink",
      columns: ["drink_id"],
      where: "user_id = ? AND shop_name = ?",
      whereArgs: [userId, shopName],
    );
    if (Utils.isListNullOrEmpty(results)) {
      return 0;
    }
    result = results.first;
    if (Utils.isMapNullOrEmpty(result)) {
      return 0;
    }
    return result["drink_id"];
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
        CREATE TABLE User(user_id TEXT PRIMARY KEY NOT NULL, name TEXT, 
        created_date TEXT DEFAULT (datetime('now')), updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TRIGGER on_user_updated AFTER UPDATE ON User
         BEGIN UPDATE User SET updated_date = datetime('now') WHERE user_id = new.user_id;
         END
        """);

    await db.execute("""
        CREATE TABLE Drink(drink_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, 
        price INTEGER, ice TEXT, sugar TEXT, pearl TEXT, coconut TEXT, cup_size TEXT, 
        other_ingredient TEXT, created_date TEXT DEFAULT (datetime('now')), 
        updated_date TEXT DEFAULT (datetime('now')))
        """);

    await db.execute("""
        CREATE TRIGGER on_drink_updated AFTER UPDATE ON Drink
         BEGIN UPDATE Drink SET updated_date = datetime('now') WHERE drink_id = new.drink_id;
         END
        """);

    await db.execute("""
        CREATE TABLE Shop(shop_name TEXT, thread_ts TEXT, 
        created_date TEXT DEFAULT (datetime('now')), 
        updated_date TEXT DEFAULT (datetime('now')), 
        PRIMARY KEY (shop_name, thread_ts))
        """);

    await db.execute("""
        CREATE TRIGGER on_shop_updated AFTER UPDATE ON Shop 
        BEGIN UPDATE Shop SET updated_date = datetime('now') 
        WHERE shop_name = new.shop_name AND thread_ts = new.thread_ts;
        END
        """);

    await db.execute("""
        CREATE TABLE DrinkOrder (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT, 
        shop_name TEXT, thread_ts TEXT, drink_id INTEGER, order_ts TEXT, 
        created_date TEXT DEFAULT (datetime('now')), 
        updated_date TEXT DEFAULT (datetime('now')), 
        FOREIGN KEY (user_id) REFERENCES User (user_id), 
        FOREIGN KEY (shop_name, thread_ts) REFERENCES Shop (shop_name, thread_ts), 
        FOREIGN KEY (drink_id) REFERENCES Drink (drink_id))
        """);

    await db.execute("""
        CREATE TRIGGER on_drink_order_updated AFTER UPDATE ON DrinkOrder 
        BEGIN UPDATE DrinkOrder SET updated_date = datetime('now') WHERE id = new.id;
        END
        """);
    await db.execute("""
        CREATE TABLE FavoriteDrink (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT, 
        shop_name TEXT, drink_id INTEGER, created_date TEXT DEFAULT (datetime('now')), 
        updated_date TEXT DEFAULT (datetime('now')), 
        FOREIGN KEY (user_id) REFERENCES User (user_id), 
        FOREIGN KEY (shop_name) REFERENCES Shop (shop_name), 
        FOREIGN KEY (drink_id) REFERENCES Drink (drink_id))
        """);
    await db.execute("""
        CREATE TRIGGER on_favorite_drink_updated AFTER UPDATE ON FavoriteDrink 
        BEGIN UPDATE FavoriteDrink SET updated_date = datetime('now') WHERE id = new.id;
        END
        """);
  }
}
