import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class LocalRepo{
  Observable<String> saveSlackToken(String token);

  Observable<String> loadSlackToken();
}