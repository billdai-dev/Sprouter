import 'dart:async';

import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalRepo {
  Future<void> saveUserData(String id, String name, String token);

  Future<void> saveSlackToken(String token);

  Future<String> loadSlackToken();

  Future<String> loadUserId();

  Future<String> loadUserName();

  Future<String> loadJibbleChannelId();

  Future<void> saveJibbleChannelId(String channelId);

  Future<Database> openDB();

  Future<void> addShopToDB(String shopName, String threadTs);

  Future<int> addDrinkOrderToDB(String userId, String shopName, String threadTs,
      String orderTs, Drink drink);

  Future<int> queryDrinkId(String shopName, String threadTs, String orderTs,
      {String userId});

  Future<List<String>> getOrderTsList(String shopName, String threadTs,
      {String orderTs});

  Future<String> getOrderTs({int drinkId});

  Future<Map<String, dynamic>> getLocalDrinkData(
      {int drinkId, String shopName, String threadTs, String orderTs});

  Future<int> deleteDrinkOrderInDB(
      String userId, String shopName, String threadTs, String orderTs);

  Future<void> addFavoriteDrink(String userId, String shopName, int drinkId);

  Future<int> getFavoriteDrinkId(String userId, String shopName);
}
