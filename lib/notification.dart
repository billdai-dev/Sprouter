import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum NotificationEvent { CheckIn, PayOrder }

const String _checkInChannelId = "0";
const String _checkInChannelName = "下班打卡通知";
const String _checkInChannelDesc = "於 App 內開啟通知鈴鐺以啟用打卡提醒";
const int _checkInNotificationId = 0;

const String _payOrderChannelId = "1";
const String _payOrderChannelName = "支付飲料錢通知";
const String _payOrderChannelDesc = "";
const int _payOrderNotificationId = 1;

const String _notificationIcon = "ic_notification";
const List<String> _facialExpressions = [
  "(ﾟ∀ﾟ)",
  "ヽ(●´∀`●)ﾉ",
  "d(`･∀･)b",
  "(((ﾟдﾟ)))",
  "｡:.ﾟヽ(*´∀`)ﾉﾟ.:｡",
];

Future<bool> initializeNotificationSetting(
    {SelectNotificationCallback callback}) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings(_notificationIcon);
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  return flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: callback);
}

Future<dynamic> sendNotification(
    NotificationEvent event, String title, String body,
    {DateTime scheduledTime}) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String channelId, channelName, channelDesc;
  int notificationId;
  switch (event) {
    case NotificationEvent.CheckIn:
      channelId = _checkInChannelId;
      channelName = _checkInChannelName;
      channelDesc = _checkInChannelDesc;
      notificationId = _checkInNotificationId;
      break;
    case NotificationEvent.PayOrder:
      channelId = _payOrderChannelId;
      channelName = _payOrderChannelName;
      channelDesc = _payOrderChannelDesc;
      notificationId = _payOrderNotificationId;
      break;
  }

  var androidPlatformChannelSpecifics =
      new AndroidNotificationDetails(channelId, channelName, channelDesc);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  String facialExpression =
      _facialExpressions[Random().nextInt(_facialExpressions.length)];
  body = "$body\n$facialExpression";
  if (scheduledTime == null) {
    return flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platformChannelSpecifics,
        payload: event.toString());
  } else {
    return flutterLocalNotificationsPlugin.schedule(
        notificationId, title, body, scheduledTime, platformChannelSpecifics,
        payload: event.toString());
  }
}

Future<dynamic> cancelNotification(NotificationEvent event) {
  int notificationId;
  switch (event) {
    case NotificationEvent.CheckIn:
      notificationId = _checkInNotificationId;
      break;
    case NotificationEvent.PayOrder:
      notificationId = _payOrderNotificationId;
      break;
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  return flutterLocalNotificationsPlugin.cancel(notificationId);
}
