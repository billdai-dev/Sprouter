import 'dart:async';

import 'package:dio/dio.dart';
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
  Future<Response<Message>> getLunchConversations(
      {String oldest, String latest, int count}) async {
    Response<Message> response = await _remoteRepo.fetchLunchMessages(
        oldest: oldest, latest: latest, count: count).catchError((error) {
      print(error);
    });
    return response;
  }
}