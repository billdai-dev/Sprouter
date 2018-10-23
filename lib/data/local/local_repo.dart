import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalRepo {
  Future<Database> openDB();

  Future<void> saveSlackToken(String token);

  Future<String> loadSlackToken();
}
