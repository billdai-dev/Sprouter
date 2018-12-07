import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/slack/profile.dart';
import 'package:sprouter/data/model/slack/user_identity.dart';

class SlackLoginBloc {
  String token;

  final StreamController<void> _initData = StreamController();

  final BehaviorSubject<String> _getTokenCache = BehaviorSubject();

  Stream<String> get getTokenCache => _getTokenCache.stream;

  final BehaviorSubject<User> _getUser = BehaviorSubject();

  Stream<User> get getUser => _getUser.stream;

  AppRepository repository;

  SlackLoginBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _initData.stream.listen((_) async {
      String tokenCache = await this.repository.getTokenCache();
      _getTokenCache.sink.add(tokenCache);
      User user = await this.repository.getUser();
      _getUser.sink.add(user);
    });
    _initData.add(null);
  }

  Future<String> getSlackOauthToken(String code) async {
    String token = await repository.fetchSlackToken(code);
    this.token = token;
    _getTokenCache.sink.add(token);
    return token;
  }

  String getSlackClientId() => AppRepository.clientId;

  String getSlackRedirectUrl() => AppRepository.redirectUrl;

  void dispose() {
    _initData?.close();
    _getTokenCache?.close();
    _getUser?.close();
  }
}
