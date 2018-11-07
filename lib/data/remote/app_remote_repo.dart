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
  static const String slackClientId = "373821001234.373821382898";
  static const String slackClientSecret = "f0ce30315c4689da519c5281883c0667";
  static const String slackRedirectUrl =
      "https://kunstmaan.github.io/flutter_slack_oauth/success.html";
  static const String _lunchChannel = "CAZQ503L2";

  static const String _slackApiBaseUrl = "https://slack.com";

  static const String _oauthAccessPath = "/api/oauth.access";
  static const String _usersListPath = "/api/users.list";
  static const String _usersIdentityPath = "/api/users.identity";
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
  Future<UserIdentity> getUserIdentity({String accessToken}) async {
    Future<Response> response = dio.get(_usersIdentityPath);
    Future<UserIdentity> userIdentity = response.then((response) {
      return UserIdentity.fromJson(jsonEncode(response.data));
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
  Future<ConversationList> fetchLunchMessages(
      {String oldest, String latest, int limit = 200}) {
    var query = {
      "channel": _lunchChannel,
    };
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(_conversationHistoryPath, data: query);
    Future<ConversationList> conversationList = response.then((response) {
      return ConversationList.fromJson(jsonEncode(response.data));
    });
    return conversationList;
  }

  @override
  Future<ConversationList> fetchMessageReplies(String ts) {
    var query = {"channel": _lunchChannel, "ts": ts};
    query.removeWhere((key, value) => value == null);
    Future<Response> response = dio.get(_conversationRepliesPath, data: query);
    return response.then((response) {
      return ConversationList.fromJson(jsonEncode(response.data));
    });
  }

  @override
  Future<PostMessageResponse> postMessage(String ts, String text) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = _lunchChannel;
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
  Future<PostMessageResponse> updateMessage(String ts, String text) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = _lunchChannel;
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
  Future<PostMessageResponse> deleteMessage(String ts) {
    PostMessageRequest request = PostMessageRequest((builder) {
      builder.channel = _lunchChannel;
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
