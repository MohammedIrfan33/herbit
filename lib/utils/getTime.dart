// ignore: file_names
import 'package:intl/intl.dart';

String getTime(int milliseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}