import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';

class SlackAuthBloc {
  final String _slackClientId = "373821001234.373821382898";
  final String _slackClientSecret = "f0ce30315c4689da519c5281883c0667";

  AppRepository repository;

  final BehaviorSubject<String> _userName = BehaviorSubject<String>(
      seedValue: null);

  Stream<String> get userName => _userName.stream;

  final StreamController<String> _onUserLogin = StreamController<String>();

  Sink<String> get onUserLogin => _onUserLogin.sink;

  SlackAuthBloc({AppRepository repository})
      :this.repository = repository ?? AppRepository.repo {
    _onUserLogin.stream.listen((token) async {
      String userName = await this.repository.getSlackUserData(token: token);
      _userName.sink.add(userName);
      /*repository.getSlackUserData(token: token).listen((userName) {
        _userName.sink.add(userName);
      });*/
    });
  }

  void dispose() {
    _userName?.close();
    _onUserLogin?.close();
  }
}