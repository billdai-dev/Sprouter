import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/util/utils.dart';

class TodayDrinkBloc {
  AppRepository repository;
  Message _drinkShopMessage;
  List<Message> _drinkMessages;

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

  final PublishSubject<bool> _showMoreContentIndicator = PublishSubject();

  StreamController<bool> get showMoreContentIndicator =>
      _showMoreContentIndicator;

  TodayDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream
        .transform(ThrottleStreamTransformer(Duration(seconds: 3)))
        .listen((_) async {
      List<Message> newDrinkMessages =
          await this.repository.fetchLatestDrinkMessages();
      bool showNewContentIndicator =
          !Utils.isListNullOrEmpty(newDrinkMessages) &&
              !Utils.isListNullOrEmpty(_drinkMessages) &&
              newDrinkMessages.length > _drinkMessages.length;
      _drinkMessages = newDrinkMessages;
      _drinkShopMessage = _drinkMessages == null || _drinkMessages.isEmpty
          ? null
          : _drinkMessages[0];

      List<Message> orderKeywords = _drinkMessages.where((message) {
        return message.text == "點單" || message.text == "收單";
      }).toList(growable: false);

      _isOrdering.sink.add(orderKeywords.length.isOdd);
      _drinkMessage.sink.add(_drinkMessages);

      String token = await this.repository.getTokenCache();
      _slackToken.sink.add(token);
      _showMoreContentIndicator.add(showNewContentIndicator);
    });
  }

  void dispose() {
    _isOrdering?.close();
    _slackToken?.close();
    _drinkMessage?.close();
    _fetchMessage?.close();
    _showMoreContentIndicator?.close();
  }
}
