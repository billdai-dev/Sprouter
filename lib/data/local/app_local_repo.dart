import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprouter/data/local/local_repo.dart';

class AppLocalRepo implements LocalRepo {
  static const String _KEY_SLACK_ACCESS_TOKEN = "slack_access_token";

  static final AppLocalRepo _repo = new AppLocalRepo.internal();

  static AppLocalRepo get repo => _repo;

  AppLocalRepo.internal();

  @override
  Future<void> saveSlackToken(String token) async {
    return SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setString(_KEY_SLACK_ACCESS_TOKEN, token));
  }

  @override
  Future<String> loadSlackToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(_KEY_SLACK_ACCESS_TOKEN);
    return accessToken;
  }
}
