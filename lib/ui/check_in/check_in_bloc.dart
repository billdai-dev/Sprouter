import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/notification.dart';

class CheckInBloc {
  final BehaviorSubject<List<Message>> _jibbleRecords = BehaviorSubject();

  Stream<List<Message>> get jibbleRecords => _jibbleRecords.stream;

  final BehaviorSubject<String> _latestJibbleTimestamp = BehaviorSubject();

  Stream<String> get latestJibbleTimestamp => _latestJibbleTimestamp.stream;

  final BehaviorSubject<bool> _latestCheckInStatus = BehaviorSubject();

  Stream<bool> get latestCheckInStatus => _latestCheckInStatus.stream;

  Observable<Map<bool, String>> get latestJibbleStatus => _latestCheckInStatus
      .zipWith(_latestJibbleTimestamp, (isCheckedIn, ts) => {isCheckedIn: ts});

  final BehaviorSubject<bool> showCheckInBtn = BehaviorSubject();

  final BehaviorSubject<bool> _isReminderEnabled = BehaviorSubject();

  Stream<bool> get isReminderEnabled => _isReminderEnabled.stream;

  AppRepository repository;

  CheckInBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    fetchLatestJibbleMessage();
  }

  void fetchLatestJibbleMessage() {
    Future.delayed(Duration(milliseconds: 300)).then(
        (_) => repository.fetchLatestJibbleMessage().then((messages) async {
              messages = messages.where((message) {
                if (message.user != null) {
                  return message.text == "in" || message.text == "out";
                }
                return false;
                /*else {
                  return message.text == "in" || message.text == "out";
                }*/
              }).toList(growable: false);
              _jibbleRecords.sink.add(messages);

              Message latest = messages.first;
              bool latestCheckInStatus = latest?.text?.contains("in");
              bool shouldShowCheckInBtn = !latestCheckInStatus;

              _latestJibbleTimestamp.add(latest?.ts?.split(".")[0]);
              _latestCheckInStatus.add(latestCheckInStatus);
              showCheckInBtn.add(shouldShowCheckInBtn);

              bool isReminderEnabled =
                  await repository.getCheckInReminderStatus();
              await _setReminder(isReminderEnabled);
              _isReminderEnabled.sink.add(isReminderEnabled);
            }));
  }

  Future<bool> checkInOrOut(bool checkIn) async {
    bool success = await repository.checkInOrOut(checkIn);
    if (success != null && success) {
      fetchLatestJibbleMessage();
    }
    return success;
  }

  Future<void> changeReminderStatus(bool isEnabled) async {
    await repository.changeCheckInReminderStatus(isEnabled);
    await _setReminder(isEnabled);
    _isReminderEnabled.sink.add(isEnabled);
  }

  Future<void> _setReminder(bool isEnabled) {
    if (!isEnabled) {
      return cancelNotification();
    }
    bool latestCheckInStatus = _latestCheckInStatus.value;
    if (latestCheckInStatus == null || !latestCheckInStatus) {
      return cancelNotification();
    }
    String latestTimestamp = _latestJibbleTimestamp.value;
    if (latestTimestamp == null) {
      return null;
    }
    DateTime scheduledTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(latestTimestamp) * 1000)
            .add(Duration(hours: 8));
    DateTime now = DateTime.now();
    if (now.isAfter(scheduledTime)) {
      return null;
    }
    return scheduleNotification(
        scheduledTime, "Jibble reminder", "你今天 Jibble 了嗎？");
  }

  void dispose() {
    _jibbleRecords?.close();
    _latestJibbleTimestamp?.close();
    _latestCheckInStatus?.close();
    showCheckInBtn?.close();
    _isReminderEnabled?.close();
  }
}
