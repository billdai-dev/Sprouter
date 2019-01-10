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

  String get photoUrl => _drinkShopMessage?.getPhotoUrl;

  final BehaviorSubject<List<Message>> _drinkMessage =
      BehaviorSubject(seedValue: null);

  Stream<List<Message>> get drinkMessage => _drinkMessage.stream;

  final PublishSubject<int> _deleteMessage = PublishSubject();

  Sink<int> get deleteMessage => _deleteMessage.sink;

  final BehaviorSubject<bool> _isOrdering = BehaviorSubject(seedValue: false);

  Stream<bool> get isOrdering => _isOrdering.stream;

  final StreamController<void> _fetchMessage = StreamController();

  Sink<void> get fetchMessage => _fetchMessage.sink;

  final StreamController<void> _forceFetchMessage = StreamController();

  Sink<void> get forceFetchMessage => _forceFetchMessage.sink;

  final PublishSubject<bool> _showMoreContentIndicator = PublishSubject();

  StreamController<bool> get showMoreContentIndicator =>
      _showMoreContentIndicator;

  TodayDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _fetchMessage.stream
        .transform(ThrottleStreamTransformer(Duration(seconds: 15)))
        .listen(_handleFetchingMessages);
    _forceFetchMessage.stream.listen(_handleFetchingMessages);
    _deleteMessage.stream.listen(_handleDeletingMessage);

    //Initialization
    _fetchMessage.add(null);
  }

  void payForOrder(int itemIndex) {
    repository
        .setDrinkOrderPaid(
            _drinkShopMessage?.getShopName,
            _drinkShopMessage?.threadTs,
            _drinkMessages
                ?.skip(1)
                ?.elementAt(itemIndex)
                ?.ts) //index+1 because we exclude first item when displaying replies
        .then((response) {
      Message updatedMessage =
          _drinkMessages[itemIndex + 1].rebuild((b) => b..paid = true);
      _drinkMessages
          .replaceRange(itemIndex + 1, itemIndex + 2, [updatedMessage]);
      _drinkMessage.sink.add(_drinkMessages);
    });
  }

  void _handleFetchingMessages(void _) async {
    List<Message> newDrinkMessages;
    try {
      newDrinkMessages = await repository.fetchLatestDrinkMessages();
    } catch (error) {
      if (error is AuthError) {
        _drinkMessage.addError(AuthError(error.errorMsg));
        return;
      }
    }
    bool showNewContentIndicator = !Utils.isListEmpty(newDrinkMessages) &&
        !Utils.isListEmpty(_drinkMessages) &&
        newDrinkMessages.length > _drinkMessages.length;
    _showMoreContentIndicator.add(showNewContentIndicator);

    _drinkMessages = newDrinkMessages;
    _drinkShopMessage =
        Utils.isListEmpty(_drinkMessages) ? null : _drinkMessages[0];

    List<Message> orderKeywords = _drinkMessages?.where((message) {
      return message.text == "點單" || message.text == "收單";
    })?.toList(growable: false);
    bool isNowOrdering = orderKeywords != null &&
        orderKeywords.isNotEmpty &&
        orderKeywords.last.text == "點單";
    _isOrdering.sink.add(isNowOrdering);
    _drinkMessage.sink.add(_drinkMessages);
  }

  void _handleDeletingMessage(int index) {
    repository
        .deleteDrinkOrder(
            _drinkShopMessage?.getShopName,
            _drinkShopMessage?.threadTs,
            _drinkMessages?.skip(1)?.elementAt(index)?.ts)
        .then((response) {
      //index+1 because we exclude first item when displaying replies
      _drinkMessages?.removeAt(index + 1);
      _drinkMessage.sink.add(_drinkMessages);
    });
  }

  void dispose() {
    _isOrdering?.close();
    _drinkMessage?.close();
    _deleteMessage?.close();
    _fetchMessage?.close();
    _forceFetchMessage?.close();
    _showMoreContentIndicator?.close();
  }
}
