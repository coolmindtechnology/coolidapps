import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class MoneyFormatter {
  static String? formatMoney(val, bool isIndonesia) {
    String? money;
    try {
      if (val != null) {
        if (val == "") {
          money = NumberFormat.currency(
            decimalDigits: 0,
            symbol: isIndonesia ? "IDR " : "IDR",
            locale: isIndonesia ? "id" : "en",
          ).format(double.parse("0"));
        } else if (val is String) {
          money = NumberFormat.currency(
            decimalDigits: 0,
            symbol: isIndonesia ? "IDR " : "IDR",
            locale: isIndonesia ? "id" : "en",
          ).format(double.parse(val));
        } else {
          double newVal = double.parse("$val");
          money = money = NumberFormat.currency(
            decimalDigits: 0,
            locale: isIndonesia ? "id" : "en",
            symbol: isIndonesia ? "IDR " : "IDR",
          ).format(newVal);
        }
      }
    } catch (e) {
      money = val;
      if (kDebugMode) {
        print("Error number $val");
      }
    }
    return money;
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  /// Converts a given value to a formatted currency string based on the provided
  /// [isIndonesia] flag.
  ///
  /// The [val] parameter can be either a numeric value, a string representation
  /// of a numeric value, or an empty string. If [val] is null or an empty string,
  /// the function returns a formatted currency string with a value of 0 and the
  /// appropriate currency symbol based on the [isIndonesia] flag.
  ///
  /// If [val] is a string, the function parses it into a double and formats it
  /// as a currency string with the appropriate currency symbol based on the
  /// [isIndonesia] flag.
  ///
  /// If [val] is a numeric value, the function formats it as a currency string
  /// with the appropriate currency symbol based on the [isIndonesia] flag.
  ///
  /// If an error occurs during the conversion process, the original [val] value
  /// is returned and an error message is printed to the console.
  ///
  /// Returns a formatted currency string or the original [val] value if an error
  /// occurs.
  ///
  /// Parameters:
  ///   - val: The value to convert to a currency string.
  ///   - isIndonesia: A boolean flag indicating whether to use the Indonesian Rupiah
  ///     currency symbol or the US dollar currency symbol.
  ///
  /// Returns:
  ///   - A formatted currency string or the original [val] value if an error occurs.
  static String? cconvertCurrency(val, bool isIndonesia) {
    String? money;
    try {
      if (val != null) {
        if (val == "") {
          money = NumberFormat.currency(
            // decimalDigits: 0,
            symbol: isIndonesia ? "IDR " : "USD",
            locale: isIndonesia ? "id" : "en",
          ).format(double.parse("0"));
        } else if (val is String) {
          money = NumberFormat.currency(
            // decimalDigits: 0,
            symbol: isIndonesia ? "IDR " : "USD",
            locale: isIndonesia ? "id" : "en",
          ).format(double.parse(val));
        } else {
          double newVal = double.parse("$val");
          money = money = NumberFormat.currency(
            // decimalDigits: 0,
            locale: isIndonesia ? "id" : "en",
            symbol: isIndonesia ? "IDR " : "USD",
          ).format(newVal);
        }
      }
    } catch (e) {
      money = val;
      if (kDebugMode) {
        print("Error number $val");
      }
    }
    return money;
  }
}
