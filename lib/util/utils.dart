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
}
