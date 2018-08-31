import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/remote/remote_repo.dart';

class AppRemoteRepo implements RemoteRepo {
  static final AppRemoteRepo _repo = AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  final Dio dio = Dio(Options(
      baseUrl: SLACK_API_BASE_URL,
      connectTimeout: 60000,
      receiveTimeout: 60000));

  String _slackToken;

  String get slackToken => _slackToken;

  static const String SLACK_API_BASE_URL = "https://slack.com";

  static const String CONVERSATION_HISTORY_PATH = "/api/conversations.history";
  static const String CONVERSATION_REPLIES_PATH = "/api/conversations.replies";

  AppRemoteRepo.internal() {
    dio.interceptor.request.onSend = (Options options) async {
      _slackToken ??= await Token.getLocalAccessToken();
      options.headers.update(
          "Authorization", (token) => "Bearer " + _slackToken,
          ifAbsent: () => "Bearer " + _slackToken);
      return options;
    };
    dio.interceptor.response.onError = (error) {
      print(error);
      return error;
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
  Future<ConversationList> fetchLunchMessages(
      {String oldest, String latest, int limit = 100}) {
    var query = {
      "channel": "CAZQ503L2",
    };
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(CONVERSATION_HISTORY_PATH, data: query);
    Future<ConversationList> conversationList = response.then((response) {
      return ConversationList.fromJson(json.encode(response.data));
    });
    return conversationList;
  }

  @override
  Future<ConversationList> fetchMessageReplies(String ts) {
    var query = {"channel": "CAZQ503L2", "ts": ts};
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(CONVERSATION_REPLIES_PATH, data: query);
    return response.then((response) {
      return ConversationList.fromJson(json.encode(response.data));
    });
  }
}
