import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';

class TodayDrinkBloc {
  AppRepository repository;
  Message _drinkShopMessage;

  Message get drinkShopMessage => _drinkShopMessage;

  String get photoUrl => _drinkShopMessage?.files[0]?.urlPrivate;

  final BehaviorSubject<List<Message>> _drinkMessage =
      BehaviorSubject(seedValue: null);

  Stream<List<Message>> get drinkMessage => _drinkMessage.stream;

  final BehaviorSubject<bool> _isOrdering = BehaviorSubject(seedValue: false);

  Stream<bool> get isOrdering => _isOrdering.stream;

  final BehaviorSubject<String> _slackToken = BehaviorSubject(seedValue: null);

  Observable<String> get slackToken => _slackToken.stream;

  final StreamController<Null> _fetchMessage = StreamController<Null>();

  Sink<Null> get fetchMessage => _fetchMessage.sink;

  TodayDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream
        .transform(ThrottleStreamTransformer(Duration(seconds: 3)))
        .listen((_) async {
      List<Message> drinkThread =
          await this.repository.fetchLatestDrinkMessages();
      _drinkShopMessage =
          drinkThread == null || drinkThread.isEmpty ? null : drinkThread[0];

      List<Message> orderKeywords = drinkThread.where((message) {
        return message.text == "點單" || message.text == "收單";
      }).toList(growable: false);

      _isOrdering.sink.add(orderKeywords.length.isOdd);
      _drinkMessage.sink.add(drinkThread.toList());

      String token = await this.repository.getTokenCache();
      _slackToken.sink.add(token);
    });
  }

  void dispose() {
    _isOrdering?.close();
    _slackToken?.close();
    _drinkMessage?.close();
    _fetchMessage?.close();
  }
}
