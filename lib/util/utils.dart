class Utils {
  static bool isStringNullOrEmpty(String str) => str == null || str.isEmpty;

  static bool isListNullOrEmpty(List list) => list == null || list.isEmpty;

  static bool isMapNullOrEmpty(Map map) => map == null || map.isEmpty;

  static String convertTimestamp({int seconds, int milliseconds}) {
    milliseconds ??= seconds * 1000;
    String time = DateTime.fromMillisecondsSinceEpoch(milliseconds).toString();
    return time.substring(0, time.lastIndexOf(":"));
  }
}
