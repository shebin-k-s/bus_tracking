
import 'package:intl/intl.dart';

String convertToISTAndAddTime(DateTime utcDate, int seconds) {
  final istDate = utcDate.toUtc().add(const Duration(hours: 5, minutes: 30));

  final updatedDate = istDate.add(Duration(seconds: seconds));


  return DateFormat('hh:mm a').format(updatedDate);
}
