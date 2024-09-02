import 'package:cool_app/presentation/utils/prefs_utils.dart';

class Prefs {
  // final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final PrefsUtils _pref = PrefsUtils();

  /// Saves the specified locale to the shared preferences.
  ///
  /// Parameters:
  /// - `locale`: The locale to be saved.
  /// - `onSuccess`: The function to be called when the locale is successfully saved.
  ///
  /// Returns:
  /// - `Future<void>`: A future that completes when the locale is saved.
  void setLocale(String locale, void Function() onSuccess) async {
    await _pref.save('locale', locale);
    onSuccess();
  }

  // Retrieves the current locale and returns the locale code as a string.
  Future<String> getLocale() async {
    String? locale = await _pref.get<String>('locale');

    locale ??= 'en_US';

    return locale;
  }

  /// Saves the specified token to the shared preferences.
  ///
  /// Parameters:
  /// - `token`: The token to be saved.
  ///
  /// Returns:
  /// - `Future<void>`: A future that completes when the token is saved.
  Future<void> setToken(String? token) async {
    await _pref.save('token', token);
  }

  /// Retrieves the token from the shared preferences.
  ///
  /// This function asynchronously retrieves the token from the shared preferences.
  /// It first retrieves the token from the shared preferences using the key 'token'.
  /// If the token is found, it is returned as a `String?`. If the token is not found,
  /// it returns `null`.
  ///
  /// Returns:
  /// - `Future<String?>`: A future that completes with the retrieved token, or `null` if not found.
  Future<String?> getToken() async {
    String? token = await _pref.get<String>('token');
    return token;
  }

  // Clears the session by calling the clearAll method on the shared preferences. Returns null.
  Future<String?> clearSession() async {
    await _pref.clearAll();
    return null;
  }
}
