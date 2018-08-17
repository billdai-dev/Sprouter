import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sprouter/data/model/message.dart';

abstract class Repository {
  void setTokenCache(String token);

  Future<String> getSlackUserData({String token});

  Future<Response<Message>> getLunchConversations(
      {String oldest, String latest, int count});
}