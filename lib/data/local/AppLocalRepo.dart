import 'package:flutter_slack_oauth/oauth/model/token.dart';
import 'package:sprouter/data/local/LocalRepo.dart';

class AppLocalRepo implements LocalRepo {
  static final AppLocalRepo _repo = new AppLocalRepo.internal();

  static AppLocalRepo get repo => _repo;

  AppLocalRepo.internal();

  @override
  void saveSlackToken(String token) async {
    Token.getLocalAccessToken();
  }

}