import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';

class SlackLoginBloc {
  String token;

  final StreamController<void> _initData = StreamController();

  final BehaviorSubject<String> _getTokenCache =
      BehaviorSubject(seedValue: null);

  Stream<String> get getTokenCache => _getTokenCache.stream;

  AppRepository repository;

  SlackLoginBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _initData.stream.listen((_) async {
      String tokenCache = await this.repository.getTokenCache();
      _getTokenCache.sink.add(tokenCache);
    });
    _initData.add(null);
  }

  Future<String> getSlackOauthToken(String code) async {
    String token = await repository.fetchSlackToken(code);
    this.token = token;
    _getTokenCache.sink.add(token);
    return token;
  }

  String getSlackClientId() => AppRepository.CLIENT_ID;

  String getSlackRedirectUrl() => AppRepository.REDIRECT_URL;

  void dispose() {
    _initData?.close();
    _getTokenCache?.close();
  }
}
