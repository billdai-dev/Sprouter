import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/message.dart';

abstract class RemoteRepo {
  void setSlackTokenCache(String token);

  Future<UserIdentity> getSlackUserData(String token);

  Future<ConversationList> fetchLunchMessages(
      {String oldest, String latest, int limit});

  Future<ConversationList> fetchMessageReplies(String ts);
}
