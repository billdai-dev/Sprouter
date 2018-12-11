import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/model/conversation_history.dart';
import 'package:sprouter/data/model/conversation_list.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/model/slack/profile_response.dart';
import 'package:sprouter/data/model/slack/simple_identity_response.dart';
import 'package:sprouter/data/model/slack/slack_token.dart';
import 'package:sprouter/data/model/slack/user_list.dart';
import 'package:sprouter/data/remote/remote_repo.dart';
import 'package:sprouter/env_config.dart';

class AppRemoteRepo implements RemoteRepo {
  static String slackClientId = EnvConfig.slackClientId;
  static String slackClientSecret = EnvConfig.slackClientSecret;
  static const String slackRedirectUrl =
      "https://kunstmaan.github.io/flutter_slack_oauth/success.html";

  //static const String _lunchChannel = "CAZQ503L2";

  static const String _slackApiBaseUrl = "https://slack.com";

  static const String _authTest = "/api/auth.test";
  static const String _oauthAccessPath = "/api/oauth.access";
  static const String _usersListPath = "/api/users.list";
  static const String _usersProfile = "/api/users.profile.get";
  static const String _conversationListPath = "/api/conversations.list";
  static const String _conversationHistoryPath = "/api/conversations.history";
  static const String _conversationRepliesPath = "/api/conversations.replies";
  static const String _chatPostMessagePath = "/api/chat.postMessage";
  static const String _chatUpdatePath = "/api/chat.update";
  static const String _chatDeletePath = "/api/chat.delete";

  static final ContentType xWwwFormUrlencoded =
      ContentType.parse("application/x-www-form-urlencoded");

  static final AppRemoteRepo _repo = AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  final Dio dio = Dio(
    Options(
        baseUrl: _slackApiBaseUrl,
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
      "client_id": slackClientId,
      "client_secret": slackClientSecret,
      "redirect_uri": slackRedirectUrl,
    };
    Future<Response> response = dio.post(_oauthAccessPath,
        data: params,
        options: Options(
          headers: {"Authoriation": null},
          contentType: xWwwFormUrlencoded,
        ));
    Future<SlackToken> slackToken = response.then((response) {
      return SlackToken.fromJson(jsonEncode(Map.from(response.data)));
    });
    return slackToken;
  }

  @override
  Future<ProfileResponse> getUserProfile({String accessToken}) async {
    Future<Response> response = dio.get(
      _usersProfile,
      options: Options(contentType: xWwwFormUrlencoded),
    );
    Future<ProfileResponse> userIdentity = response.then((response) {
      return ProfileResponse.fromJson(jsonEncode(response.data));
    });
    return userIdentity;
  }

  @override
  Future<SimpleIdentityResponse> getSimpleIdentity({String accessToken}) {
    Future<Response> response = dio.get(_authTest);
    Future<SimpleIdentityResponse> userIdentity = response.then((response) {
      return SimpleIdentityResponse.fromJson(jsonEncode(response.data));
    });
    return userIdentity;
  }

  @override
  Future<UserListResponse> getUsers({String accessToken}) async {
    Future<Response> response = dio.get(_usersListPath);
    Future<UserListResponse> userList = response.then((response) {
      return UserListResponse.fromJson(jsonEncode(response.data));
    });
    return userList;
  }

  @override
  Future<ConversationList> fetchConversationList(String conversationType,
      {bool excludeArchived = true, int limit = 100}) {
    var params = {
      "exclude_archived": excludeArchived,
      "limit": limit,
      "types": conversationType ?? "im",
    };
    Future<Response> response = dio.get(
      _conversationListPath,
      data: params,
      options: Options(contentType: xWwwFormUrlencoded),
    );
    Future<ConversationList> conversationList = response.then((response) {
      return ConversationList.fromJson(jsonEncode(response.data));
    });
    return conversationList;
  }

  @override
  Future<ConversationHistory> fetchConversationHistory(String channel,
      {String oldest, String latest, int limit = 200}) {
    var query = {
      "channel": channel,
      "limit": limit,
      "oldest": oldest,
      "latest": latest,
    };
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(_conversationHistoryPath, data: query);
    Future<ConversationHistory> conversationList = response.then((response) {
      return ConversationHistory.fromJson(jsonEncode(response.data));
    });
    return conversationList;
  }

  @override
  Future<ConversationHistory> fetchMessageReplies(String channel, String ts) {
    var query = {
      "channel": channel,
      "ts": ts,
    };
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(_conversationRepliesPath, data: query);
    return response.then((response) {
      return ConversationHistory.fromJson(jsonEncode(response.data));
    });
  }

  @override
  Future<PostMessageResponse> postMessage(String channel, String text,
      {String ts}) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = channel;
      builder.threadTs = ts;
      builder.asUser = true;
      builder.text = text;
    });
    Future<Response> response =
        dio.post(_chatPostMessagePath, data: json.decode(request.toJson()));
    return response.then((response) {
      return PostMessageResponse.fromJson(jsonEncode(response.data));
    });
  }

  @override
  Future<UserListResponse> getTeamMemberProfile() {
    Future<Response> response = dio.get(
      _usersListPath,
      options: Options(contentType: xWwwFormUrlencoded),
    );
    return response.then(
        (response) => UserListResponse.fromJson(jsonEncode(response.data)));
  }

  @override
  Future<PostMessageResponse> updateMessage(
      String channel, String ts, String text) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = channel;
      builder.ts = ts;
      builder.asUser = true;
      builder.text = text;
    });
    Future<Response> response =
        dio.post(_chatUpdatePath, data: json.decode(request.toJson()));
    return response.then((response) {
      return PostMessageResponse.fromJson(jsonEncode(response.data));
    });
  }

  @override
  Future<PostMessageResponse> deleteMessage(String channel, String ts) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = channel;
      builder.ts = ts;
      builder.asUser = true;
    });
    Future<Response> response =
        dio.post(_chatDeletePath, data: json.decode(request.toJson()));
    return response.then((response) {
      return PostMessageResponse.fromJson(jsonEncode(response.data));
    });
  }
}
