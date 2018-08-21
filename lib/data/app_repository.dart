import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/remote/app_remote_repo.dart';
import 'package:sprouter/data/remote/remote_repo.dart';
import 'package:sprouter/data/repository.dart';

class AppRepository implements Repository {
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
  Future<String> getSlackUserData({String token}) {
    Future<String> tokenFuture = token == null
        ? _localRepo.loadSlackToken() : getFuture(token);
    return tokenFuture
        .then((token) {
      _remoteRepo.setSlackTokenCache(token);
      return _remoteRepo.getSlackUserData(token);
    })
        .then((user) => user?.user?.name);
  }

  Future<String> getFuture(String str) async {
    return str;
  }

  @override
  Future<Message> fetchLatestDrinkMessages() {
    return _remoteRepo.fetchLunchMessages()
        .then((conversationList) {
      BuiltList<Message> messages = conversationList.messages;
      Message orderBroadcastMessage = messages.firstWhere((message) =>
          message.text.contains("今天點的是"));
      String shopName = orderBroadcastMessage == null
          ? "" : (orderBroadcastMessage.text.split("："))[1];

      Message drinkMessage = messages.firstWhere((message) {
        if (message.files == null) {
          return false;
        }
        return message.files[0].title.contains(shopName);
      });
      return drinkMessage == null ? "" : drinkMessage.ts;
    })
        .then((drinkMessage_ts) =>
        _remoteRepo.fetchMessageReplies(drinkMessage_ts))
        .then((drinkThread) => drinkThread.messages[0]);
  }
}