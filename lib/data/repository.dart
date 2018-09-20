import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';

abstract class Repository {
  void setTokenCache(String token);

  Future<String> getTokenCache();

  Future<String> getSlackOAuthToken(String code);

  Future<String> getSlackUserData({String token});

  Future<BuiltList<Message>> fetchLatestDrinkMessages();

  Future<PostMessageResponse> orderDrink(String threadTs, String drink);
}
