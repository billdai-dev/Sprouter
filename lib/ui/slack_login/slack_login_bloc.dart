import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/slack/profile.dart';

class SlackLoginBloc {
  String token;

  final StreamController<void> _initData = StreamController();

  final BehaviorSubject<String> _getTokenCache = BehaviorSubject();

  Stream<String> get getTokenCache => _getTokenCache.stream;

  final BehaviorSubject<String> _getUserAvatarUrl = BehaviorSubject();

  Stream<String> get getUserAvatarUrl => _getUserAvatarUrl.stream;

  AppRepository repository;

  SlackLoginBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _initData.stream.listen((_) async {
      String tokenCache = await this.repository.getTokenCache();
      _getTokenCache.sink.add(tokenCache);
      Profile profile = await this.repository.getUserProfile();
      _getUserAvatarUrl.sink.add(profile?.image72);
    });
    _initData.add(null);
  }

  Future<String> getSlackOauthToken(String code) async {
    String token = await repository.fetchSlackToken(code);
    Profile profile = await this.repository.getUserProfile();
    _getUserAvatarUrl.sink.add(profile?.image72);

    this.token = token;
    _getTokenCache.sink.add(token);
    return token;
  }

  Future<void> clearLocalCache() {
    return repository.clearLocalCache();
  }

  String getSlackClientId() => AppRepository.clientId;

  String getSlackRedirectUrl() => AppRepository.redirectUrl;

  void dispose() {
    _initData?.close();
    _getTokenCache?.close();
    _getUserAvatarUrl?.close();
  }
}
