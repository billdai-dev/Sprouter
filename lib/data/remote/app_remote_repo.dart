import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/remote/remote_repo.dart';

class AppRemoteRepo implements RemoteRepo {
  static final AppRemoteRepo _repo = AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  final Dio dio = Dio(Options(
      baseUrl: SLACK_API_DOMAIN, connectTimeout: 60, receiveTimeout: 60));

  String _slackToken;

  String get slackToken => _slackToken;

  static const String SLACK_API_DOMAIN = "slack.com";

  static const String CONVERSATION_HISTORY_PATH = "/api/conversation.history";

  AppRemoteRepo.internal(){
    dio.interceptor.request.onSend = (Options options) {
      options.headers.update(
          "token", (token) => _slackToken, ifAbsent: () => _slackToken);
      return options;
    };
  }

  @override
  void setSlackTokenCache(String token) {
    _slackToken = token;
  }

  @override
  Future<UserIdentity> getSlackUserData(String token) {
    return slack.getUserIdentity(token);
  }

  @override
  Future<Response<Message>> fetchLunchMessages(
      {String oldest, String latest, int count}) async {
    var query = {
      "channel": "CAZQ503L2",
      "oldest": oldest,
      "latest": latest,
      "count": count
    };
    return dio.get(CONVERSATION_HISTORY_PATH, data: query);
  }
}