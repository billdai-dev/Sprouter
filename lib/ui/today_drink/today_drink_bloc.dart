import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/remote/api_error.dart';
import 'package:sprouter/util/utils.dart';

class TodayDrinkBloc {
  AppRepository repository;
  Message _drinkShopMessage;
  List<Message> _drinkMessages;

  Message get drinkShopMessage => _drinkShopMessage;

  String get photoUrl => _drinkShopMessage?.files[0]?.thumb800;

  final BehaviorSubject<List<Message>> _drinkMessage =
      BehaviorSubject(seedValue: null);

  Stream<List<Message>> get drinkMessage => _drinkMessage.stream;

  final PublishSubject<int> _deleteMessage = PublishSubject();

  Sink<int> get deleteMessage => _deleteMessage.sink;

  final BehaviorSubject<bool> _isOrdering = BehaviorSubject(seedValue: false);

  Stream<bool> get isOrdering => _isOrdering.stream;

  final BehaviorSubject<String> _slackToken = BehaviorSubject(seedValue: null);

  Observable<String> get slackToken => _slackToken.stream;

  final StreamController<void> _fetchMessage = StreamController();

  Sink<void> get fetchMessage => _fetchMessage.sink;

  final PublishSubject<bool> _showMoreContentIndicator = PublishSubject();

  StreamController<bool> get showMoreContentIndicator =>
      _showMoreContentIndicator;

  TodayDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream
        .transform(ThrottleStreamTransformer(Duration(seconds: 3)))
        .listen((_) async {
      List<Message> newDrinkMessages;
      try {
        newDrinkMessages = await this.repository.fetchLatestDrinkMessages();
      } catch (error) {
        if (error is ApiError && ApiError.authErrors.contains(error.errorMsg)) {
          _drinkMessage.addError(AuthError(error.errorMsg));
          return;
        }
      }
      bool showNewContentIndicator =
          !Utils.isListNullOrEmpty(newDrinkMessages) &&
              !Utils.isListNullOrEmpty(_drinkMessages) &&
              newDrinkMessages.length > _drinkMessages.length;
      _showMoreContentIndicator.add(showNewContentIndicator);

      _drinkMessages = newDrinkMessages;
      _drinkShopMessage =
          Utils.isListNullOrEmpty(_drinkMessages) ? null : _drinkMessages[0];

      List<Message> orderKeywords = _drinkMessages?.where((message) {
        return message.text == "點單" || message.text == "收單";
      })?.toList(growable: false);

      _isOrdering.sink.add(orderKeywords?.length?.isOdd);
      _drinkMessage.sink.add(_drinkMessages);

      String token = await this.repository.getTokenCache();
      _slackToken.sink.add(token);
    });
    _deleteMessage.stream.listen((index) {
      this
          .repository
          .deleteDrinkOrder(
            _drinkShopMessage?.getShopName,
            _drinkShopMessage?.threadTs,
            _drinkMessages?.skip(1)?.elementAt(index)?.ts,
          )
          .then((response) {
        //index+1 because we exclude first item when displaying message list
        _drinkMessages?.removeAt(index + 1);
        _drinkMessage.sink.add(_drinkMessages);
      });
    });

    //Initialization
    _fetchMessage.add(null);
  }

  void dispose() {
    _isOrdering?.close();
    _slackToken?.close();
    _drinkMessage?.close();
    _deleteMessage?.close();
    _fetchMessage?.close();
    _showMoreContentIndicator?.close();
  }
}
