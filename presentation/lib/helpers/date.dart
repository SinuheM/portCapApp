// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

parseDate(dynamic value) {
  try {
    return DateFormat('yyyy-MM-dd').parse(value);
  } catch (e) {
    return null;
  }
}

parseDateToString(dynamic value) {
  if (value == '') return '';
  return DateFormat('yyyy-MM-dd').format(value as DateTime);
}
