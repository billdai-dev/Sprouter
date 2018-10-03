import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/slack_token.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';
import 'package:sprouter/data/model/slack/user_list.dart';
import 'package:sprouter/data/remote/remote_repo.dart';

class AppRemoteRepo implements RemoteRepo {
  static const String SLACK_CLIENT_ID = "373821001234.373821382898";
  static const String SLACK_CLIENT_SECRET = "f0ce30315c4689da519c5281883c0667";
  static const String SLACK_REDIRECT_URL =
      "https://kunstmaan.github.io/flutter_slack_oauth/success.html";
  static const String _LUNCH_CHANNEL = "CAZQ503L2";

  static const String _SLACK_API_BASE_URL = "https://slack.com";

  static const String _OAUTH_ACCESS_PATH = "/api/oauth.access";
  static const String _USERS_LIST_PATH = "/api/users.list";
  static const String _USERS_IDENTITY_PATH = "/api/users.identity";
  static const String _CONVERSATION_HISTORY_PATH = "/api/conversations.history";
  static const String _CONVERSATION_REPLIES_PATH = "/api/conversations.replies";
  static const String _CHAT_POST_MESSAGE_PATH = "/api/chat.postMessage";

  static final AppRemoteRepo _repo = AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  final Dio dio = Dio(
    Options(
        baseUrl: _SLACK_API_BASE_URL,
        connectTimeout: 60000,
        receiveTimeout: 60000),
  );

  String _slackToken;

  String get slackToken => _slackToken;

  AppRemoteRepo.internal() {
    dio.interceptor.request.onSend = (Options options) async {
      _slackToken ??= await AppLocalRepo.repo.loadSlackToken();
      options.headers.update("Authorization",
          (token) => _slackToken == null ? null : "Bearer $_slackToken",
          ifAbsent: () => _slackToken == null ? null : "Bearer $_slackToken");
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
  Future<SlackToken> getSlackOauthToken(String code) async {
    var params = {
      "code": code,
      "client_id": SLACK_CLIENT_ID,
      "client_secret": SLACK_CLIENT_SECRET,
      "redirect_uri": SLACK_REDIRECT_URL,
    };
    Future<Response> response = dio.post(_OAUTH_ACCESS_PATH,
        data: params,
        options: Options(
          headers: {"Authoriation": null},
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ));
    Future<SlackToken> slackToken = response.then((response) {
      return SlackToken.fromJson(jsonEncode(Map.from(response.data)));
    });
    return slackToken;
  }

  @override
  Future<UserIdentity> getUserIdentity({String accessToken}) async {
    Future<Response> response = dio.get(_USERS_IDENTITY_PATH);
    Future<UserIdentity> userIdentity = response.then((response) {
      return UserIdentity.fromJson(jsonEncode(response.data));
    });
    return userIdentity;
  }

  @override
  Future<UserList> getUsers({String accessToken}) async {
    Future<Response> response = dio.get(_USERS_LIST_PATH);
    Future<UserList> userList = response.then((response) {
      return UserList.fromJson(jsonEncode(response.data));
    });
    return userList;
  }

  @override
  Future<ConversationList> fetchLunchMessages(
      {String oldest, String latest, int limit = 200}) {
    var query = {
      "channel": _LUNCH_CHANNEL,
    };
    query.removeWhere((key, value) => value == null);
    Future<Response> response =
        dio.get(_CONVERSATION_HISTORY_PATH, data: query);
    Future<ConversationList> conversationList = response.then((response) {
      return ConversationList.fromJson(jsonEncode(response.data));
    });
    return conversationList;
  }

  @override
  Future<ConversationList> fetchMessageReplies(String ts) {
    var query = {"channel": _LUNCH_CHANNEL, "ts": ts};
    query.removeWhere((key, value) => value == null);
    Future<Response> response =
        dio.get(_CONVERSATION_REPLIES_PATH, data: query);
    return response.then((response) {
      return ConversationList.fromJson(jsonEncode(response.data));
    });
  }

  @override
  Future<PostMessageResponse> postMessage(String ts, String drink) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = _LUNCH_CHANNEL;
      builder.threadTs = ts;
      builder.asUser = true;
      builder.text = drink;
    });
    Future<Response> response =
        dio.post(_CHAT_POST_MESSAGE_PATH, data: json.decode(request.toJson()));
    return response.then((response) {
      return PostMessageResponse.fromJson(jsonEncode(response.data));
    });
  }
}
