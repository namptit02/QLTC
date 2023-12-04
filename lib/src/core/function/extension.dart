extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }


}

extension DateTimeExtension on DateTime {
  DateTime formatToDate() {
    return DateTime(year, month, day);
  }
}
