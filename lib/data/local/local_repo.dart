import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class LocalRepo {
  Future<void> saveUserData(String id, String name, String token);

  Future<void> saveSlackToken(String token);

  Future<String> loadSlackToken();

  Future<Database> openDB();

  Future<void> addShopToDB(String shopName, String threadTs);
}
