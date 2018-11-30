class Utils {
  static bool isStringNullOrEmpty(String str) => str == null || str.isEmpty;

  static bool isListNullOrEmpty(List list) => list == null || list.isEmpty;

  static bool isMapNullOrEmpty(Map map) => map == null || map.isEmpty;

  static String convertTimestamp({int seconds, int milliseconds}) {
    milliseconds ??= seconds * 1000;
    String time = DateTime.fromMillisecondsSinceEpoch(milliseconds).toString();
    return time.substring(0, time.lastIndexOf(":"));
  }

  static String getTimeDeltaStatement(DateTime dateTime1,
      {DateTime dateTime2}) {
    if (dateTime1 == null) {
      return "";
    }
    dateTime2 ??= DateTime.now();

    Duration delta = dateTime1.difference(dateTime2).abs();
    if (delta.inDays != 0) {
      return "${delta.inDays} 天前";
    }
    if (delta.inHours != 0) {
      return "${delta.inHours} 小時前";
    }
    if (delta.inMinutes != 0) {
      return "${delta.inMinutes} 分鐘前";
    }
    if (delta.inSeconds != 0) {
      return "${delta.inSeconds} 秒前";
    }
    return "";
  }

  static String parseShopName(String fileTitle) {
    if (fileTitle == null) {
      return "";
    }
    String title = fileTitle?.split(" ")[1];
    String modifiedTitle = title.toLowerCase();
    final String gap = "門檻";
    int gapIndex = modifiedTitle.indexOf(gap);
    final String tel = modifiedTitle.contains("電話") ? "電話" : "tel";
    int telIndex = modifiedTitle.indexOf(tel);
    String shopName;
    if (gapIndex == -1 && gapIndex == -1) {
      shopName = title;
    } else if (gapIndex != -1 && telIndex == -1) {
      shopName = title.replaceRange(gapIndex, title.length, "");
    } else if (gapIndex == -1 && telIndex != -1) {
      shopName = title.replaceRange(telIndex, title.length, "");
    } else {
      int index = gapIndex < telIndex ? gapIndex : telIndex;
      shopName = title.replaceRange(index, title.length, "");
    }
    return shopName;
  }
}
