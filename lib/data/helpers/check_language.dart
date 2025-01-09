import 'package:coolappflutter/data/locals/shared_pref.dart';

class LocaleChecker {
  /// Retrieves the current locale and returns a string representation of the locale code.
  ///
  /// The locale code is "0" for "id_ID" and "1" for "en_US". If the locale is neither "id_ID" nor "en_US",
  /// the default value "0" is returned.
  ///
  /// Returns:
  ///   A string representing the locale code.
  ///
  /// Throws:
  ///   None.
  Future<String> cekLocale() async {
    String locale = await Prefs().getLocale();

    if (locale == "id_ID") {
      return "0";
    } else if (locale == "en_US") {
      return "1";
    } else if (locale == "ar_AR") {
      return "2";
    } else if (locale == "zh_CN") {
      return "3";
    } else if (locale == "es_ES") {
      return "4";
    } else if (locale == "ms_MY") {
      return "5";
    } else if (locale == "ru_RU") {
      return "6";
    } else if (locale == "tr_TR") {
      return "7";
    } else {
      // Default value if locale is not "id_ID" or "en_US"
      return "0";
    }
  }

  // Retrieves the current locale and returns a string representation of the locale code.
  //
  // Returns:
  //   A string representing the locale code.
  //
  Future<String> cekLocaleV2() async {
    String locale = await Prefs().getLocale();

    if (locale == "id_ID") {
      return "id-ID";
    } else if (locale == "en_US") {
      return "en-US";
    } else if (locale == "ar_AR") {
      return "ar-AR";
    } else if (locale == "zh_CN") {
      return "zh-CN";
    } else if (locale == "es_ES") {
      return "es-ES";
    } else if (locale == "ms_MY") {
      return "ms-MY";
    } else if (locale == "ru_RU") {
      return "ru-RU";
    } else if (locale == "tr_TR") {
      return "tr-TR";
    } else {
      // Default value if locale is not "id_ID" or "en_US"
      return "id-ID";
    }
  }

  /// Retrieves the current locale and returns a boolean value indicating whether the locale is "id_ID".
  Future<bool> cekLocaleIsIndonesia() async {
    String locale = await Prefs().getLocale();

    if (locale == "id_ID") {
      return true;
    } else if (locale == "en_US") {
      return false;
    } else if (locale == "ar_AR") {
      return false;
    } else if (locale == "zh_CN") {
      return false;
    } else if (locale == "es_ES") {
      return false;
    } else if (locale == "ms_MY") {
      return false;
    } else if (locale == "ru_RU") {
      return false;
    } else if (locale == "tr_TR") {
      return false;
    } else {
      // Default value if locale is not "id_ID" or "en_US"
      return false;
    }
  }
}
