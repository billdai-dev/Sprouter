import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class LocalRepo {
  Future<void> saveSlackToken(String token);

  Future<String> loadSlackToken();
}
