import 'dart:async';

import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalRepo {
  Future<void> saveUserData(String id, String name, String token);

  Future<void> saveSlackToken(String token);

  Future<String> loadSlackToken();

  Future<String> loadUserId();

  Future<String> loadUserName();

  Future<Database> openDB();

  Future<void> addShopToDB(String shopName, String threadTs);

  Future<int> addDrinkToDB(Drink drink, {String threadTs, String orderTs});

  Future<void> addDrinkOrderToDB(
      String userId, String shopName, String threadTs, int drinkId);
}
