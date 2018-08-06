import 'package:flutter_slack_oauth/oauth/model/token.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/local/LocalRepo.dart';

class AppLocalRepo implements LocalRepo {
  static final AppLocalRepo _repo = new AppLocalRepo.internal();

  static AppLocalRepo get repo => _repo;

  AppLocalRepo.internal();

  @override
  Observable<String> saveSlackToken(String token) {
    return Observable.fromFuture(Token.storeAccessToken(token));
  }

  @override
  Observable<String> loadSlackToken() {
    return Observable.fromFuture(Token.getLocalAccessToken());
  }
}