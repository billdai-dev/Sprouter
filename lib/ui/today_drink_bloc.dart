import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';

class TodayDrinkBloc {
  AppRepository repository;

  final BehaviorSubject<Message> _drinkMessage = BehaviorSubject(
      seedValue: null);

  Stream<Message> get drinkMessage => _drinkMessage.stream;

  final StreamController<Null> _fetchMessage = StreamController<Null>();

  Sink<Null> get fetchMessage => _fetchMessage.sink;

  TodayDrinkBloc({AppRepository repository})
      :this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream.listen((_) async {
      Message message = await this.repository.fetchLatestDrinkMessages();
      _drinkMessage.sink.add(message);
    });
  }

  void dispose() {
    _drinkMessage?.close();
    _fetchMessage?.close();
  }
}