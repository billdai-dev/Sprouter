import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class LocalRepo{
  Future<String> saveSlackToken(String token);

  Future<String> loadSlackToken();
}