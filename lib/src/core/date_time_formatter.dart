import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format([String pattern = 'dd.MM.yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormattingCustom(locale: locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}
