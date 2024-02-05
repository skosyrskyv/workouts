import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  /// Get only date as String
  String getDate({String format = 'dd-MM-YYYY', String? locale}) {
    return DateFormat(format, locale).format(this);
  }

  /// Get only time as String
  String getTime() {
    return DateFormat('HH:mm').format(this);
  }
}
