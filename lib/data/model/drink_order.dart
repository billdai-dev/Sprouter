class DrinkOrder {
  int id;
  String userId;
  String shopName;
  String threadTs;
  int drinkId;
  String orderTs;
  bool paid;

  DrinkOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map["id"];
    userId = map["user_id"];
    shopName = map["shop_name"];
    threadTs = map["thread_ts"];
    drinkId = map["drink_id"];
    orderTs = map["order_ts"];
    int paid = map["paid"];
    this.paid = paid == null ? false : paid == 1;
  }
}
