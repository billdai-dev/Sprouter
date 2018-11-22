import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';

class CheckInBloc {
  final BehaviorSubject<List<Message>> _jibbleRecords = BehaviorSubject();

  Stream<List<Message>> get jibbleRecords => _jibbleRecords.stream;

  final BehaviorSubject<String> _latestJibbleTimestamp = BehaviorSubject();

  Stream<String> get latestJibbleTimestamp => _latestJibbleTimestamp.stream;

  final BehaviorSubject<String> _latestJibbleText = BehaviorSubject();

  Stream<String> get latestJibbleText => _latestJibbleText.stream;

  Observable<List<String>> get latestJibbleTextTimestamp => _latestJibbleText
      .zipWith(_latestJibbleTimestamp.stream, (text, ts) => [text, ts]);

  AppRepository repository;

  CheckInBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    fetchLatestJibbleMessage();
  }

  void fetchLatestJibbleMessage() {
    Future.delayed(Duration(milliseconds: 300))
        .then((_) => repository.fetchLatestJibbleMessage().then((messages) {
              messages = messages.where((message) {
                if (message.user == AppRepository.jibbleUserId) {
                  return message.text.contains("*jibbled in*") ||
                      message.text.contains("*jibbled out*");
                } else {
                  return message.text == "in" || message.text == "out";
                }
              }).toList(growable: false);
              _jibbleRecords.sink.add(messages);

              Message latest = messages.first;
              _latestJibbleTimestamp.add(latest?.ts?.split(".")[0]);
              _latestJibbleText.add(latest?.text);
            }));
  }

  Future<bool> checkInOrOut(bool checkIn) async {
    bool success = await repository.checkInOrOut(checkIn);
    if (success != null && success) {
      fetchLatestJibbleMessage();
    }
    return success;
  }

  void dispose() {
    _jibbleRecords?.close();
    _latestJibbleTimestamp?.close();
    _latestJibbleText?.close();
  }
}
