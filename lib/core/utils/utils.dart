class Utils {
  static String formatDate(DateTime date) {
    var day = date.day;
    var month = date.month;

    String formatedDate =
        '${day < 10 ? '0$day' : day}/${month < 10 ? '0$month' : month}/${date.year}';
    return formatedDate;
  }

  static DateTime parseDate(String dateString) {
    List<String> parts = dateString.split("/");
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}
