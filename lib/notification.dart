import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String androidChannelId = "0";
const String androidChannelName = "下班打卡提醒";
const String androidChannelDesc = "於 App 內開啟通知鈴鐺以啟用打卡提醒";
const String notificationIcon = "ic_notification";
const int jibbleNotificationId = 1;
const List<String> facialExpressions = [
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
      AndroidInitializationSettings(notificationIcon);
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  return flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: callback);
}

Future<dynamic> scheduleNotification(
    DateTime scheduledTime, String title, String body,
    {int id = jibbleNotificationId}) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      androidChannelId, androidChannelName, androidChannelDesc);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  String facialExpression =
      facialExpressions[Random().nextInt(facialExpressions.length)];
  return flutterLocalNotificationsPlugin.schedule(id, title,
      "$body\n$facialExpression", scheduledTime, platformChannelSpecifics);
}

Future<dynamic> cancelNotification({int id = jibbleNotificationId}) {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  return flutterLocalNotificationsPlugin.cancel(id);
}
