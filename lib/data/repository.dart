import 'dart:async';

import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/model/post_message.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';

abstract class Repository {
  Future<String> getTokenCache();

  Future<String> fetchSlackToken(String code);

  Future<List<Message>> fetchLatestDrinkMessages();

  Future<PostMessageResponse> orderDrink(
      String shopName, String threadTs, Drink drink,
      {String orderTs});

  Future<Drink> getLocalDrinkData(
      {int drinkId, String shopName, String threadTs, String orderTs});
}
