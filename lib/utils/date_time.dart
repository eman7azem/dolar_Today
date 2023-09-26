String convertToString(DateTime? inputDatetime) {
  if(inputDatetime != null){
    // Parse the input datetime string

    // Calculate the time difference
    Duration difference = DateTime.now().difference(inputDatetime);

    // Calculate the difference in minutes, hours, or days
    int minutesDifference = difference.inMinutes;
    int hoursDifference = difference.inHours;
    int daysDifference = difference.inDays;

    String formattedString;

    if (minutesDifference < 60) {
      formattedString = 'منذ $minutesDifference دقائق';
    } else if (hoursDifference < 24) {
      formattedString = 'منذ $hoursDifference ساعات';
    } else {
      formattedString = 'منذ $daysDifference أيام';
    }

    return formattedString;
  }
  return '';
}