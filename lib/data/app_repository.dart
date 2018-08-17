import 'dart:async';

import 'package:sprouter/data/repository.dart';
import 'package:sprouter/data/local/app_local_repo.dart';
import 'package:sprouter/data/local/local_repo.dart';
import 'package:sprouter/data/remote/app_remote_repo.dart';
import 'package:sprouter/data/remote/remote_repo.dart';

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
  Future<String> getSlackUserData({String token}) {
    Future<String> tokenFuture = token == null
        ? _localRepo.loadSlackToken() : getFuture(token);
    return tokenFuture
        .then((token) => _remoteRepo.getSlackUserData(token))
        .then((user) => user?.user?.name);
  }

  Future<String> getFuture(String str) async {
    return str;
  }
}