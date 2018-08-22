import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';

class TodayDrinkBloc {
  AppRepository repository;

  final BehaviorSubject<BuiltList<Message>> _drinkMessage =
      BehaviorSubject(seedValue: null);

  Stream<BuiltList<Message>> get drinkMessage => _drinkMessage.stream;

  final BehaviorSubject<String> _slackToken = BehaviorSubject(seedValue: null);

  Observable<String> get slackToken => _slackToken.stream;

  final StreamController<Null> _fetchMessage = StreamController<Null>();

  Sink<Null> get fetchMessage => _fetchMessage.sink;

  TodayDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream.listen((_) async {
      BuiltList<Message> drinkThread =
          await this.repository.fetchLatestDrinkMessages();
      _drinkMessage.sink.add(drinkThread);

      String token = await this.repository.getTokenCache();
      _slackToken.sink.add(token);
    });
  }

  void dispose() {
    _drinkMessage?.close();
    _fetchMessage?.close();
  }
}
