import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';

class CheckInBloc {
  final BehaviorSubject<List<Message>> _jibbleRecords = BehaviorSubject();

  Stream<List<Message>> get jibbleRecords => _jibbleRecords.stream;

  final BehaviorSubject<String> _latestJibbleTimestamp = BehaviorSubject();

  Stream<String> get latestJibbleTimestamp => _latestJibbleTimestamp.stream;

  final BehaviorSubject<bool> _latestCheckInStatus = BehaviorSubject();

  Stream<bool> get latestCheckInStatus => _latestCheckInStatus.stream;

  final BehaviorSubject<bool> showCheckInBtn = BehaviorSubject();

  Observable<Map<bool, String>> get latestJibbleStatus => _latestCheckInStatus
      .zipWith(_latestJibbleTimestamp, (isCheckedIn, ts) => {isCheckedIn: ts});

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
              bool latestCheckInStatus = latest?.text?.contains("in");
              bool shouldShowCheckInBtn = !latestCheckInStatus;

              _latestJibbleTimestamp.add(latest?.ts?.split(".")[0]);
              _latestCheckInStatus.add(latestCheckInStatus);
              showCheckInBtn.add(shouldShowCheckInBtn);
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
    _latestCheckInStatus?.close();
    showCheckInBtn?.close();
  }
}
