import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/message.dart';

abstract class Repository {
  void setTokenCache(String token);

  Future<String> getSlackUserData({String token});

  Future<Message> fetchLatestDrinkMessages();
}