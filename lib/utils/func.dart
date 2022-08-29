class Functions {

  static String getDateTimeString(int? time) {
    return DateTime.fromMillisecondsSinceEpoch(time??0 * 1000).toString().substring(0,10);
  }
}
