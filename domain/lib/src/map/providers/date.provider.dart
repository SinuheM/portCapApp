import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DateProvider {
  static String keyName = 'date_update';
  static String updateConfigDateKey = 'date_config';
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> save(DateTime dateTime) async {
    String dateTimeString = dateTime.toIso8601String();
    await storage.write(key: keyName, value: dateTimeString);
  }

  Future<void> saveConfigDate(DateTime dateTime) async {
    String dateTimeString = dateTime.toIso8601String();
    await storage.write(key: updateConfigDateKey, value: dateTimeString);
  }

  Future<DateTime?> read() async {
    String? dateTimeString = await storage.read(key: keyName);
    if (dateTimeString != null) {
      return DateTime.parse(dateTimeString);
    }
    return null;
  }

  Future<DateTime?> readConfigDate() async {
    String? dateTimeString = await storage.read(key: updateConfigDateKey);
    if (dateTimeString != null) {
      return DateTime.parse(dateTimeString);
    }
    return null;
  }
}
