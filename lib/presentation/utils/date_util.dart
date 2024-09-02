import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateUtil {
  /// Displays a date picker dialog and returns the selected date.
  ///
  /// The `context` parameter is the build context of the widget that is displaying
  /// the dialog.
  ///
  /// The `initialDate` parameter is the initially selected date. If not provided,
  /// the current date is used.
  ///
  /// The `firstDate` parameter is the earliest selectable date. If not provided,
  /// a date 100 years ago from the current date is used.
  ///
  /// The `lastDate` parameter is the latest selectable date. If not provided,
  /// a date 5 years from the current date is used.
  ///
  /// Returns a `Future` that completes with the selected `DateTime` or `null` if
  /// the user cancels the dialog.
  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate:
          firstDate ?? DateTime.now().add(const Duration(days: 365 * -100)),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365 * 5)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }

  /// Formats the given `dateTime` to a string using the specified `format`.
  ///
  /// The `format` parameter is a string representing the format of the output
  /// string. The `dateTime` parameter is an optional `DateTime` object
  /// representing the time to be formatted.
  ///
  /// Returns a string representing the formatted `dateTime` or `null` if an
  /// error occurs.
  ///
  static String? formatTo(String format, DateTime? dateTime) {
    DateFormat df = DateFormat(format);
    try {
      if (dateTime != null) {
        return df.format(dateTime);
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  /// Formats the given `time` to a string representing how long ago it was.
  ///
  /// The `time` parameter is an optional `DateTime` object representing the time
  /// to be formatted. If it is `null`, the current time is used.
  ///
  /// Returns a string representing how long ago the given `time` was.

  static String formatTimeAgo(DateTime? time) {
    Duration difference = DateTime.now().difference(time ?? DateTime.now());
    // timeago.setLocaleMessages('id', timeago.FrMessages());
    return timeago.format(
      DateTime.now().subtract(difference),
      // locale: 'id',
    );
  }
}
