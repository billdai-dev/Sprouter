import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';

abstract class Repository {
  Future<String> getTokenCache();

  Future<String> fetchSlackToken(String code);

  Future<List<Message>> fetchLatestDrinkMessages();

  Future<PostMessageResponse> orderDrink(String threadTs, String drink);
}
