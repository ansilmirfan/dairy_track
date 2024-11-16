class Utils {
  static String formatDate(DateTime date) {
    var day = date.day;
    var month = date.month;

    String formatedDate =
        '${day < 10 ? '0$day' : day}/${month < 10 ? '0$month' : month}/${date.year}';
    return formatedDate;
  }
}
