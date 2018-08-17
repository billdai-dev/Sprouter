import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:sprouter/data/model/message.dart';

abstract class RemoteRepo {
  void setSlackTokenCache(String token);

  Future<UserIdentity> getSlackUserData(String token);

  Future<Response<Message>> fetchLunchMessages(
      {String oldest, String latest, int count});
}