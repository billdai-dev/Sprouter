import 'dart:async';

import 'package:sprouter/data/app_repository.dart';

class SlackLoginBloc {
  AppRepository repository;

  SlackLoginBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo;

  Future<String> getSlackOauthToken(String code) {
    return repository.getSlackOAuthToken(code);
  }

  String getSlackClientId() => AppRepository.CLIENT_ID;

  String getSlackRedirectUrl() => AppRepository.REDIRECT_URL;

  void dispose() {}
}
