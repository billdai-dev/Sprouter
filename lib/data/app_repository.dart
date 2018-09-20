import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/data/remote/app_remote_repo.dart';
import 'package:sprouter/data/remote/remote_repo.dart';
import 'package:sprouter/data/repository.dart';

class AppRepository implements Repository {
  static const String CLIENT_ID = AppRemoteRepo.SLACK_CLIENT_ID;
  static const String REDIRECT_URL = AppRemoteRepo.SLACK_REDIRECT_URL;

  static final AppRepository _repo = AppRepository._internal();

  static AppRepository get repo => _repo;

  RemoteRepo _remoteRepo;
  LocalRepo _localRepo;

  AppRepository._internal() {
    _remoteRepo = AppRemoteRepo.repo;
    _localRepo = AppLocalRepo.repo;
  }

  @override
  void setTokenCache(String token) {
    _remoteRepo.setSlackTokenCache(token);
  }

  @override
  Future<String> getTokenCache() {
    return _localRepo.loadSlackToken();
  }

  @override
  Future<String> getSlackOAuthToken(String code) {
    Future<String> tokenFuture =
        _remoteRepo.getSlackOauthToken(code).then((slackToken) async {
      String token = slackToken?.accessToken;
      await _localRepo.saveSlackToken(token);
      return token;
    });
    return tokenFuture;
  }

  @override
  Future<String> getSlackUserData({String token}) {
    Future<String> tokenFuture =
        token == null ? _localRepo.loadSlackToken() : getFuture(token);
    return tokenFuture.then((token) {
      _remoteRepo.setSlackTokenCache(token);
      return _remoteRepo.getUserIdentity(accessToken: token);
    }).then((user) => user?.user?.name);
  }

  Future<String> getFuture(String str) async {
    return str;
  }

  @override
  Future<BuiltList<Message>> fetchLatestDrinkMessages() {
    const String ORDER_BROADCAST_KEYWORD = "今天點的是";

    return _remoteRepo
        .fetchLunchMessages()
        .then((conversationList) {
          BuiltList<Message> messages = conversationList.messages;
          Message orderBroadcastMessage = messages.firstWhere(
              (message) => message.text.contains(ORDER_BROADCAST_KEYWORD));
          String shopName = orderBroadcastMessage == null
              ? ""
              : (orderBroadcastMessage.text.split("："))[1];

          Message drinkMessage = messages.firstWhere((message) {
            if (message.files == null) {
              return false;
            }
            return message.files[0].title.contains(shopName);
          });
          return drinkMessage == null ? "" : drinkMessage.ts;
        })
        .then(
            (drinkMessageTs) => _remoteRepo.fetchMessageReplies(drinkMessageTs))
        .then((drinkThread) => drinkThread.messages);
  }

  @override
  Future<PostMessageResponse> orderDrink(String threadTs, String drink) {
    return _remoteRepo.postMessage(threadTs, drink);
  }
}
