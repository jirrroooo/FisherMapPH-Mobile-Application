class PSTDateFormat {
  String dateString(DateTime dateTime) {
    dateTime = dateTime.toUtc().add(const Duration(hours: 8));

    var mm = dateTime.month;
    var dd = dateTime.day;
    var yyyy = dateTime.year;
    var hrs = dateTime.hour;
    var min = dateTime.minute;
    var sec = dateTime.second;
    var am_pm = 'AM';

    if (hrs >= 12) {
      am_pm = 'PM';
      if (hrs > 12) {
        hrs -= 12;
      }
    } else if (hrs == 0) {
      hrs = 12;
    }

    String formattedToday = mm.toString().padLeft(2, '0') +
        "/" +
        dd.toString().padLeft(2, '0') +
        "/" +
        yyyy.toString() +
        ", " +
        hrs.toString().padLeft(2, '0') +
        ":" +
        min.toString().padLeft(2, '0') +
        ":" +
        sec.toString().padLeft(2, '0') +
        ' ' +
        am_pm;

    return formattedToday;
  }
}
