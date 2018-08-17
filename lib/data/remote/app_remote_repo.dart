import 'dart:async';

import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/remote/remote_repo.dart';

class AppRemoteRepo implements RemoteRepo {
  static final AppRemoteRepo _repo = AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  String _slackToken;

  String get slackToken => _slackToken;

  AppRemoteRepo.internal(){

  }

  @override
  void setSlackTokenCache(String token) {
    _slackToken = token;
  }

  @override
  Future<UserIdentity> getSlackUserData(String token) {
    return slack.getUserIdentity(token);
  }
}